import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SfCalendar(
          view: CalendarView.schedule,
          dataSource: ScheduleDataSource(_getDataSource()),
          scheduleViewSettings: ScheduleViewSettings(
              appointmentItemHeight: 50,
              hideEmptyScheduleWeek: true,
          ),
          monthViewSettings: const MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.indicator),
        )
    );
  }

  List<Schedule> _getDataSource() {
    final List<Schedule> schedules = <Schedule>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
    DateTime(today.year, today.month, today.day, 11, 30, 0);
    // print("startTime: ");
    // print(startTime);
    final DateTime start = startTime.add(const Duration(hours: 29));
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    final DateTime end = endTime.add(const Duration(hours: 29));
    schedules.add(Schedule(
        'Hardware', startTime, endTime, const Color(0xF0F8644)));
    schedules.add(Schedule(
        'Surprise', start, end, const Color(0xFFF0000)));
    return schedules;
  }
}

class ScheduleDataSource extends CalendarDataSource {
  ScheduleDataSource(List<Schedule> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  Schedule _getMeetingData(int index) {
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
  DateTime from;
  DateTime to;
  Color background;

  Schedule(this.eventName, this.from, this.to, this.background);

}