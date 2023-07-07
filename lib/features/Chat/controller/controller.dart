import 'package:delta/features/Chat/server/services.dart';
import 'package:delta/utils/key/key.dart';
import 'package:delta/utils/utils.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/controller/prefs.dart';

final gptControllerStateProvider =
    StateNotifierProvider<GPTController, bool>((ref) {
  final keyGPTData = ref.watch(prefGetProvider(Prefs.gptApiKey));
  String? data = keyGPTData.when(
    data: (data) => data,
    error: (error, stackTrace) => null,
    loading: () => null,
  );

  if (data == null) {
    return GPTController(
        gptServices: ref.watch(
          gptServiceProvider(dotenv.get('OPENAI_API_KEY')),
        ),
        prefController: PrefController());
  } else {
    return GPTController(
        gptServices: ref.watch(gptServiceProvider(data)),
        prefController: PrefController());
  }
});

class GPTController extends StateNotifier<bool> {
  final GPTServices _gptServices;
  final PrefController _prefController;

  String recentres = '';
  OneWay oneWay = OneWay(prompt: '', response: '');

  GPTController({
    required GPTServices gptServices,
    required PrefController prefController,
  })  : _gptServices = gptServices,
        _prefController = prefController,
        super(false);

  void getAns({
    required String prompt,
    required BuildContext context,
  }) async {
    state = true;
    final model = TextDavinci3Model();
    final res = await _gptServices.fetchChatAns(prompt: prompt, model: model);

    state = false;

    res.fold((l) => showSnackBar(context, l.message), (r) {
      if (r == null) {
        return showSnackBar(context, 'Unable to get try again!');
      }
      oneWay.prompt = prompt;
      oneWay.response = r.choices[0].text;
      _prefController.setPrefs(Prefs.recentres, oneWay.response).then((value) {
        if (!value) {
          showSnackBar(context, "can't save to recent");
        }
      });
    });
  }
}

class OneWay {
  String prompt;
  String response;
  OneWay({required this.prompt, required this.response});
}
