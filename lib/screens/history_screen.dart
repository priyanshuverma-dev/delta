import 'package:answer_it/controllers/controller.dart';
import 'package:answer_it/screens/home_screen.dart';
import 'package:answer_it/utlts/colors.dart';
import 'package:answer_it/widgets/history_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({super.key});
  final Controller controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    ScrollController listScrollController = ScrollController();
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
                          () => HomeScreen(),
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
                      SizedBox(width: 10),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    controller: listScrollController,
                    reverse: true,
                    scrollDirection: Axis.vertical,
                    itemCount: controller.pvbox.length,
                    itemBuilder: (context, index) {
                      Future.delayed(
                        Duration(seconds: 1),
                        () {
                          if (listScrollController.hasClients) {
                            final upPosition =
                                listScrollController.position.maxScrollExtent;

                            listScrollController.jumpTo(upPosition);
                            listScrollController.animateTo(
                              upPosition,
                              duration: Duration(seconds: 3),
                              curve: Curves.easeOut,
                            );
                          }
                        },
                      );

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
