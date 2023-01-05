import 'package:answer_it/utlts/colors.dart';
// import 'package:answer_it/utlts/global_vars.dart';
import 'package:flutter/material.dart';

Widget getSearchBarUI(
    String hintText,
    TextEditingController textEditingController,
    VoidCallback onPressed,
    bool isloading) {
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
                  bottomLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
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
                    hintStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
        // Button
        Container(
          decoration: BoxDecoration(
            // color: Colours.secondaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0),
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
          child: TextButton(
            child: Text('Ask...', style: TextStyle(color: Colours.textColor)),
            onPressed: isloading ? null : onPressed,
            style: ButtonStyle(
              padding:
                  MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
              foregroundColor:
                  MaterialStateProperty.all<Color>(Colours.primaryColor),
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colours.primaryColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
