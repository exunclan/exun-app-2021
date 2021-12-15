import 'package:exun_app_21/constants.dart';
import 'package:exun_app_21/widgets/schedule_list.dart';
import 'package:flutter/material.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 38.0),
          child: Text(
            "Today is ", //todo: get current date
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
              color: KColors.primaryText,
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Expanded(child: ScheduleList()),
      ],
    );
  }
}
