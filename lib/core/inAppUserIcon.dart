import 'package:answer_it/utlts/colors.dart';
import 'package:flutter/material.dart';

Widget inAppUserIcon(String path) {
  return Padding(
    padding: const EdgeInsets.only(top: 2),
    child: Container(
      decoration: BoxDecoration(
        color: Colours.textColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: Colours.secondaryColor,
            spreadRadius: 1,
          )
        ],
      ),
      child: CircleAvatar(
        backgroundColor: Colours.textColor,
        child: Image.asset(path),
      ),
    ),
  );
}
