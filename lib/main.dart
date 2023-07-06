import 'package:answer_it/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:answer_it/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // run app
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Delta',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'ubuntu',
        primaryColor: Colours.primaryColor,
        secondaryHeaderColor: Colours.secondaryColor,
      ),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}
