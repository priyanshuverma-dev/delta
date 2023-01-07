import 'package:answer_it/utils/colors.dart';
import 'package:answer_it/widgets/inputfield.dart';
import 'package:flutter/material.dart';

Widget getSearchBarUI(
  String hintText,
  TextEditingController textEditingController,
  VoidCallback onPressed,
  bool isloading,
) {
  return Padding(
    padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
    child: Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              right: 10,
              top: 12,
              bottom: 12,
            ),
            child: TextFieldInput(
              hintText: hintText,
              textEditingController: textEditingController,
              textInputType: TextInputType.text,
            ),
          ),
        ),

        // Button
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: Colours.darkScaffoldColor.withOpacity(0.7),
            fixedSize: Size(60, 50),
          ),
          child: Text(
            'Ask',
            style: TextStyle(
              color: Colours.textColor.withOpacity(0.5),
            ),
          ),
          onPressed: isloading ? null : onPressed,
        ),
      ],
    ),
  );
}
