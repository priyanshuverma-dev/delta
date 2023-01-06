import 'package:answer_it/features/Chat/controller/controller.dart';
import 'package:answer_it/features/Chat/screens/chat_screen.dart';
import 'package:answer_it/utils/colors.dart';
import 'package:answer_it/widgets/history_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({super.key});

  final Controller controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    ScrollController listController = ScrollController();

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Theme.of(context).secondaryHeaderColor,
            systemNavigationBarColor: Colours.textColor,
          ),
          child: Container(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colours.secondaryColor,
                  ),
                  // AppBar...
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Get.to(
                          () => ChatScreen(),
                          duration: Duration(milliseconds: 400),
                          transition: Transition.upToDown,
                        ),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.grey.shade100,
                        ),
                      ),
                      Hero(
                        tag: 'heading',
                        child: Text(
                          'HISTORY',
                          style: TextStyle(
                            color: Colors.grey.shade100,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (listController.hasClients) {
                            final upDis =
                                listController.position.maxScrollExtent;

                            if (listController.position != upDis) {
                              listController.jumpTo(upDis);
                              listController.animateTo(upDis,
                                  duration: Duration(seconds: 3),
                                  curve: Curves.easeInOut);
                            }
                          }
                        },
                        child: Icon(
                          Icons.arrow_upward,
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    controller: listController,
                    reverse: true,
                    scrollDirection: Axis.vertical,
                    itemCount: controller.pvbox.length,
                    itemBuilder: (context, index) {
                      return historyCard(
                        userText: controller.pvbox.getAt(index)!.question,
                        botText: controller.pvbox.getAt(index)!.answer,
                        id: controller.pvbox.getAt(index)!.id,
                        createdAt: controller.pvbox.getAt(index)!.createdAt,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
