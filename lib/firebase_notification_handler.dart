import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import './constants.dart';

class FirebaseNotifications {
  FirebaseMessaging? _firebaseMessaging;

  void setUpFirebase() {
    _firebaseMessaging = FirebaseMessaging.instance;
    firebaseCloudMessaging_Listeners();
  }

  void firebaseCloudMessaging_Listeners() async {
    void iOS_Permission() async {
      await _firebaseMessaging!.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    }

    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging!.getToken().then((token) {
      print(token);
    });

    await _firebaseMessaging!.subscribeToTopic(FCM_TOPIC);

    //   _firebaseMessaging!.configure(
    //     onMessage: (Map<String, dynamic> message) async {
    //       print('on message $message');
    //     },
    //     onResume: (Map<String, dynamic> message) async {
    //       print('on resume $message');
    //     },
    //     onLaunch: (Map<String, dynamic> message) async {
    //       print('on launch $message');
    //     },
    //   );
    // }
  }
}
