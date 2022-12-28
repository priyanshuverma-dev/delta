import 'package:answer_it/screens/splash_screen.dart';
import 'package:answer_it/utlts/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize hive
  await Hive.initFlutter();

  // opening box for Database
  await Hive.openBox('UserBox');
  await Hive.openBox('BotBox');

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
      home: const SplashScreen(),
    );
  }
}
