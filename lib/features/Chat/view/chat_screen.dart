import 'package:delta/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delta/widgets/textfield_area.dart';

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
  final gemini = Gemini.instance;
  final TextEditingController inputController = TextEditingController();

  // user input capture and sent to server...
  void clickAsk(String input) async {
    FocusScope.of(context).unfocus();
    // sending question to server execution...
    if (input.isEmpty) {
      return showSnackBar(context, 'Please fill in the blanks 👀');
    }

    gemini.streamGenerateContent(input).listen((data) {}, onError: (er) {
      showSnackBar(context, "Something went wrong! Check your API KEY.");
      gemini.typeProvider?.loading = false;
    }, cancelOnError: true);
    inputController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideKeyboard,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 150,
              child: GeminiResponseTypeView(
                builder: (context, child, response, loading) {
                  if (loading && response == null) {
                    return const LoadingSkeletion();
                  }

                  if (response == null) {
                    return const Center(
                        child: Text('Get knowledge from Gemini AI!'));
                  }
                  return Markdown(
                    data: response,
                    selectable: true,
                  );
                },
              ),
            ),
            SearchBarUI(
              hintText: 'write anything...',
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
    );
  }

  // Close All Boxes.....
  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }
}
