import 'package:flutter_tts/flutter_tts.dart';

class TTSService {
  final FlutterTts _tts = FlutterTts();

  TTSService() {
    _tts.setLanguage("de-AT");
    _tts.setSpeechRate(0.5);
  }

  Future<void> speak(String text) async {
    await _tts.stop(); // Stop previous speech
    await _tts.speak(text);
  }
}
