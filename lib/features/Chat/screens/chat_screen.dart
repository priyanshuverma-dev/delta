import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:answer_it/features/Chat/controller/texttospeech.dart';
import 'package:answer_it/utils/colors.dart';
import 'package:answer_it/utils/global_vars.dart';
import 'package:answer_it/widgets/more_bar_container.dart';
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

  // onPress delete in bottom bar...
  void onPressDelete(index, BuildContext buildContext) {
    showDialog(
      barrierColor: Colors.transparent,
      context: buildContext,
      builder: (buildContext) {
        return Center(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 15,
              sigmaY: 15,
            ),
            child: Container(
              padding: const EdgeInsets.all(25),
              margin: const EdgeInsets.all(25),
              width: Get.width - 50,
              height: 187.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.white12,
                    Colors.white10,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                color: Colours.darkScaffoldColor,
              ),
              child: Column(
                children: [
                  Text(
                    'Warning !!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colours.textColor.withOpacity(0.7),
                      fontSize: 28,
                    ),
                  ),
                  Text('Do you want to delete this history.'),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                            foregroundColor: Colours.primaryColor,
                            side: BorderSide(
                              color: Colors.black,
                            )),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colours.darkScaffoldColor,
                          foregroundColor: Colours.darkScaffoldColor,
                          side: BorderSide(
                            color: Colours.darkScaffoldColor,
                          ),
                        ),
                        onPressed: () {
                          widget.controller.pvbox.putAt(
                            index,
                            PvTalk(
                              question: 'Deleted',
                              answer:
                                  widget.controller.pvbox.getAt(index)!.answer,
                              createdAt: widget.controller.pvbox
                                  .getAt(index)!
                                  .createdAt,
                              id: widget.controller.pvbox.getAt(index)!.id,
                            ),
                          );
                          Navigator.of(context).pop();
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Yes',
                          style: TextStyle(
                            color: Colors.red.shade300,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
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
        elevation: 10,
        backgroundColor: Colours.darkScaffoldColor,
        actions: [
          PopupMenuButton(
            iconSize: 30,
            icon: Icon(
              Icons.more_vert,
              size: 30,
              color: Colours.textColor,
            ),
            tooltip: 'Menu',
            color: Colours.darkScaffoldColor,
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
                  child: Text(choice,
                      style: TextStyle(
                        color: Colours.textColor,
                      )),
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
        leading: InkWell(
          onTap: () => Get.toNamed(
            '/credits',
          ),
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
      ),
      backgroundColor: Colours.darkScaffoldColor,
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
              child: Container(
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topLeft,
                    colors: [
                      Colours.secondaryColor.withOpacity(0.5),
                      Color.fromRGBO(115, 75, 109, 1),
                      Colors.white10,
                      Color.fromRGBO(66, 39, 90, 1),
                      Colours.primaryColor.withOpacity(0.5),
                    ],
                  ),
                ),
                child: RefreshIndicator(
                  semanticsLabel: 'Refresh',
                  color: Colours.textColor,
                  strokeWidth: RefreshProgressIndicator.defaultStrokeWidth + 1,
                  triggerMode: RefreshIndicatorTriggerMode.anywhere,
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
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          child: SingleChildScrollView(
                            // physics: const BouncingScrollPhysics(
                            //   parent: AlwaysScrollableScrollPhysics(),
                            // ),
                            physics: AlwaysScrollableScrollPhysics(),
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
                                  color: Colours.darkScaffoldColor,
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
                                // getMoreOptions is a widget which is used to show more info by server...
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
                                  connectionStatus: widget
                                      .controller.connectionOutlook
                                      .toString(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      getSearchBarUI(
                        'Ask anything...',
                        inputController,
                        () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          clickAsk(inputController.text);
                        },
                        () {
                          SpeechApi.speak(widget.controller.pvbox
                              .get(pvboxlength)!
                              .answer
                              .toString());
                        },
                        widget.controller.isloading.value,
                      ),
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
