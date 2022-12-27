import 'package:answer_it/utlts/colors.dart';
import 'package:answer_it/widgets/toaster.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget copyText(String text) {
  return ElevatedButton.icon(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent,
      elevation: 0,
      enableFeedback: true,
      shadowColor: Colours.secondaryColor,
    ),
    onPressed: () {
      Clipboard.setData(ClipboardData(text: text));
      toast(
        'Copied to Clipboard',
        Toast.LENGTH_LONG,
        ToastGravity.BOTTOM,
        Colours.secondaryColor,
        Colours.textColor,
        16,
      );
    },
    icon: Icon(
      Icons.copy,
      color: Colours.secondaryColor,
      size: 20,
    ),
    label: Text(
      'Copy',
      style: TextStyle(
        fontSize: 16,
        color: Colours.secondaryColor,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
