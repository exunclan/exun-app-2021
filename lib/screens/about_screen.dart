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
      child: Column(
        children: [
          Image.asset('assets/logo.png', width: 141.0),
          const SizedBox(height: 50.0),
          const Text(
            "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. text some more text lorem ipsum text.",
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
                          ..onTap = () => onTapLaunch('https://exunclan.com')),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
