import 'package:flutter/material.dart';

Widget shadowContainer({
  required Widget child,
  Color bg = Colors.white,
  double? height,
  double? width,
  BorderRadiusGeometry br = const BorderRadius.all(Radius.circular(5)),
}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: bg,
      borderRadius: br,
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
    child: child,
  );
}
