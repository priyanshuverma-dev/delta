import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../../../utils/colors.dart';

class RecentBox extends StatelessWidget {
  final String text;
  const RecentBox({
    super.key,
    required this.text,
  });

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
                  Text(
                    "Your Recent",
                    style: TextStyle(
                      color: Colours.primarySwatch,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  const Spacer(),
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
                        text,
                        subject: 'Recent',
                      );
                    },
                    icon: const Icon(Icons.share_outlined),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
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
