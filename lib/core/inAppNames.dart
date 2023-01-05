import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:answer_it/utlts/colors.dart';
import 'package:flutter/material.dart';

Widget inAppName(String name, {List<Color>? colors, Duration? time}) {
  return Padding(
    padding: const EdgeInsets.only(left: 10),
    child: AnimatedTextKit(
      repeatForever: true,
      animatedTexts: [
        ColorizeAnimatedText(
          name,
          colors: colors ?? Colours.colorizeColors,
          textStyle: TextStyle(
            fontSize: 18,
            color: Colours.secondaryColor,
            fontWeight: FontWeight.bold,
          ),
          speed: time ?? Duration(seconds: 50),
        ),
      ],
    ),
  );
}
