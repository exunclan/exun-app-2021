import 'package:exun_app_21/constants.dart';
import 'package:flutter/material.dart';

class NotificationDialog extends StatelessWidget {
  final String heading;
  final String? subtitle;
  final String content;
  const NotificationDialog({
    required this.heading,
    this.subtitle,
    required this.content,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              heading,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            subtitle == "" || subtitle == null
                ? SizedBox(height: 0)
                : SizedBox(height: 5.0),
            subtitle == null || subtitle == ""
                ? Container()
                : Text(
                    subtitle!,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: KColors.bodyText),
                  ),
            SizedBox(height: 10.0),
            Text(content),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("Back"),
        ),
      ],
    );
  }
}
