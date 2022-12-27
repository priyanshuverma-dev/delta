import 'package:answer_it/utlts/colors.dart';
import 'package:answer_it/utlts/global_vars.dart';
import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  const TextFieldInput({
    super.key,
    required this.textEditingController,
    required this.hintText,
  });

  final TextEditingController textEditingController;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        constraints: BoxConstraints(
          maxHeight: Globals.textfieldAndButtonheight,
          minHeight: Globals.textfieldAndButtonheight,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
            bottom: Radius.circular(5),
          ),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(10),
            bottom: Radius.circular(5),
          ),
          borderSide: BorderSide(
            color: Colours.secondaryColor,
          ),
        ),
        fillColor: Colors.grey.shade200,
        filled: true,
        hintText: hintText,
      ),
    );
  }
}
