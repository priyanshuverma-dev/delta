import 'package:answer_it/utlts/colors.dart';
import 'package:flutter/material.dart';

Widget idCount(String count) {
  return Padding(
    padding: const EdgeInsets.only(right: 8.0),
    child: RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '#',
            style: TextStyle(
              fontSize: 16,
              color: Colours.secondaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: count,
            style: TextStyle(
              fontSize: 16,
              color: Colours.textColorBlack,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
