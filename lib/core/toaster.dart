import 'package:answer_it/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget toast(
  String message,
  Color textColor,
  double fontSize,
) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colours.darkScaffoldColor,
    textColor: textColor,
    fontSize: fontSize,
  );
  return Container();
}
