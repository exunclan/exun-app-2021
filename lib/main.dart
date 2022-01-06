import 'package:exun_app_21/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './screens/tabs_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exun App 2021-22',
      theme: ThemeData(
        fontFamily: "Trebuchet MS",
        primaryColor: KColors.blue,
        textTheme: const TextTheme(
          headline6: TextStyle(
            color: KColors.primaryText,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const TabsScreen(),
    );
  }
}
