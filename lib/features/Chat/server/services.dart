import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';

class GPTServices {
  void chatComplete() async {
    final openAI = OpenAI.instance.build(
      token: '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',
      baseOption: HttpSetup(connectTimeout: const Duration(seconds: 5)),
      enableLog: true,
    );
    // openAI.setToken('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');
    final request = CompleteText(
      prompt: 'What is human life expectancy in the United States?',
      model: TextDavinci3Model(),
      maxTokens: 200,
    );

    final response = await openAI.onCompletion(request: request);

    print(response!.choices[0].text);
  }
}
