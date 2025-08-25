import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutAppTile extends StatelessWidget {
  static const _githubUrl = "https://github.com/mohsen-w-elsisi";
  static const _repoUrl = "https://github.com/mohsen-w-elsisi/wardrobe_app";

  const AboutAppTile({super.key});

  @override
  Widget build(BuildContext context) {
    return AboutListTile(
      applicationName: "wardrobe",
      applicationVersion: "version 1.2.1",
      aboutBoxChildren: [
        RichText(
          text: TextSpan(
            children: [
              _text(context, "This is an app created by "),
              _link(context, "Mohsen elsisi", _githubUrl),
              _text(context, ". The "),
              _link(context, "source code", _repoUrl),
              _text(context, " for the project is available on github.")
            ],
          ),
        )
      ],
    );
  }

  TextSpan _link(BuildContext context, String text, String url) {
    return TextSpan(
      text: text,
      style: _linkTheme(context),
      recognizer: _linkGestureRecogniser(url),
    );
  }

  TapGestureRecognizer _linkGestureRecogniser(String url) =>
      TapGestureRecognizer()..onTap = () => launchUrlString(url);

  TextStyle _linkTheme(BuildContext context) {
    return _defaultTextTheme(context).copyWith(
      color: Theme.of(context).colorScheme.primary,
      decoration: TextDecoration.underline,
    );
  }

  TextSpan _text(BuildContext context, String text) {
    return TextSpan(
      text: text,
      style: _defaultTextTheme(context),
    );
  }

  TextStyle _defaultTextTheme(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!;
}
