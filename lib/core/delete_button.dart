import 'package:flutter/material.dart';

Widget deleteButton(VoidCallback onDelete) {
  return IconButton(
    onPressed: onDelete,
    focusColor: Colors.red,
    highlightColor: Colors.red.shade200,
    icon: const Icon(
      Icons.delete_forever_outlined,
      size: 30,
    ),
    color: Colors.red.shade300,
  );
}
