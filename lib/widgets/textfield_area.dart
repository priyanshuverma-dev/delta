import 'package:answer_it/utils/colors.dart';
import 'package:answer_it/widgets/inputfield.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

Widget getSearchBarUI({
  required String hintText,
  required TextEditingController textEditingController,
  required VoidCallback onPressed,
  required VoidCallback onPressMic,
  VoidCallback? onLongPress,
  required bool isloading,
  required bool isListen,
}) {
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
      // right: 16,
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
          onPressed: isloading && isListen ? null : onPressed,
        ),
        IconButton(
          style: IconButton.styleFrom(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            backgroundColor: Colours.darkScaffoldColor.withOpacity(0.7),
            fixedSize: Size(20, 50),
          ),
          icon: AvatarGlow(
            animate: isListen,
            glowColor: Colors.red,
            endRadius: 65.0,
            duration: Duration(milliseconds: 2000),
            repeatPauseDuration: Duration(milliseconds: 100),
            repeat: true,
            child: Icon(
              Icons.mic,
              color: Colours.textColor.withOpacity(0.5),
            ),
          ),
          onPressed: onPressMic,
        ),
      ],
    ),
  );
}
