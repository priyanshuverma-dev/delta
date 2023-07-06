import 'package:answer_it/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget getHistoryCell(String text, VoidCallback onPressed) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      gradient: const LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          Colors.white12,
          Colors.white10,
        ],
      ),
    ),
    padding: const EdgeInsets.all(10),
    margin: const EdgeInsets.all(2),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: Get.width - 100,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colours.textColor.withOpacity(0.7),
                fontSize: 16,
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            Icons.delete_forever_rounded,
            color: Colors.red.shade300,
          ),
        )
      ],
    ),
  );
}
