import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.black,
      content: Text(content,
          style: TextStyle(
            color: Colours.textColor,
          )),
    ),
  );
}

void hideKeyboard() {
  SystemChannels.textInput.invokeMethod('TextInput.hide');
}
