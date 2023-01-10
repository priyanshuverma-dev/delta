import 'dart:io';

import 'package:answer_it/features/Chat/controller/texttospeech.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'package:answer_it/DeviceDataBase/models/pvtalk.dart';
import 'package:answer_it/basics/routes.dart';
import 'package:answer_it/utils/colors.dart';

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

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  SpeechApi.initTTS();

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
        useMaterial3: true,
        fontFamily: 'ubuntu',
        primaryColor: Colours.primaryColor,
        secondaryHeaderColor: Colours.secondaryColor,
      ),
      initialRoute: '/',
      getPages: appRoutes(),
    );
  }
}
