import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

Widget getAnswerUI(String text, dynamic height, bool status) {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 16.0, right: 16.0, left: 16.0),
      constraints: BoxConstraints(maxHeight: height / 2, minHeight: height / 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(15.0),
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
            padding: const EdgeInsets.only(right: 16.0),
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
                            image: const AssetImage('assets/bot.png'),
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 40.0),
                      height: 15.0,
                      width: 15.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: status ? Colors.red : Colors.green,
                        border: Border.all(
                          color: Colors.white,
                          style: BorderStyle.solid,
                          width: 2.0,
                        ),
                      ),
                    )
                  ],
                ),
                Icon(
                  status ? Icons.cancel : Icons.check_circle,
                  color: status ? Colors.red : Colors.green,
                ),
              ],
            ),
          ),
          Divider(
            height: 5,
            color: Colors.grey,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedTextKit(
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
        ],
      ),
    ),
  );
}
