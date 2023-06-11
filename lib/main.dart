import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:answer_it/basics/routes.dart';
import 'package:answer_it/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // run app
  runApp(ProviderScope(
    child: const MyApp(),
  ));
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
