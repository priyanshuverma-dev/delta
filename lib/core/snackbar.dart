import 'package:flutter/material.dart';
import 'package:get/get.dart';

GetSnackBar customSnakeBar(
    String title, String message, IconData icon, int time) {
  return GetSnackBar(
    margin: const EdgeInsets.all(20),
    borderRadius: 20,
    borderWidth: 1,
    borderColor: Colors.grey.shade700,
    dismissDirection: DismissDirection.endToStart,
    snackStyle: SnackStyle.FLOATING,
    duration: Duration(seconds: time),
    snackPosition: SnackPosition.BOTTOM,
    title: title,
    message: message,
    icon: Icon(icon, color: Colors.grey.shade300),
    backgroundColor: Colors.grey.shade800,
  );
}
