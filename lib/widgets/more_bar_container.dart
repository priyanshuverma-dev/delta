import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget getMoreOptions({
  required String createdAt,
  required String id,
  required String connectionStatus,
}) {
  return Container(
    width: Get.width,
    padding: const EdgeInsets.all(16.0),
    margin: const EdgeInsets.only(bottom: 16.0, right: 16.0, left: 16.0),
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
        SizedBox(
          child: Text(createdAt),
        ),
        const SizedBox(height: 20),
        SizedBox(
          child: Text(id),
        ),
        const SizedBox(height: 20),
        SizedBox(
          child: Text(connectionStatus),
        ),
      ],
    ),
  );
}
