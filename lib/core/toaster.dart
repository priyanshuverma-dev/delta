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
    backgroundColor: Colors.black87,
    textColor: textColor,
    fontSize: fontSize,
  );
  return Container();
}
