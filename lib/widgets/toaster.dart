import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget toast(
  String message,
  Toast toastLength,
  ToastGravity gravity,
  Color backgroundColor,
  Color textColor,
  double fontSize,
) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: toastLength,
    gravity: gravity,
    timeInSecForIosWeb: 1,
    backgroundColor: backgroundColor,
    textColor: textColor,
    fontSize: fontSize,
  );
  return Container();
}
