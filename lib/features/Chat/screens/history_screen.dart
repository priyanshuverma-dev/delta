import 'dart:ui';

import 'package:answer_it/core/snackbar.dart';
import 'package:answer_it/features/Chat/controller/controller.dart';
import 'package:answer_it/utils/colors.dart';
import 'package:answer_it/widgets/history_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatefulWidget {
  HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final Controller controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    ScrollController listController = ScrollController();

    return Scaffold(
      backgroundColor: Colours.darkScaffoldColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colours.darkScaffoldColor,
        title: Text(
          'History',
          style: TextStyle(
            color: Colours.textColor.withOpacity(0.7),
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 10,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey.shade100,
          ),
        ),
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () {
              if (listController.hasClients) {
                final upDis = listController.position.maxScrollExtent;

                if (listController.position != upDis) {
                  listController.jumpTo(upDis);
                  listController.animateTo(upDis,
                      duration: Duration(seconds: 3), curve: Curves.easeInOut);
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(
                Icons.arrow_upward,
                color: Colors.grey.shade200,
              ),
            ),
          ),
        ],
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Theme.of(context).secondaryHeaderColor,
          systemNavigationBarColor: Colours.textColor,
        ),
        child: SafeArea(
          child: Container(
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
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 15,
                sigmaY: 15,
              ),
              child: Column(
                children: [
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
                          onPressDelete: () {
                            controller.pvbox.deleteAt(index);
                            setState(() {});
                            Get.showSnackbar(
                              customSnakeBar(
                                'Deleted',
                                'Query Deleted',
                                Icons.delete_outline_rounded,
                                2,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
