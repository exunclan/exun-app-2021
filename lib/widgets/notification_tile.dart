import 'dart:ui';

import 'package:exun_app_21/widgets/notification_dialog.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class NotificationTile extends StatelessWidget {
  final String heading;
  final String? subtitle;
  final String time;
  final String content;

  const NotificationTile({
    Key? key,
    required this.heading,
    this.subtitle,
    required this.time,
    required this.content,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    String icon = "circuit";
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 38.0, vertical: 10.0),
      child: GestureDetector(
        onTap: () async {
          return showDialog(
            context: context,
            builder: (BuildContext context) {
              return NotificationDialog(
                heading: heading,
                subtitle: subtitle,
                content: content,
              );
            },
          );
        },
        child: ListTile(
          leading: Image.asset('assets/$icon.png'),
          title: Text("$heading",
          style: const TextStyle(
            fontSize: 16,
              color: KColors.primaryText,
          ),),
          subtitle: Text(
            "$time \n$content",
            style: const TextStyle(
              color: KColors.bodyText,
              fontSize: 13.0,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          isThreeLine: true,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: KColors.border, width: 1),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
