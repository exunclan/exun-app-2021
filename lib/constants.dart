import 'package:flutter/material.dart';

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
