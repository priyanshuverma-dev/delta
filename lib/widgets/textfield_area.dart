import 'package:answer_it/widgets/inputfield.dart';
import 'package:flutter/material.dart';

Widget getSearchBarUI({
  required String hintText,
  required TextEditingController textEditingController,
  required VoidCallback onPressed,
  required bool isloading,
}) {
  return Container(
    padding: const EdgeInsets.only(
      left: 16,
      // right: 16,
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
  );
}
