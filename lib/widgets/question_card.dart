import 'dart:ui';

import 'package:answer_it/core/inAppNames.dart';
import 'package:answer_it/utils/colors.dart';

import 'package:flutter/material.dart';

Widget getQuestionUI(text) {
  return BackdropFilter(
    filter: ImageFilter.blur(
      sigmaX: 15,
      sigmaY: 15,
    ),
    child: Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(right: 16.0, left: 16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white12,
            Colors.white10,
          ],
        ),
        color: Colours.primarySwatch.withOpacity(0.5),
        // color: Color.fromRGBO(48, 49, 52, 0.2),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
        boxShadow: [
          BoxShadow(
            // color: Colors.grey.withOpacity(0.2),
            color: Color.fromRGBO(118, 118, 118, 0.2),
            offset: const Offset(0, 2),
            blurRadius: 8.0,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
              'YOU: ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colours.textColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18,
                color: Colours.textColor,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
