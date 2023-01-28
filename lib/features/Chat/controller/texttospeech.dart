import 'package:flutter_tts/flutter_tts.dart';

class SpeechApi {
  static FlutterTts tts = FlutterTts();

  static initTTS() {
    tts.setLanguage('en-IN');
  }

  static speak(String text) async {
    tts.speak(text);
  }
}
