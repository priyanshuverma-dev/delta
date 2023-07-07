import 'package:delta/basics/credits_screen.dart';
import 'package:delta/basics/feedback_screen.dart';
import 'package:delta/features/Chat/view/chat_screen.dart';
import 'package:delta/utils/global_vars.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class HomeScreen extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );
  const HomeScreen({super.key});

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
                return {'Credits', 'Feedback'}.map((String choice) {
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
