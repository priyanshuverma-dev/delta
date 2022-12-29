import 'package:answer_it/core/copy_text.dart';
import 'package:answer_it/core/delete_button.dart';
import 'package:answer_it/core/id_count.dart';
import 'package:answer_it/core/inAppNames.dart';
import 'package:answer_it/core/inAppUserIcon.dart';
import 'package:answer_it/localStorage/models/dataModel.dart';
import 'package:answer_it/utlts/colors.dart';
import 'package:answer_it/utlts/global_vars.dart';
import 'package:flutter/material.dart';

class UserCard extends StatefulWidget {
  const UserCard({
    super.key,
    required this.userData,
    required this.onDelete,
  });

  final UserData userData;
  final VoidCallback onDelete;

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
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
            reverse: true,
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    widget.userData.question,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colours.textColorBlack,
                    ),
                  ),
                ),
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
                        idCount(widget.userData.id),
                        const Spacer(flex: 2),
                        copyText(widget.userData.question),
                        deleteButton(widget.onDelete),
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
