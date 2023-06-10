import 'package:answer_it/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:answer_it/widgets/textfield_area.dart';

import '../../../core/loading_page.dart';
import '../controller/controller.dart';
import '../widgets/loading_skeletion.dart';

class ChatScreen extends ConsumerStatefulWidget {
  ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController inputController = TextEditingController();

  // user input capture and sent to server...
  void clickAsk(String input) async {
    FocusScope.of(context).unfocus();
    // sending question to server execution...
    if (input.isEmpty) {
      return showSnackBar(context, 'Please fill input');
    }

    ref
        .watch(gptControllerStateProvider.notifier)
        .getAns(prompt: input, context: context);
  }

  @override
  Widget build(BuildContext context) {
    final isloading = ref.watch(gptControllerStateProvider);

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: [
              Expanded(
                child: ref
                            .read(gptControllerStateProvider.notifier)
                            .answers
                            .length !=
                        0
                    ? Container(
                        child: isloading
                            ? LoadingSleletion()
                            : ListTile(
                                title: Text(ref
                                    .read(gptControllerStateProvider.notifier)
                                    .answers[0]),
                              ),
                      )
                    : SizedBox(),
              ),
              getSearchBarUI(
                hintText: 'Ask anything...',
                isloading: false,
                textEditingController: inputController,
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  clickAsk(inputController.text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Close All Boxes.....
  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }
}
