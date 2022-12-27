import 'package:answer_it/server_side/controller.dart';
import 'package:answer_it/utlts/colors.dart';
import 'package:answer_it/widgets/asking_section.dart';
import 'package:answer_it/widgets/bot_card.dart';
import 'package:answer_it/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  final Controller controller = Get.put(Controller());

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController inputController = TextEditingController();

  void clickAsk(
    String input,
  ) {
    FocusScope.of(context).unfocus();
    setState(() {
      widget.controller.userInput.text = input;
    });
    widget.controller.askQuestion();
    inputController.clear();
  }

  @override
  Widget build(BuildContext context) {
    String input = '';

    setState(() {
      input = inputController.text;
    });

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
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: 2,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return BotCard(
                          answer: widget.controller.message.toString(),
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height / 5,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: 2,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return UserCard(
                          userQuestion: input,
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
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
}
