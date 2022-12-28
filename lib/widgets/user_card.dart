import 'package:answer_it/core/copy_text.dart';
import 'package:answer_it/core/id_count.dart';
import 'package:answer_it/core/inAppNames.dart';
import 'package:answer_it/core/inAppUserIcon.dart';
import 'package:answer_it/utlts/colors.dart';
import 'package:answer_it/utlts/global_vars.dart';
import 'package:answer_it/widgets/toaster.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserCard extends StatefulWidget {
  const UserCard({super.key, required this.userQuestion});

  final String userQuestion;

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  String input = '';

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 50,
      color: Colors.transparent,
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
            reverse: true,
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
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
                        inAppUserIcon(Globals.user),
                        inAppName(Globals.userName),
                        const Spacer(flex: 2),
                        idCount('20'),
                        copyText(''),
                      ],
                    ),
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
