import 'dart:developer';
import 'package:answer_it/core/snackbar.dart';
import 'package:answer_it/localStorage/models/pvtalk.dart';
import 'package:answer_it/main.dart';
import 'package:answer_it/server/controller.dart';
import 'package:answer_it/utlts/colors.dart';
import 'package:answer_it/widgets/asking_section.dart';
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

  void clickAsk(String input) async {
    FocusScope.of(context).unfocus();

    // sending question to server execution...
    if (input.isEmpty) {
      Get.showSnackbar(customSnakeBar(
        'Please enter a question',
        'You can ask anything',
        Icons.error,
        2,
      ));
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

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Obx(
          () => dataLoading.isTrue
              ? Center(
                  child: CircularProgressIndicator(color: Colours.primaryColor),
                )
              : GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Text(
                                  'You :${widget.controller.pvbox.get(widget.controller.pvbox.length - 1)!.question.toString()}'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          child: Text(
                            widget.controller.pvbox
                                .get(widget.controller.pvbox.length - 1)!
                                .answer
                                .toString(),
                          ),
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
                        Container(
                          child: AskingSection(
                              usersInputController: inputController,
                              onPressAsk: () => clickAsk(inputController.text)),
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
    inputController.dispose();
    Hive.box('Box').close();
    super.dispose();
  }
}
