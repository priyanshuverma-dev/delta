import 'package:delta/features/Chat/server/services.dart';
import 'package:delta/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final gptControllerStateProvider =
    StateNotifierProvider<GPTController, bool>((ref) { 
    return GPTController(
        gptServices: ref.watch(gptServiceProvider));
  
});

class GPTController extends StateNotifier<bool> {
  final GPTServices _gptServices;

  String recentres = '';
  OneWay oneWay = OneWay(prompt: '', response: '');

  GPTController({
    required GPTServices gptServices,
  })  : _gptServices = gptServices,
        super(false);

  void getAns({
    required String prompt,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _gptServices.fetchChatAns(prompt: prompt);

    

    state = false;

    res.fold((l) => showSnackBar(context, l.message), (r) {
      if (r == null) {
        return showSnackBar(context, 'Unable to get try again!');
      }
      oneWay.prompt = prompt;
      oneWay.response = r;
      recentres = r;
    });
  }
}

class OneWay {
  String prompt;
  String response;
  OneWay({required this.prompt, required this.response});
}
