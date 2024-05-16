import 'package:delta/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delta/widgets/textfield_area.dart';

import '../controller/controller.dart';
import '../widgets/answer_box.dart';
import '../widgets/loading_skeletion.dart';

class ChatScreen extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const ChatScreen(),
      );

  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController inputController = TextEditingController();

  // user input capture and sent to server...
  void clickAsk(String input) async {
    FocusScope.of(context).unfocus();
    // sending question to server execution...
    if (input.isEmpty) {
      return showSnackBar(context, 'Please fill in the blanks 👀');
    }

    ref
        .read(gptControllerStateProvider.notifier)
        .getAns(prompt: input, context: context);

    inputController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final isloading = ref.watch(gptControllerStateProvider);

    return GestureDetector(
      onTap: hideKeyboard,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            getSearchBarUI(
              hintText: 'Ask anything...',
              isloading: false,
              textEditingController: inputController,
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                clickAsk(inputController.text);
              },
            ),
            // GeminiResponseTypeView(
            //   builder: (context, child, response, loading) {
            //     if (loading) {
            //       /// show loading animation or use CircularProgressIndicator();
            //       return const CircularProgressIndicator();
            //     }

            //     /// The runtimeType of response is String?
            //     if (response != null) {
            //       return Markdown(
            //         data: response,
            //         selectable: true,
            //       );
            //     } else {
            //       /// idle state
            //       return const Center(child: Text('Search something!'));
            //     }
            //   },
            // ),
            Visibility(
              visible: !isloading,
              replacement: const LoadingSkeletion(),
              child: Visibility(
                replacement:
                    const Text('Hi, Start asking questions from GPT-4.'),
                child: AnswerBox(
                  text: ref
                      .watch(gptControllerStateProvider.notifier)
                      .oneWay
                      .response,
                  prompt: ref
                      .watch(gptControllerStateProvider.notifier)
                      .oneWay
                      .prompt,
                ),
              ),
            ),
            // Visibility(
            //   visible: ref
            //       .watch(gptControllerStateProvider.notifier)
            //       .recentres
            //       .isNotEmpty,
            //   child: RecentBox(
            //     text: ref.watch(gptControllerStateProvider.notifier).recentres,
            //   ),
            // )
          ],
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
