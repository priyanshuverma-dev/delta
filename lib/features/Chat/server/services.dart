// ignore_for_file: avoid_print

import 'package:delta/utils/failure.dart';
import 'package:delta/utils/type_defs.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final gptServiceProvider = Provider((ref) {
  final gemini = Gemini.instance;
  return GPTServices(gemini: gemini);
});

class GPTServices {
  final Gemini _gemini;
  const GPTServices({required Gemini gemini}) : _gemini = gemini;

  FutureEither<String?> fetchChatAns({
    required String prompt,
  }) async {
    try {
     _gemini
          .streamGenerateContent(prompt)
          .listen((value) {})
          .onError((e) {});
      // return right(response.first.toString());
      return right("");
    } on GeminiException catch (err) {
      print('catch error ->${err.message}');
      return left(
        Failure(
          err.message.toString(),
          err.statusCode ?? 00,
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
