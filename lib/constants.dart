import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class KColors {
  static const Color blue = Color(0xFF2977F5);
  static const Color primaryText = Color(0xFF456484);
  static const Color bodyText = Color(0xFF858585);
  static const Color border = Color(0x262977F5);
}

const FCM_TOPIC = "all_devices";
const bool development = false;
const String devUrl = '192.168.0.191:3000';
const String prodUrl = 'notifs.exun.co';
const String baseUrl = development ? devUrl : prodUrl;
const String getNotifsUrl = "/notifications/list/all";
const String getScheduleUrl = "https://raw.githubusercontent.com/navgarg/ExunEvents2021/main/events.json";
// const String getScheduleUrl = "https://raw.githubusercontent.com/navgarg/ExunEvents/main/events.json";


Uri generateUrl(String path) {
  return development ? Uri.http(baseUrl, path) : Uri.https(baseUrl, path);
}
// var listOfEvents = [
//   Event(
//       name: 'Hardware',
//       timing: '0000HRS',
//       date: DateTime(2020, 11, 15),
//       information:
//       'Power up your cores and overclock that grey matter, because you’re in for some serious hands-on competition. Identify components belonging to a plethora of devices and show off your know-how about hardware.'),
//   Event(
//       name: 'ExML',
//       timing: '1800HRS',
//       date: DateTime(2020, 11, 15),
//       information:
//       'Tired of the usual plug-and-chug in contests? Look no further, we bring you a cross-disciplinary Machine Learning event where there will be a rich variety of unique yet equally mesmerising machine learning paradigms on display and in use.'),
// ];
//
// bool testing = false;
//
// final exunStartDate = DateTime(2020, 11, 15);
// final exunEndDate = DateTime(2020, 11, 22)
//     .add(Duration(days: 0, hours: 23, minutes: 59, seconds: 59));
//
// // Colors
// Color kBlue = Color(0xFF2977F5);
// Color kGrey = Color(0xFF828282);
// Color kBorderColor = Color(0xFFEBF0FF);
// Color kMenuColor = Color(0xFFDADADA);
// Color kSearchBG = Color(0xFFF1F1F1);
// Color kSearchColor = Color(0xFFA3A3A3);
// Color kBlack = Color(0xFF383838);
// Color kLightBlack = Color(0xFF797979);
// Color kLightGrey = Color(0xFFC0C0C0);
//
// // Text Styles
// TextStyle kHeadingStyle =
// GoogleFonts.chivo(fontSize: 42, fontWeight: FontWeight.w400, color: kBlack);
//
// TextStyle kTextStyle =
// GoogleFonts.chivo(fontSize: 22, fontWeight: FontWeight.w400, color: kGrey);
//
// List<dynamic> notifs = [];
// List<dynamic> filteredNotifs = [];
//
// // Constants
// const int kSplashTime = 2;
// const URL = "https://notifs.exun.co/notifications/list/";
// const scheduleAPI = "https://raw.githubusercontent.com/VaishnavGarodia/ExunEvents2020/main/events.json";
// const STATUS_CORRECT = "S10001";
//
// Future<int> getIfVisited() async {
//   SharedPreferences _prefs = await SharedPreferences.getInstance();
//   int state = (_prefs.getInt('state') ?? 0);
//   if (state == 0) {
//     await _prefs.setInt("state", 1);
//   } else if (testing) {
//     var num = Random().nextInt(100);
//     print(num);
//     if (num > 50) {
//       await _prefs.setInt("state", 0);
//     }
//   }
//   return state;
// }
//
// class Event {
//   Event(
//       {required this.name,
//         required this.timing,
//         required this.date,
//         required this.information,
//         // required this.timeLeft
//       });
//
//   final String name;
//   final String timing;
//   final DateTime date;
//   final String information;
//   // Duration timeLeft;
// }