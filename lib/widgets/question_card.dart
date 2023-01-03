import 'package:answer_it/core/inAppNames.dart';
import 'package:answer_it/utlts/colors.dart';

import 'package:flutter/material.dart';

Widget getQuestionUI(text) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    margin: const EdgeInsets.only(right: 16.0, left: 16.0),
    decoration: BoxDecoration(
      color: Colours.primarySwatch,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(15.0),
        bottomRight: Radius.circular(15.0),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          offset: const Offset(0, 2),
          blurRadius: 8.0,
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.only(right: 16.0),
          child: inAppName('YOU:'),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    ),
  );
}
