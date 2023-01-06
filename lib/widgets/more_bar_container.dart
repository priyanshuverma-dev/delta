import 'package:answer_it/core/inAppNames.dart';
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
      color: Colors.white,
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
          color: Colors.grey,
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
                  color: Colors.grey.shade300,
                ),
                child: Row(
                  children: [
                    inAppName('#'),
                    Text(
                      id,
                      style: TextStyle(color: Colors.grey.shade900),
                    ),
                  ],
                ),
              ),
            ),
            // Connection Status Ui
            SizedBox(
              child: Text(connectionStatus),
            ),
            // Date Time Status Ui
            SizedBox(
              child: Text(
                '$formattedDate\n$formattedTime',
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        // History button
        Material(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colours.primaryColor,
              fixedSize: Size(Get.width, 50),
            ),
            onPressed: () => Get.toNamed("/history"),
            child: Text(
              'HISTORY',
              style: TextStyle(
                color: Colors.grey.shade100,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        )
      ],
    ),
  );
}
