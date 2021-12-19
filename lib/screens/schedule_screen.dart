import 'package:exun_app_21/constants.dart';
import 'package:exun_app_21/widgets/schedule_list.dart';
import 'package:flutter/material.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var berlinWallFell = DateTime.utc(1989, 11, 9);
    var moonLanding = DateTime.parse("1969-07-20 20:18:04Z");
     // DateTime now = new DateTime.now();
     // DateFormat formatter = DateFormat('dd MM yyyy');
     // final String formatted = formatter.format(now);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 38.0),
          child: Text(
            "Today is $now \n $berlinWallFell \n $moonLanding",
            // "Today is $formatted", //todo: get current date
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
