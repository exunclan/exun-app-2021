import 'dart:convert';

import 'package:exun_app_21/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'notification_tile.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({Key? key}) : super(key: key);

  @override
  _NotificationListState createState() => _NotificationListState();
}

class Notification {
  String title;
  String subtitle;
  String message;
  String postedBy;
  String type;
  DateTime createdAt;

  Notification(
      this.title, this.subtitle, this.message, this.postedBy, this.type,
      {required this.createdAt});

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      json['title'],
      json['subtitle'],
      json['message'],
      json['posted_by'],
      json['type'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'subtitle': subtitle,
        'message': message,
        'posted_by': postedBy,
        'type': type,
        'created_at': createdAt.toString(),
      };
}

class _NotificationListState extends State<NotificationList> {
  List<Notification> _notifications = [];
  bool _notifLoaded = false;

  @override
  void initState() {
    print("is this called");
    super.initState();
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print("is this called?");
      _notifLoaded = false;
      fetchNotifs();
    });
  }

   Future<void> fetchNotifs() async {
    // await openBox();
    print(_notifLoaded);
    if (!_notifLoaded) {
      try {
        var uri = generateUrl(getNotifsUrl);
        print(uri);
        var value = await get(uri);
        print("value");
        print(value);
        print("value");
        var parsed = json.decode(value.body);
        print(parsed);
        if (parsed["statusCode"] == "S10001") {
          _notifications = parsed['rows']
              .map<Notification>((json) => Notification.fromJson(json))
              .toList();
          _notifications.sort((a, b) {
            Notification x = a;
            Notification y = b;
            return y.createdAt.compareTo(x.createdAt);
          });
          // await putData(_notifications);
          // filteredNotifs = _notifications;
          _notifLoaded = true;
        }
        setState(() {});
      } catch (e) {
        _notifications = [];
        print("error");
        print(e);
        print("error");
        // for (var j in box.toMap().values.toList()) {
        //   Map<String, dynamic> x = new Map.from(j);
        //   notifs.add(Notification.fromJson(x));
        // }
        // filteredNotifs = notifs;
        _notifLoaded = true;

        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchNotifs(),
      builder: (ctx, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  onRefresh: () {
                    _notifLoaded = false;
                    return fetchNotifs();
                  },
                  child: ListView.builder(
                    itemCount: _notifications.length,
                    itemBuilder: (BuildContext context, int index) {
                      Notification notif = _notifications[index];
                      DateTime y = DateTime.now();
                      int ago = y.difference(notif.createdAt).inHours;
                      String time;
                      if (ago>=24){
                        ago=(ago~/24);
                        if (ago==1){
                          time = "$ago day ago";
                        }
                        else{
                          time = "$ago days ago";
                        }
                      }
                      else{
                        time = "$ago hrs ago";
                      }
                      return NotificationTile(
                        heading: notif.title,
                        time: time,
                        content: notif.message,
                        subtitle: notif.subtitle,
                      );
                    },
                  ),
                ),
    );
  }
}
