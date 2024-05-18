import 'package:delta/basics/credits_screen.dart';
import 'package:delta/basics/feedback_screen.dart';
import 'package:delta/features/Chat/view/chat_screen.dart';
import 'package:delta/utils/global_vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideKeyboard,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton(
              iconSize: 30,
              icon: const Icon(
                Icons.more_vert,
                size: 30,
              ),
              tooltip: 'Menu',
              padding: const EdgeInsets.only(right: 5, left: 5),
              enableFeedback: true,
              position: PopupMenuPosition.under,
              offset: const Offset(0.0, 10),
              itemBuilder: (context) {
                return {'Credits', 'Feedback', "Set API KEY"}
                    .map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
              onSelected: (choice) {
                if (choice == 'Credits') {
                  Navigator.push(context, CreditsScreen.route());
                } else if (choice == 'Feedback') {
                  Navigator.push(context, FeedBackScreen.route());
                } else if (choice == 'Set API KEY') {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _controller.clear();
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setString('API', _controller.text);
                              Gemini.init(apiKey: prefs.getString('API') ?? "");
                              Future.delayed(const Duration(milliseconds: 1),
                                  () {
                                Restart.restartApp();
                                Navigator.pop(context);
                              });
                            },
                            child: const Text('Set'),
                          ),
                        ],
                        title: const Text('Set API KEY'),
                        content: TextField(
                          controller: _controller,
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Hero(
              tag: 'ico',
              child: CircleAvatar(
                backgroundImage: AssetImage(Globals.ico),
                radius: 28,
              ),
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: const ChatScreen(),
      ),
    );
  }
}
