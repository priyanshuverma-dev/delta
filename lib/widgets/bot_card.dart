import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:answer_it/core/copy_text.dart';
import 'package:answer_it/core/delete_button.dart';
import 'package:answer_it/core/id_count.dart';
import 'package:answer_it/core/inAppNames.dart';
import 'package:answer_it/core/inAppUserIcon.dart';
import 'package:answer_it/localStorage/models/pvtalk.dart';
import 'package:answer_it/utlts/colors.dart';
import 'package:answer_it/utlts/global_vars.dart';
import 'package:flutter/material.dart';

class BotCard extends StatelessWidget {
  const BotCard({super.key, required this.data, required this.onDelete});

  final PvTalk data;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 50,
      color: Colors.black26,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 35.0,
          maxHeight: MediaQuery.of(context).size.height / 2,
          maxWidth: MediaQuery.of(context).size.width - 30,
          minWidth: MediaQuery.of(context).size.width - 30,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colours.secondaryColor,
                    ),
                    color: Colours.textColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        inAppUserIcon(Globals.bot),
                        inAppName(Globals.botName),
                        const Spacer(
                          flex: 2,
                        ),
                        idCount(data.id),
                        copyText(data.answer),
                        deleteButton(onDelete),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: AnimatedTextKit(
                    key: ValueKey(data.answer),
                    totalRepeatCount: 1,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        data.answer,
                        speed: const Duration(milliseconds: 20),
                        textStyle: TextStyle(
                          fontSize: 16,
                          color: Colours.textColorBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
