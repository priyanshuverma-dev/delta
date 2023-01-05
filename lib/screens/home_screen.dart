import 'dart:async';
import 'dart:developer';

import 'package:answer_it/utlts/colors.dart';
import 'package:answer_it/widgets/more_bar_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:answer_it/controllers/controller.dart';
import 'package:answer_it/core/snackbar.dart';
import 'package:answer_it/localStorage/models/pvtalk.dart';
import 'package:answer_it/main.dart';
import 'package:answer_it/widgets/answer_card.dart';
import 'package:answer_it/widgets/question_card.dart';
import 'package:answer_it/widgets/textfield_area.dart';

class HomeScreen extends StatefulWidget {
  final Controller controller = Get.put(Controller());

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController inputController = TextEditingController();
  late AnimationController bottomSheetController;

  @override
  void initState() {
    bottomSheetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    super.initState();
  }

  // user input capture and sent to server...
  void clickAsk(String input) async {
    FocusScope.of(context).unfocus();

    // sending question to server execution...
    if (input.isEmpty) {
      Get.showSnackbar(
        customSnakeBar(
          'Please enter a question',
          'You can ask anything',
          Icons.error,
          2,
        ),
      );

      return;
    }
    try {
      setState(() {
        widget.controller.userInput.text = input;
      });
      await widget.controller.askQuestion();
    } catch (e) {
      log(e.toString());
    } finally {
      saveAllData();
    }
  }

  // input and response capture and sent to local storage to save data in device...
  void saveAllData() async {
    pvbox = widget.controller.pvbox;
    try {
      var now = new DateTime.now();

      final pvtalk = await PvTalk(
        question: inputController.text,
        answer: widget.controller.messageOutput.text,
        createdAt: now,
        id: widget.controller.pvbox.length,
      );
      await pvbox.add(pvtalk);
    } catch (e) {
      log(e.toString());
    } finally {
      setState(() {
        widget.controller.userInput.text = '';
        widget.controller.messageOutput.text = '';
        inputController.clear();
      });
    }
  }

  // onPress Floating Action Button...

  void onClickFloatingButton() {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      transitionAnimationController: bottomSheetController,
      context: context,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
          child: Container(
            height: 500,
            color: Colors.grey[300],
            child: Column(
              children: <Widget>[
                // getSearchBarUI is a widget which is used to get input from user...
                getSearchBarUI(
                  'Ask anything...',
                  inputController,
                  () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    Navigator.pop(context);
                    clickAsk(inputController.text);
                  },
                  widget.controller.isloading.value,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var pvboxlength = widget.controller.pvbox.length - 1;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          enableFeedback: true,
          tooltip: 'Ask a Question',
          onPressed: () => onClickFloatingButton(),
          child: const Icon(Icons.add),
          backgroundColor: Colours.primaryColor,
        ),
        backgroundColor: Colors.grey[300],
        body: Obx(
          () => GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: RefreshIndicator(
              color: Colours.secondaryColor,
              backgroundColor: Colors.transparent,
              onRefresh: () {
                return Future.delayed(
                  Duration(seconds: 1),
                  () {
                    widget.controller.CheckUserConnection();
                    widget.controller.fetchData();
                    Get.showSnackbar(
                      customSnakeBar(
                        'Answer it',
                        'Refreshed !',
                        Icons.refresh,
                        2,
                      ),
                    );
                  },
                );
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // some space
                    const SizedBox(height: 10),
                    // getQuestionUI is a widget which is used to show question...
                    getQuestionUI(
                      widget.controller.pvbox
                          .get(pvboxlength)!
                          .question
                          .toString(),
                    ),
                    // divider...
                    Divider(
                      color: Colours.secondaryColor,
                      thickness: 2,
                      indent: 80,
                      endIndent: 80,
                    ),
                    // some space
                    const SizedBox(height: 10),
                    // getAnswerUI is a widget which is used to show answer by server...
                    getAnswerUI(
                      widget.controller.pvbox
                          .get(pvboxlength)!
                          .answer
                          .toString(),
                      Get.height,
                      widget.controller.ActiveConnection.value,
                      widget.controller.isloading.value,
                    ),
                    getMoreOptions(
                      createdAt: widget.controller.pvbox
                          .get(widget.controller.pvbox.length - 1)!
                          .createdAt
                          .toString(),
                      id: widget.controller.pvbox
                          .get(widget.controller.pvbox.length - 1)!
                          .id
                          .toString(),
                      connectionStatus:
                          widget.controller.connectionOutlook.toString(),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
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
    inputController.dispose();
    bottomSheetController.dispose();
    super.dispose();
  }
}
