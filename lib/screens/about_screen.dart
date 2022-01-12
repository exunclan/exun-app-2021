import 'package:exun_app_21/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  onTapLaunch(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 38.0),
        child: SingleChildScrollView(
        child:Column(
        children: [
          Image.asset('assets/logo.png', width: 141.0),
          const SizedBox(height: 30.0),
          const Text(
            "Exun 2021-22 is the largest student-run event of its kind, being the latest iteration in our "
                "series of flagship technology symposiums going back two decades. With Exun 2021, we're "
                "international again—participants from all around the globe are coming together to "
                "deeply investigate and celebrate the essence of technology.",
            style: TextStyle(
              color: KColors.bodyText,
              fontSize: 14.0,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            children: [
              RichText(
                text: TextSpan(
                  text: 'Check out the ',
                  style: const TextStyle(color: KColors.bodyText, fontSize: 14),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'official website',
                        style: const TextStyle(
                          color: KColors.blue,
                          fontSize: 14,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => onTapLaunch('https://exunclan.com')),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 5.0),
          Row(
            children: [
              RichText(
                text: TextSpan(
                  text: 'Join the ',
                  style: const TextStyle(color: KColors.bodyText, fontSize: 14),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'discord server',
                        style: const TextStyle(
                          color: KColors.blue,
                          fontSize: 14,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => onTapLaunch('https://exun.co/discord')),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Image.asset(
                    'assets/plaksha.png',
                    height: 50,
                  ),
                ),
                SizedBox(width: 20,),
                Image.asset(
                  'assets/codechef.png',
                  height: 50,
                ),
              ]),
            ),
        ],
      ),
    ),
    );
  }
}
