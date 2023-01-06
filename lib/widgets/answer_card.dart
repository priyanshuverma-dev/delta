import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:answer_it/utils/colors.dart';
import 'package:answer_it/core/toaster.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget getAnswerUI(String text, dynamic height, bool status, bool isloading) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    margin: const EdgeInsets.only(right: 16.0, left: 16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15.0),
        topRight: Radius.circular(15.0),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          offset: const Offset(0, 2),
          blurRadius: 8.0,
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: <Widget>[
                  Container(
                    height: 60.0,
                    width: 60.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      image: DecorationImage(
                        scale: 0.5,
                        image: const AssetImage('assets/bot.png'),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 40.0),
                    height: 15.0,
                    width: 15.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: status ? Colors.green : Colors.amber,
                      border: Border.all(
                        color: Colors.white,
                        style: BorderStyle.solid,
                        width: 2.0,
                      ),
                    ),
                  )
                ],
              ),
              Spacer(flex: 1),
              Container(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                height: 30,
                width: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isloading || !status
                        ? Colors.white
                        : Colors.grey.shade300,
                    width: 2,
                  ),
                ),
                child: isloading || !status
                    ? CircularProgressIndicator(
                        backgroundColor: Colours.secondaryColor,
                        color: Colours.textColor,
                        strokeWidth: 2,
                      )
                    : Icon(
                        Icons.check,
                        color: Colors.green,
                        size: 15,
                      ),
              ),
              PopupMenuButton(
                tooltip: 'Menu',
                color: Colors.white,
                splashRadius: 50,
                padding: const EdgeInsets.only(right: 5, left: 5),
                enableFeedback: true,
                position: PopupMenuPosition.under,
                offset: Offset(0.0, 10),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.grey.shade400,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                ),
                itemBuilder: (context) {
                  return {'Copy'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
                onSelected: (choice) {
                  Clipboard.setData(ClipboardData(text: text));
                  toast(
                    'Copied to Clipboard',
                    Colours.textColor,
                    16,
                  );
                },
              )
            ],
          ),
        ),
        SizedBox(height: 5),
        Divider(
          height: 5,
          color: Colors.grey,
          thickness: 1,
          indent: 20,
          endIndent: 20,
        ),
        Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedTextKit(
                key: Key(text),
                isRepeatingAnimation: false,
                totalRepeatCount: 1,
                animatedTexts: [
                  TypewriterAnimatedText(
                    textAlign: TextAlign.start,
                    text,
                    textStyle: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black87,
                      letterSpacing: 0.1,
                    ),
                    speed: const Duration(milliseconds: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
