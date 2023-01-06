import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:answer_it/utils/colors.dart';
import 'package:answer_it/widgets/more_bar_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:answer_it/features/Chat/controller/controller.dart';
import 'package:answer_it/core/snackbar.dart';
import 'package:answer_it/DeviceDataBase/models/pvtalk.dart';
import 'package:answer_it/main.dart';
import 'package:answer_it/widgets/answer_card.dart';
import 'package:answer_it/widgets/question_card.dart';
import 'package:answer_it/widgets/textfield_area.dart';

class ChatScreen extends StatefulWidget {
  final Controller controller = Get.put(Controller());

  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
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
                Text('History'),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return widget.controller.pvbox.getAt(index)!.question ==
                                'Deleted'
                            ? SizedBox()
                            : Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.all(2),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: Get.width - 100,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          widget.controller.pvbox
                                              .getAt(index)!
                                              .question,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Center(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(25),
                                                margin:
                                                    const EdgeInsets.all(25),
                                                width: Get.width - 50,
                                                height: 187.5,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  border: Border.all(
                                                    width: 1,
                                                    color: Colors.grey,
                                                  ),
                                                  color: Colors.grey.shade300,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Warning !!',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 28,
                                                      ),
                                                    ),
                                                    Text(
                                                        'Do you want to delete this history.'),
                                                    SizedBox(height: 10),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        OutlinedButton(
                                                          style: OutlinedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Colours
                                                                    .primaryColor,
                                                            foregroundColor:
                                                                Colours
                                                                    .primaryColor,
                                                          ),
                                                          onPressed: () {
                                                            widget.controller
                                                                .pvbox
                                                                .putAt(
                                                              index,
                                                              PvTalk(
                                                                question:
                                                                    'Deleted',
                                                                answer: widget
                                                                    .controller
                                                                    .pvbox
                                                                    .getAt(
                                                                        index)!
                                                                    .answer,
                                                                createdAt: widget
                                                                    .controller
                                                                    .pvbox
                                                                    .getAt(
                                                                        index)!
                                                                    .createdAt,
                                                                id: widget
                                                                    .controller
                                                                    .pvbox
                                                                    .getAt(
                                                                        index)!
                                                                    .id,
                                                              ),
                                                            );
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            'Yes',
                                                            style: TextStyle(
                                                              color: Colours
                                                                  .textColor,
                                                            ),
                                                          ),
                                                        ),
                                                        OutlinedButton(
                                                          onPressed: () =>
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(),
                                                          style: OutlinedButton
                                                              .styleFrom(
                                                                  foregroundColor:
                                                                      Colours
                                                                          .primaryColor,
                                                                  side:
                                                                      BorderSide(
                                                                    color: Colors
                                                                        .black,
                                                                  )),
                                                          child: Text(
                                                            'Cancel',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      icon: Icon(
                                        Icons.delete_forever,
                                        color: Colors.red.shade300,
                                      ),
                                    )
                                  ],
                                ),
                              );
                      },
                    ),
                  ),
                )
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Answer it',
          style: TextStyle(
            wordSpacing: 2,
            letterSpacing: 2,
            color: Colours.textColor,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            fontFamily: 'header',
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colours.secondaryColor,
        actions: [
          PopupMenuButton(
            iconSize: 30,
            icon: Icon(
              Icons.more_vert,
              size: 30,
              color: Colours.textColor,
            ),
            tooltip: 'Menu',
            color: Colors.white,
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
                  child: Text(choice),
                );
              }).toList();
            },
            onSelected: (choice) {
              if (choice == 'Credits') {
                Get.toNamed(
                  '/credits',
                );
              } else if (choice == 'Feedback') {
                Get.toNamed(
                  '/feedback',
                );
              }
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
        enableFeedback: true,
        tooltip: 'Ask a Question',
        onPressed: () => onClickFloatingButton(),
        child: const Icon(Icons.add),
        backgroundColor: Colours.primaryColor,
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Theme.of(context).secondaryHeaderColor,
          systemNavigationBarColor: Colours.textColor,
        ),
        child: SafeArea(
          child: Obx(
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
                        context,
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
