import 'package:answer_it/utils/Failure.dart';
import 'package:answer_it/utils/type_defs.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final gptServiceProvider = Provider<GPTServices>((ref) {
  final openAI = OpenAI.instance.build(
      token: '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',
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
      enableLog: true);
  return GPTServices(openAI: openAI);
});

class GPTServices {
  final OpenAI _openAI;
  const GPTServices({required OpenAI openAI}) : _openAI = openAI;

  FutureEither<CompleteResponse?> fetchChatAns({
    required prompt,
    required Model model,
  }) async {
    final request = CompleteText(
      prompt: prompt,
      model: model,
      maxTokens: 200,
    );

    try {
      final response = await _openAI.onCompletion(request: request);
      return right(response);
    } on OpenAIRateLimitError catch (err) {
      print('catch error ->${err.data?.error.toMap()}');
      return left(
        Failure(
          err.data?.message.toString() ?? "Rate Limit crossed",
          err.data?.error.code as int,
        ),
      );
    } on OpenAIAuthError catch (err) {
      print('catch error ->${err.data?.error.toMap()}');
      return left(
        Failure(
          err.data?.message.toString() ?? "Auth Not Found",
          err.data?.error.code as int,
        ),
      );
    } on OpenAIServerError catch (err) {
      print('catch error ->${err.data?.error.toMap()}');
      return left(
        Failure(
          err.data?.message.toString() ?? "OpenAI server Error",
          err.data?.error.code as int,
        ),
      );
    } catch (e) {
      print('catch error ->$e');
      return left(
        Failure(
          e.toString(),
          501,
        ),
      );
    }
  }
}
