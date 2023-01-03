import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:answer_it/utlts/colors.dart';
import 'package:answer_it/widgets/toaster.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget getAnswerUI(String text, dynamic height, bool status, bool isloading) {
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
                        color: status ? Colors.green : Colors.red,
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
                  padding: const EdgeInsets.only(
                    right: 10,
                    left: 10,
                    top: 5,
                    bottom: 5,
                  ),
                  decoration: BoxDecoration(
                    color:
                        isloading ? Colors.red.shade100 : Colors.green.shade100,
                    border: Border.all(
                        width: 1,
                        color: isloading
                            ? Colors.red.shade300
                            : Colors.green.shade300),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        status
                            ? Icons.check_circle_outline
                            : Icons.cancel_outlined,
                        color: isloading ? Colors.red : Colors.green,
                      ),
                      const SizedBox(width: 5),
                      status
                          ? Text(
                              'Ready',
                              style: TextStyle(color: Colors.green.shade600),
                            )
                          : Text(
                              'wait',
                              style: TextStyle(color: Colors.red.shade600),
                            ),
                    ],
                  ),
                ),
                PopupMenuButton(
                  tooltip: 'Menu',
                  color: Colors.grey[300],
                  splashRadius: 50,
                  padding: const EdgeInsets.only(right: 5, left: 5),
                  enableFeedback: true,
                  position: PopupMenuPosition.under,
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
        ],
      ),
    ),
  );
}
