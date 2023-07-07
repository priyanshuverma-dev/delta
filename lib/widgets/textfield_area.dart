import 'package:delta/utils/colors.dart';
import 'package:delta/widgets/inputfield.dart';
import 'package:flutter/material.dart';

Widget getSearchBarUI({
  required String hintText,
  required TextEditingController textEditingController,
  required VoidCallback onPressed,
  required bool isloading,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      padding: const EdgeInsets.only(
        left: 1,
        // right: 16,
      ),
      decoration: BoxDecoration(
        color: Colours.darkScaffoldColor,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            offset: Offset(0, 0),
            blurRadius: 0,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.09),
            offset: Offset(0, 2),
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                right: 10,
                left: 10,
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
          IconButton(
            style: ElevatedButton.styleFrom(
              elevation: 2,
            ),
            icon: const Icon(Icons.send),
            onPressed: isloading ? null : onPressed,
          ),
        ],
      ),
    ),
  );
}
