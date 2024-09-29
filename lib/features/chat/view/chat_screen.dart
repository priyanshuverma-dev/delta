import 'package:delta/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:delta/widgets/textfield_area.dart';
import 'package:mistralai_dart/mistralai_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/loading_skeletion.dart';

class ChatScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const ChatScreen(),
      );

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final client = MistralAIClient();
  final TextEditingController inputController = TextEditingController();
  var loading = false;
  String?r;
  // user input capture and sent to server...
  void clickAsk(String input) async {
    FocusScope.of(context).unfocus();
    // sending question to server execution...
    if (input.isEmpty) {
      return showSnackBar(context, 'Please fill in the blanks 👀');
    }
    final prefs = await SharedPreferences.getInstance();
  final key = prefs.getString("API") ?? "";
  final client = MistralAIClient(
    apiKey: key,
  );
  setState(() {
    loading = true;
  });
   var res = await client.createChatCompletion(
    request: ChatCompletionRequest(
      model: const ChatCompletionModel.model(ChatCompletionModels.mistralMedium),
      temperature: 0,
      messages: [
        ChatCompletionMessage(
          role: ChatCompletionMessageRole.user,
          content: input,
        ),
      ],
    ),
  );
  
  setState(() {
    loading = false;
    r = res.choices.first.message?.content;
  });

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
              height: MediaQuery.of(context).size.height * 0.75,
              child: Visibility(
               visible: r == null,
               replacement: Markdown(
                    data: r ?? "",
                    selectable: true,
                  ),
                child: loading? const LoadingSkeletion() : const Text('Get knowledge from Mistral AI!'),
              
               ),
            ),
            SearchBarUI(
              hintText: 'write anything...',
              isloading: loading,
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
