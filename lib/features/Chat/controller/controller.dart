import 'package:answer_it/features/Chat/server/services.dart';
import 'package:answer_it/utils/utils.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gptControllerStateProvider =
    StateNotifierProvider<GPTController, bool>((ref) {
  return GPTController(gptServices: ref.watch(gptServiceProvider));
});

class GPTController extends StateNotifier<bool> {
  final GPTServices _gptServices;

  String answer = 'Welcome back!';

  GPTController({
    required GPTServices gptServices,
  })  : _gptServices = gptServices,
        super(false);

  void getAns({
    required String prompt,
    required BuildContext context,
  }) async {
    state = true;
    final model = TextDavinci2Model();
    final res = await _gptServices.fetchChatAns(prompt: prompt, model: model);

    state = false;

    res.fold((l) => showSnackBar(context, l.message), (r) {
      if (r == null) {
        return showSnackBar(context, 'Unable to get try again!');
      }
      answer = r.choices[0].text;
    });
  }
}
