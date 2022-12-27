import 'dart:developer';

import 'package:answer_it/server_side/controller.dart';
import 'package:answer_it/utlts/colors.dart';
import 'package:answer_it/utlts/global_vars.dart';
import 'package:answer_it/widgets/asking_section.dart';
import 'package:answer_it/widgets/bot_card.dart';
import 'package:answer_it/widgets/textfield.dart';
import 'package:answer_it/widgets/toaster.dart';
import 'package:answer_it/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  final Controller controller = Get.put(Controller());

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var dataLoading = widget.controller.isloading;

    return GestureDetector(
      onTap: () => {
        FocusScope.of(context).unfocus(),
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[300],
          body: Obx(
            () => SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (dataLoading.isTrue)
                    LinearProgressIndicator(
                      color: Colours.primaryColor,
                      backgroundColor: Colours.secondaryColor,
                    )
                  else
                    (Container()),
                  BotCard(),
                  UserCard(),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      child: Text(
                        widget.controller.message.toString(),
                        style: TextStyle(
                          fontSize: Globals.fontSize,
                        ),
                      ),
                    ),
                  ),
                  AskingSection(
                    usersInputController: widget.controller.userInput,
                    onPressAsk: () {
                      FocusScope.of(context).unfocus();

                      widget.controller.askQuestion();
                      widget.controller.userInput.clear();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
