import 'package:answer_it/utils/colors.dart';
import 'package:answer_it/widgets/inputfield.dart';
import 'package:flutter/material.dart';

Widget getSearchBarUI(
  String hintText,
  TextEditingController textEditingController,
  VoidCallback onPressed,
  VoidCallback onLongPress,
  bool isloading,
) {
  return Container(
    decoration: BoxDecoration(
        border: Border.symmetric(
      horizontal: BorderSide(
        color: Colours.darkScaffoldColor.withOpacity(0.7),
        width: 2.0,
      ),
    )),
    padding: const EdgeInsets.only(
      left: 16,
      right: 16,
    ),
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
          onLongPress: onLongPress,
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
