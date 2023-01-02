import 'dart:io';

import 'package:answer_it/localStorage/models/pvtalk.dart';
import 'package:answer_it/screens/splash_screen.dart';
import 'package:answer_it/utlts/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

late Box pvbox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize hive
  Directory dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);

  // register adapter
  Hive.registerAdapter(PvTalkAdapter());
  // opening box for Database
  await Hive.openBox<PvTalk>('Box');

  // run app
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
