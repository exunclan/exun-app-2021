import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:exun_app_21/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:http/http.dart';

import '../constants.dart';

class ScheduleScr extends StatefulWidget {
  const ScheduleScr({Key? key}) : super(key: key);

  @override
  _ScheduleScrState createState() => _ScheduleScrState();
}

List<Schedules> _schedules = <Schedules>[];

class _ScheduleScrState extends State<ScheduleScr> {
  CalendarController _controller = CalendarController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchSchedule(),
      builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting
          ? Center(
        child: CircularProgressIndicator(),
      )
          : RefreshIndicator(
        onRefresh: () {
          return fetchSchedule();
        }, child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.0),
        child: FutureBuilder(
          future: fetchSchedule(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              return Center(
                  child: SfCalendar(
                    view: CalendarView.day,
                    controller: _controller,
                    appointmentBuilder: (BuildContext context,
                        CalendarAppointmentDetails calendarAppointmentDetails) {
                      if (calendarAppointmentDetails.isMoreAppointmentRegion) {
                        return Container(
                          width: calendarAppointmentDetails.bounds.width,
                          height: calendarAppointmentDetails.bounds.height,
                          child: Text('+More'),
                        );
                      } else if (_controller.view == CalendarView.schedule) {
                        final Schedules appointment =
                            calendarAppointmentDetails.appointments.first;
                        return Container(
                            decoration: BoxDecoration(
                                // color: appointment.color,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                gradient: LinearGradient(
                                    colors: [Colors.red, Colors.cyan],
                                    begin: Alignment.centerRight,
                                    end: Alignment.centerLeft)),
                            alignment: Alignment.center,
                            // child: appointment.isAllDay
                            //     ? Text('${appointment.subject}',
                            //     textAlign: TextAlign.left,
                            //     style: TextStyle(
                            //         color: Colors.white, fontSize: 15))
                                child : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('${appointment.eventName}',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15)),
                                Text(
                                    '${(appointment.date)}',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 5))
                              ],
                            ));
                      } else {
                        final Appointment appointment =
                            calendarAppointmentDetails.appointments.first;
                        return Container(
                          width: calendarAppointmentDetails.bounds.width,
                          height: calendarAppointmentDetails.bounds.height,
                          child: Text(appointment.subject),
                        );
                      }
                    },
                  ),
              );
            }
            //   return Container(
            //         child: SfCalendar(
            //           onTap: calendarTapped,
            //           view: CalendarView.schedule,
            //           headerStyle: CalendarHeaderStyle(
            //               textStyle: TextStyle(fontSize: 0)
            //           ),
            //           scheduleViewSettings: ScheduleViewSettings(
            //             appointmentTextStyle: TextStyle(
            //               fontWeight: FontWeight.w700,
            //               height: 1.5,
            //               color: Colors.black
            //             ),
            //             appointmentItemHeight: 70,
            //             hideEmptyScheduleWeek: true,
            //           ),
            //           dataSource: ScheduleDataSource(snapshot.data),
            //         )
            //   );
            // }
            else {
              return Container(
                child: Center(
                  child: Text(''),
                ),
              );
            }
          },
        ),
      ),
      ),
    );
  }


  void calendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment ||
        details.targetElement == CalendarElement.agenda) {
      final Schedules appointmentDetails = details.appointments![0];
      String _subject = appointmentDetails.eventName;
      String _content = appointmentDetails.content;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Container(child: new Text('$_subject')),
              content: Container(
                height: 145,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: new Text(
                            '$_content',
                            // overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: new Text('close'))
              ],
            );
          });
    }
  }
}

Future<List<Schedules>> fetchSchedule() async {
  print("fetch");
  try {
    var uri = Uri.parse(getScheduleUrl);
    print(uri);
    var value = await get(uri);
    print("value");
    print(value);
    print("value");
    var parsed = json.decode(value.body);
    print(parsed);
    _schedules = parsed['rows']
        .map<Schedules>((json) => Schedules.fromJson(json))
        .toList();
    _schedules.sort((a, b) {
      Schedules x = a;
      Schedules y = b;
      return y.date.compareTo(x.date);
    });
    _schedules.removeWhere((element) => element.date.isBefore(DateTime.now()));
  } catch (e) {
    _schedules = [];
    print("error");
    print(e);
    print("error");
  }
  return _schedules;
}

class ScheduleDataSource extends CalendarDataSource {
  ScheduleDataSource(List<Schedules> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getSchedules(index).date;
  }

  @override
  DateTime getEndTime(int index) {
    return _getSchedules(index).date.add(const Duration(hours: 1));
  }

  @override
  String getSubject(int index) {
    return _getSchedules(index).eventName;
  }

  @override
  Color getColor(int index){
    return Color(0xFFeaeaea); //todo: change colors
  }

  String getContent(int index) {
    return _getSchedules(index).content;
  }

  Schedules _getSchedules(int index) {
    final dynamic schedule = appointments![index];
    late final Schedules scheduleData;
    if (schedule is Schedules) {
      scheduleData = schedule;
    }

    return scheduleData;
  }
}

class Schedules {
  String eventName;
  DateTime date;
  String content;

  Schedules(this.eventName, this.content, {required this.date});

  factory Schedules.fromJson(Map<String, dynamic> json) {
    return Schedules(
      json['name'],
      json['information'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() => {
    'name': eventName,
    'information': content,
    'date': date.toString(),
  };

}


