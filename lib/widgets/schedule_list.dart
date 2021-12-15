import 'dart:convert';

import 'package:exun_app_21/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'notification_tile.dart';

class ScheduleList extends StatefulWidget {
  const ScheduleList({Key? key}) : super(key: key);

  @override
  _ScheduleListState createState() => _ScheduleListState();
}

class Schedule {
  String name;
  String timing;
  String info;
  DateTime date;

  Schedule(
      this.name, this.timing, this.info,
      {required this.date});

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      json['name'],
      json['timing'],
      json['information'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'timing': timing,
    'information': info,
    'date': date.toString(),
  };
}

class _ScheduleListState extends State<ScheduleList> {
  List<Schedule> _schedules = [];
  bool _scheduleLoaded = false;

  @override
  void initState() {
    print("is this called");
    super.initState();
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print("is this called?");
      _scheduleLoaded = false;
      fetchSchedule();
    });
  }

  Future<void> fetchSchedule() async {
    print(_scheduleLoaded);
    if (!_scheduleLoaded) {
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
        _scheduleLoaded = true;
        setState(() {});
      } catch (e) {
        _schedules = [];
        print("error");
        print(e);
        print("error");
        _scheduleLoaded = true;

        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchSchedule(),
      builder: (ctx, snapshot) =>
      snapshot.connectionState == ConnectionState.waiting
          ? Center(
        child: CircularProgressIndicator(),
      )
          : RefreshIndicator(
        onRefresh: () {
          _scheduleLoaded = false;
          return fetchSchedule();
        },
        child: ListView.builder(
          itemCount: _schedules.length,
          itemBuilder: (BuildContext context, int index) {
            Schedule schedule = _schedules[index];
            DateTime y = DateTime.now();
            int ago = y.difference(schedule.date).inHours; //todo:change date format
            return NotificationTile(
              heading: schedule.name,
              time: ago,
              content: schedule.info,
              subtitle: schedule.timing,
            );
          },
        ),
      ),
    );
  }
}
