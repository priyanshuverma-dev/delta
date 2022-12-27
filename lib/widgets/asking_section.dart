// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:answer_it/utlts/colors.dart';
import 'package:answer_it/utlts/global_vars.dart';
import 'package:answer_it/widgets/textfield.dart';

class AskingSection extends StatelessWidget {
  const AskingSection({
    Key? key,
    required this.usersInputController,
    required this.onPressAsk,
  }) : super(key: key);

  final TextEditingController usersInputController;
  final VoidCallback onPressAsk;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15,
              bottom: 10,
            ),
            child: TextFieldInput(
              hintText: 'Ask anything...',
              textEditingController: usersInputController,
            ),
          ),
        ),
        SizedBox(
          height: Globals.textfieldAndButtonheight,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 10,
            ),
            child: ElevatedButton(
              onPressed: onPressAsk,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colours.secondaryColor,
              ),
              child: Text(
                'Ask',
                style: TextStyle(
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
