import 'package:answer_it/features/Chat/view/chat_screen.dart';
import 'package:answer_it/utils/colors.dart';
import 'package:answer_it/utils/global_vars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../features/Chat/widgets/loading_skeletion.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            iconSize: 30,
            icon: Icon(
              Icons.more_vert,
              size: 30,
            ),
            tooltip: 'Menu',
            splashRadius: 50,
            padding: const EdgeInsets.only(right: 5, left: 5),
            enableFeedback: true,
            position: PopupMenuPosition.under,
            offset: Offset(0.0, 10),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.grey.shade400,
                width: 1,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
            ),
            itemBuilder: (context) {
              return {'Credits', 'Feedback'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice, style: TextStyle()),
                );
              }).toList();
            },
            onSelected: (choice) {
              if (choice == 'Credits') {
              } else if (choice == 'Feedback') {}
            },
          ),
        ],
        leading: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Hero(
              tag: 'ico',
              child: CircleAvatar(
                backgroundImage: AssetImage(Globals.ico),
                radius: 28,
              ),
            ),
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ChatScreen(),
    );
  }
}
