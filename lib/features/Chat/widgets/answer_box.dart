import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../../../utils/colors.dart';

class AnswerBox extends StatelessWidget {
  final String text;
  final String prompt;
  const AnswerBox({super.key, required this.text, required this.prompt});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      Clipboard.setData(
                        ClipboardData(
                          text: text,
                        ),
                      );
                    },
                    icon: const Icon(Icons.copy),
                  ),
                  IconButton(
                    onPressed: () async {
                      Share.share(
                        'check out all new app solves all questions answer with the help of AI. https://answerit.somveers.me',
                        subject: 'New Ai App',
                      );
                    },
                    icon: const Icon(Icons.share_outlined),
                  ),
                  const Spacer(),
                  Text(
                    "Your Latest",
                    style: TextStyle(
                      color: Colours.primarySwatch,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 8,
              right: 8,
              left: 8,
              bottom: 1,
            ),
            child: Text(
              prompt,
              style: TextStyle(
                color: Colours.textColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                wordSpacing: 2,
                letterSpacing: .5,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 1,
              right: 8,
              left: 8,
              bottom: 8,
            ),
            child: Text(
              text,
              style: TextStyle(
                color: Colours.textColor,
                fontSize: 14,
                fontWeight: FontWeight.normal,
                wordSpacing: 2,
                letterSpacing: .5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
