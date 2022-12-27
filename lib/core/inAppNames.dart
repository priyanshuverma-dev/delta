import 'package:answer_it/utlts/colors.dart';
import 'package:flutter/material.dart';

Widget inAppName(String name) {
  return Padding(
    padding: const EdgeInsets.only(left: 10, right: 5),
    child: Text(
      name,
      style: TextStyle(
        fontSize: 16,
        color: Colours.secondaryColor,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
