import 'package:exun_app_21/constants.dart';
import 'package:exun_app_21/widgets/schedule_list.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

  class _ScheduleScreenState extends State<ScheduleScreen>{
    CalendarFormat _calendarFormat = CalendarFormat.month;
    DateTime _focusedDay = DateTime.now();
    DateTime? _selectedDay;

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
        Expanded(child: TableCalendar(
          firstDay: DateTime.utc(2021, 12, 26),
          lastDay: DateTime.utc(2022, 1, 2),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDay)) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            }
          },
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
        ),
        ),
      ],
    );
  }

}
