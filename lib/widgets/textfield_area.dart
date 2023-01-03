import 'package:answer_it/utlts/colors.dart';
// import 'package:answer_it/utlts/global_vars.dart';
import 'package:flutter/material.dart';

Widget getSearchBarUI(String hintText,
    TextEditingController textEditingController, VoidCallback onPressed) {
  return Padding(
    padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
    child: Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 5, top: 8, bottom: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colours.primarySwatch,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  // topRight: Radius.circular(10.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 4, bottom: 4),
                child: TextField(
                  controller: textEditingController,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  cursorColor: Colours.primaryColor,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText,
                  ),
                ),
              ),
            ),
          ),
        ),
        // Button
        Container(
          decoration: BoxDecoration(
            color: Colours.primaryColor,
            borderRadius: const BorderRadius.only(
              // topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                offset: const Offset(0, 2),
                blurRadius: 8.0,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(
                Radius.circular(32.0),
              ),
              onTap: onPressed,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(
                  Icons.shortcut_sharp,
                  size: 20,
                  color: Colours.textColor,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
