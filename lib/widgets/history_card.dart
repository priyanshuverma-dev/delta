import 'package:answer_it/core/inAppNames.dart';
import 'package:answer_it/utlts/colors.dart';
import 'package:answer_it/widgets/toaster.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Widget historyCard({
  required String userText,
  required String botText,
  required int id,
  required DateTime createdAt,
}) {
  String formattedTime = DateFormat.jm().format(createdAt);
  String formattedDate = DateFormat.yMEd().format(createdAt);

  return Column(
    children: [
      Container(
        height: 50,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8.0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => toast('Answer No. : $id', Colors.white, 14),
              splashColor: Colours.primaryColor,
              highlightColor: Colours.primaryColor,
              hoverColor: Colours.primaryColor,
              child: Container(
                padding: const EdgeInsets.only(right: 10, bottom: 5),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.grey.shade300,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        '#',
                        style: TextStyle(color: Colors.grey.shade900),
                      ),
                    ),
                    Text(
                      '$id',
                      style: TextStyle(color: Colors.grey.shade900),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(flex: 1),
            SizedBox(
              child: Text(
                '$formattedTime  $formattedDate',
                textAlign: TextAlign.end,
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
                return {'Delete'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(
                      choice,
                      style: TextStyle(color: Colors.red.shade500),
                    ),
                  );
                }).toList();
              },
              onSelected: (choice) {
                Clipboard.setData(ClipboardData(text: ''));
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
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8.0,
            ),
          ],
        ),
        width: Get.width - 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onLongPress: () => toast(
                'Question no. $id Copied to Clipboard',
                Colours.textColor,
                16,
              ),
              // User's Question ui
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'YOU: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        fontSize: 18,
                      ),
                    ),
                    TextSpan(
                      text: userText,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        letterSpacing: 1,
                        fontSize: 12,
                        wordSpacing: 1,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Divider(
              height: 5,
              color: Colors.grey,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            GestureDetector(
              onLongPress: () => toast(
                'Answer no. $id Copied to Clipboard',
                Colours.textColor,
                16,
              ),
              // Bot's Question ui
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'BOT: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        fontSize: 18,
                      ),
                    ),
                    TextSpan(
                      text: botText,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        letterSpacing: 1,
                        fontSize: 12,
                        wordSpacing: 1,
                      ),
                    )
                  ],
                ),
              ),
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
    ],
  );
}
