import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:answer_it/utils/colors.dart';
import 'package:flutter/material.dart';

Widget colorDivider() {
  return AnimatedTextKit(
    repeatForever: true,
    animatedTexts: [
      ColorizeAnimatedText(
        '---------------------------------------',
        colors: Colours.colorizeColors.reversed.toList(),
        textStyle: TextStyle(
          height: 1,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        speed: const Duration(milliseconds: 1000),
      ),
    ],
  );
}
