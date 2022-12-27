import 'package:answer_it/screens/home_screen.dart';
import 'package:answer_it/utlts/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Answer it',
      theme: ThemeData(
        fontFamily: 'Sight',
        primaryColor: Colours.primaryColor,
        secondaryHeaderColor: Colours.secondaryColor,
      ),
      home: HomeScreen(),
    );
  }
}
