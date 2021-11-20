import 'package:flutter/material.dart';

import 'notification_tile.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({Key? key}) : super(key: key);

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 38.0),
          child: NotificationTile(
              heading: "Exun 2021",
              time: 21,
              content: "Lorem ipsum dolor sit amet constectuer init"),
        )
      ],
    );
  }
}
