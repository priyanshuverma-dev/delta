import 'dart:developer';

import 'package:answer_it/core/page_indicator.dart';
import 'package:answer_it/core/snackbar.dart';
import 'package:answer_it/localStorage/models/dataModel.dart';
import 'package:answer_it/main.dart';
import 'package:answer_it/server/controller.dart';
import 'package:answer_it/utlts/colors.dart';
import 'package:answer_it/widgets/asking_section.dart';
import 'package:answer_it/widgets/bot_card.dart';
import 'package:answer_it/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  final Controller controller = Get.put(Controller());

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController inputController = TextEditingController();

  late PageController _pageController;
  late PageController _pagebotController;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: widget.controller.userBox.length,
    );
    _pagebotController = PageController(
      initialPage: widget.controller.botBox.length,
    );
    super.initState();
  }

  void clickAsk(String input) {
    FocusScope.of(context).unfocus();

    // initialize boxes
    userBox = widget.controller.userBox;
    botBox = widget.controller.botBox;

    // check if user input is empty or not
    if (input.isEmpty) {
      Get.showSnackbar(customSnakeBar(
          'Please enter a question', 'You can ask anything', Icons.error));
      return;
    }
    // user's question will be added to the last of the list
    _pageController.animateToPage(
      widget.controller.userBox.length,
      duration: const Duration(milliseconds: 10),
      curve: Curves.easeInOut,
    );
    // bot's question will be added to the last of the list
    _pagebotController.animateToPage(
      widget.controller.botBox.length,
      duration: const Duration(milliseconds: 10),
      curve: Curves.easeInOut,
    );

    // user data storage
    final userData = UserData(question: input, id: userBox.length);
    userBox.add(userData);

    // sending question to server...
    setState(() {
      input = widget.controller.question.toString();
      botBox.get(botBox.length);
    });

    widget.controller.askQuestion();
    inputController.clear();
    log('Answer: ' + widget.controller.message.value.toString());

    // bot data storage
    if (widget.controller.message.value != 'Bot Online') {
      final botData =
          BotData(anwser: widget.controller.message.value, id: botBox.length);
      botBox.add(botData);
    }

    // log(botBox.length.toString());
    // log(botBox.get(0)!.anwser.toString());
  }

  void deleteUserCard(index) {
    userBox = widget.controller.userBox;
    if (userBox.length == 1) {
      Get.showSnackbar(
        customSnakeBar(
            'Answer it ', 'can\'t delete initial question', Icons.delete),
      );
      return;
    }
    userBox.deleteAt(index);
    setState(() {});
    // log(userBox.length.toString());
    Get.showSnackbar(
      customSnakeBar('Question deleted', 'You can ask anything', Icons.delete),
    );
  }

  void deleteBotCard(index) {
    botBox = widget.controller.botBox;
    if (botBox.length == 1) {
      Get.showSnackbar(
        customSnakeBar(
            'Answer it ', 'can\'t delete initial question', Icons.delete),
      );
      return;
    }
    botBox.deleteAt(index);
    setState(() {});
    log(botBox.length.toString());
    Get.showSnackbar(
      customSnakeBar('Answer deleted', 'You can ask anything', Icons.delete),
    );
  }

  @override
  Widget build(BuildContext context) {
    var dataLoading = widget.controller.isloading;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Obx(
          () => GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
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
                    (const SizedBox(
                      height: 5,
                    )),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    child: PageView.builder(
                      controller: _pagebotController,
                      reverse: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: widget.controller.botBox.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return BotCard(
                          botData: BotData(
                              id: index,
                              anwser: widget.controller.botBox
                                  .getAt(index)!
                                  .anwser),
                          onDelete: () => deleteBotCard(index),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 5),
                  pageIndicator(
                      widget.controller.botBox.length, _pagebotController),
                  const SizedBox(height: 20),
                  // UserCard
                  pageIndicator(
                      widget.controller.userBox.length, _pageController),
                  const SizedBox(height: 5),
                  Container(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width,
                    child: PageView.builder(
                      controller: _pageController,
                      reverse: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: widget.controller.userBox.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return UserCard(
                          userData: UserData(
                              id: index,
                              question: widget.controller.userBox
                                  .getAt(index)!
                                  .question),
                          onDelete: () => deleteUserCard(index),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),
                  Container(
                    // decoration: const BoxDecoration(
                    //   borderRadius: BorderRadius.only(
                    //     bottomLeft: Radius.circular(20),
                    //     bottomRight: Radius.circular(20),
                    //     topLeft: Radius.circular(20),
                    //     topRight: Radius.circular(20),
                    //   ),
                    // ),
                    color: Colors.transparent,
                    child: AskingSection(
                      usersInputController: inputController,
                      onPressAsk: () => clickAsk(inputController.text),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Close All Boxes.....
  @override
  void dispose() {
    _pagebotController.dispose();
    _pageController.dispose();
    Hive.box('BotBox').close();
    Hive.box('UserBox').close();
    super.dispose();
  }
}
