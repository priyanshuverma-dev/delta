import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:answer_it/core/toaster.dart';
import 'package:answer_it/features/youtube_video/services/api_service.dart';
import 'package:answer_it/widgets/youtube_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'package:answer_it/DeviceDataBase/models/pvtalk.dart';
import 'package:answer_it/core/snackbar.dart';
import 'package:answer_it/features/Chat/controller/controller.dart';
import 'package:answer_it/features/Chat/controller/texttospeech.dart';
import 'package:answer_it/main.dart';
import 'package:answer_it/utils/colors.dart';
import 'package:answer_it/utils/global_vars.dart';
import 'package:answer_it/widgets/answer_card.dart';
import 'package:answer_it/widgets/more_bar_container.dart';
import 'package:answer_it/widgets/question_card.dart';
import 'package:answer_it/widgets/textfield_area.dart';

class ChatScreen extends StatefulWidget {
  final Controller controller = Get.put(Controller());
  final YTAPIService videoController = Get.put(YTAPIService());

  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController inputController = TextEditingController();
  late AnimationController bottomSheetController;
  late stt.SpeechToText _speech;
  bool _isListening = false;
  bool videoApiLoading = false;

  @override
  void initState() {
    bottomSheetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _speech = stt.SpeechToText();

    super.initState();
  }

  // user input capture and sent to server...
  void clickAsk(String input) async {
    FocusScope.of(context).unfocus();

    log(widget.videoController.videoResult.toString());

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
      SpeechApi.speak(widget.controller.messageOutput.text);
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

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) {
          log('onStatus: $val');
          if (val == 'done') {
            setState(() {
              _isListening = false;
              widget.controller.status.value = 'done';
            });
            _speech.stop();
          }
        },
        onError: (val) {
          log('onError: $val');
        },
      );
      if (available) {
        setState(() => _isListening = true);
        toast('listening', Colours.textColor, 18);
        _speech.listen(
          listenFor: Duration(seconds: 20),
          onResult: (val) => setState(
            () {
              widget.controller.sttText.value = val.recognizedWords;
              inputController.text = widget.controller.sttText.toString();
              if (val.hasConfidenceRating && val.confidence > 0) {
                widget.controller.confidence.value = val.confidence;
              }
              if (widget.controller.status.value == 'done') {
                _speech.stop();
                setState(() {
                  _isListening = false;
                  widget.controller.status.value = '';
                });
              }
            },
          ),
        );
      }
    } else {
      toast('listening stop', Colours.textColor, 18);
      setState(() => _isListening = false);
      _speech.stop();
    }
    log(widget.controller.sttText.toString());
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
        // backgroundColor: Colors.transparent,
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
                  backgroundColor: Colours.darkScaffoldColor,
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
                                  confidence:
                                      (widget.controller.confidence.value *
                                              100.0)
                                          .toStringAsFixed(1),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    await widget.videoController.callAPI(
                                      widget.controller.pvbox
                                          .get(widget.controller.pvbox.length -
                                              1)!
                                          .question
                                          .toString(),
                                    );
                                    setState(() {
                                      videoApiLoading = true;
                                      Future.delayed(Duration(seconds: 2), () {
                                        setState(() {
                                          videoApiLoading = false;
                                        });
                                      });
                                      widget.controller.youtubeCardEnabled
                                          .value = true;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 16),
                                        child: Icon(
                                          Icons.refresh,
                                          color: Colours.textColor
                                              .withOpacity(0.5),
                                          size: 24,
                                        ),
                                      ),
                                      Text(
                                        "Search on Youtube",
                                        style: TextStyle(
                                          color: Colours.textColor
                                              .withOpacity(0.5),
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor: Colours.darkScaffoldColor
                                        .withOpacity(0.7),
                                    fixedSize: Size(Get.width - 50, 50),
                                  ),
                                ),
                                widget.controller.youtubeCardEnabled.value ==
                                        true
                                    ? videoApiLoading == true
                                        ? Container(
                                            padding: const EdgeInsets.all(16.0),
                                            margin: const EdgeInsets.only(
                                              right: 16.0,
                                              left: 16.0,
                                              bottom: 10,
                                              top: 20,
                                            ),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Colors.white12,
                                                  Colors.white10,
                                                ],
                                              ),
                                              color: Colours.primarySwatch
                                                  .withOpacity(0.5),
                                              // color: Color.fromRGBO(48, 49, 52, 0.2),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(15.0),
                                                bottomRight:
                                                    Radius.circular(15.0),
                                                topLeft: Radius.circular(15.0),
                                                topRight: Radius.circular(15.0),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  // color: Colors.grey.withOpacity(0.2),
                                                  color: Color.fromRGBO(
                                                      118, 118, 118, 0.2),
                                                  offset: const Offset(0, 2),
                                                  blurRadius: 8.0,
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(24),
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colours.textColor,
                                                ),
                                              ),
                                            ),
                                          )
                                        : youtubeCard(
                                            widget.videoController.videoResult,
                                            widget.videoController.videoResult
                                                .length,
                                          )
                                    : SizedBox(),

                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                      getSearchBarUI(
                        hintText: 'Ask anything...',
                        isListen: _isListening,
                        isloading: widget.controller.isloading.value,
                        textEditingController: inputController,
                        onPressed: () {
                          widget.controller.youtubeCardEnabled.value = false;
                          FocusScope.of(context).requestFocus(FocusNode());
                          clickAsk(inputController.text);
                        },
                        onPressMic: () {
                          widget.controller.youtubeCardEnabled.value = false;
                          _listen();
                          log('listening');
                        },
                        onLongPress: () => inputController.clear(),
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
