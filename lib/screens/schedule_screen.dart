import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:exun_app_21/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../constants.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

List<Schedule> _schedules = <Schedule>[];

class _ScheduleScreenState extends State<ScheduleScreen> {
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
                           return Container(
                                 child: SfCalendar(
                                   onTap: calendarTapped,
                                   view: CalendarView.schedule,
                                   headerStyle: CalendarHeaderStyle(
                                       textStyle: TextStyle(fontSize: 0)
                                   ),
                                   scheduleViewSettings: ScheduleViewSettings(
                                     appointmentTextStyle: TextStyle(
                                       fontWeight: FontWeight.w700,
                                       height: 1.5,
                                       color: Colors.black
                                     ),
                                     appointmentItemHeight: 70,
                                     hideEmptyScheduleWeek: true,
                                   ),
                                   dataSource: ScheduleDataSource(snapshot.data),
                                 )
                           );
                         } else {
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
      final Schedule appointmentDetails = details.appointments![0];
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

  Future<List<Schedule>> fetchSchedule() async {
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
            .map<Schedule>((json) => Schedule.fromJson(json))
            .toList();
        _schedules.sort((a, b) {
          Schedule x = a;
          Schedule y = b;
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
  ScheduleDataSource(List<Schedule> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getSchedule(index).date;
  }

  @override
  DateTime getEndTime(int index) {
    return _getSchedule(index).date.add(const Duration(hours: 1));
  }

  @override
  String getSubject(int index) {
    return _getSchedule(index).eventName;
  }

  @override
  Color getColor(int index){
    return Color(0xFFeaeaea); //todo: change colors
  }

  String getContent(int index) {
    return _getSchedule(index).content;
  }

  Schedule _getSchedule(int index) {
    final dynamic schedule = appointments![index];
    late final Schedule scheduleData;
    if (schedule is Schedule) {
      scheduleData = schedule;
    }

    return scheduleData;
  }
}

class Schedule {
  String eventName;
  DateTime date;
  String content;

  Schedule(this.eventName, this.content, {required this.date});

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
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

