import 'package:exun_app_21/constants.dart';
import 'package:exun_app_21/widgets/schedule_list.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

  class _ScheduleScreenState extends State<ScheduleScreen>{
    // CalendarFormat _calendarFormat = CalendarFormat.month;
    // DateTime _focusedDay = DateTime.now();
    // DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 38.0),
          // child: Text(
          //   "Today is $now",
          //   // "Today is $formatted", //todo: get current date
          //   style: TextStyle(
          //     fontSize: 17.0,
          //     fontWeight: FontWeight.bold,
          //     color: KColors.primaryText,
          //   ),
          // ),
        ),
        SizedBox(
          height: 10.0,
        ),
        // Expanded(child: ScheduleList()),
        Expanded(child: FutureBuilder(
          // future: fetchSchedule(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              return SafeArea(
                child: Container(
                    child: SfCalendar(
                      view: CalendarView.week,
                      initialDisplayDate: DateTime(2017, 6, 01, 9, 0, 0),
                      // dataSource: MeetingDataSource(snapshot.data),
                    )),
              );
            } else {
              return Container(
                child: Center(
                  child: Text('Error'),
                ),
              );
            }
          },
        ),
        ),
      ],
    );
  }

}
