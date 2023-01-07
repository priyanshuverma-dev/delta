import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:answer_it/controllers/controller.dart';
import 'package:answer_it/core/divider.dart';
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

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController inputController = TextEditingController();

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
      log('ex : ' + widget.controller.pvbox.get(3)!.question.toString());

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
      final pvtalk = await PvTalk(
        question: inputController.text,
        answer: widget.controller.messageOutput.text,
        createdAt: DateTime.now(),
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

  @override
  Widget build(BuildContext context) {
    var dataLoading = widget.controller.isloading;
    var pvboxlength = widget.controller.pvbox.length - 1;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Obx(
          () => dataLoading.isTrue
              ? Center(
                  child: LinearProgressIndicator(),
                )
              : GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: RefreshIndicator(
                    onRefresh: () {
                      return Future.delayed(
                        Duration(seconds: 1),
                        () {
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
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(height: 10),
                          getSearchBarUI(
                            'Ask anything...',
                            inputController,
                            () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              clickAsk(inputController.text);
                            },
                          ),
                          // getQuestionUI is a widget which is used to show question...
                          getQuestionUI(
                            widget.controller.pvbox
                                .get(pvboxlength)!
                                .question
                                .toString(),
                          ),
                          colorDivider(),

                          const SizedBox(height: 10),
                          getAnswerUI(
                            widget.controller.pvbox
                                .get(pvboxlength)!
                                .answer
                                .toString(),
                            MediaQuery.of(context).size.height,
                            false,
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            child: Text(
                              widget.controller.pvbox
                                  .get(widget.controller.pvbox.length - 1)!
                                  .createdAt
                                  .toString(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            child: Text(
                              widget.controller.pvbox
                                  .get(widget.controller.pvbox.length - 1)!
                                  .id
                                  .toString(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            child: Text(
                                widget.controller.connectionOutlook.toString()),
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
    Hive.box('Box').close();
    super.dispose();
  }
}