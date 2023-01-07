import 'package:answer_it/utils/colors.dart';
import 'package:answer_it/core/toaster.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Widget getMoreOptions(
  context, {
  required String createdAt,
  required String id,
  required String connectionStatus,
}) {
  DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(createdAt);
  String formattedTime = DateFormat.jm().format(tempDate);
  String formattedDate = DateFormat.yMEd().format(tempDate);

  return Container(
    width: Get.width,
    padding: const EdgeInsets.all(16.0),
    margin: const EdgeInsets.only(bottom: 16.0, right: 16.0, left: 16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          Colors.white12,
          Colors.white10,
        ],
      ),
      // color: Colors.white,
      color: Colours.primarySwatch.withOpacity(0.5),
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(15.0),
        bottomRight: Radius.circular(15.0),
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
        Divider(
          height: 5,
          color: Colours.darkScaffoldColor,
          thickness: 1,
          indent: 20,
          endIndent: 20,
        ),
        SizedBox(height: 10),
        // Extra options...
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Id Ui InKwell and container...
            InkWell(
              onTap: () => toast('Answer No. : $id', Colors.white, 14),
              splashColor: Colours.primaryColor,
              highlightColor: Colours.primaryColor,
              hoverColor: Colours.primaryColor,
              child: Container(
                padding: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  // color: Colors.grey.shade300,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        '#',
                        style: TextStyle(color: Colours.textColor),
                      ),
                    ),
                    Text(
                      id,
                      style: TextStyle(color: Colours.textColor),
                    ),
                  ],
                ),
              ),
            ),
            // Connection Status Ui
            // SizedBox(
            //   child: Text(
            //     connectionStatus,
            //     style: TextStyle(
            //       color: Colours.textColor,
            //     ),
            //   ),
            // ),
            // Date Time Status Ui
            SizedBox(
              child: Text(
                '$formattedDate\n$formattedTime',
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: Colours.textColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        // History button
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colours.darkScaffoldColor,
            fixedSize: Size(Get.width, 50),
          ),
          onPressed: () => Get.toNamed("/history"),
          child: Text(
            'HISTORY',
            style: TextStyle(
              color: Colours.textColor,
              fontSize: 20,
            ),
          ),
        )
      ],
    ),
  );
}
