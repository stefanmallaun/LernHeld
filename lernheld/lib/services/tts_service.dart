import 'package:flutter_tts/flutter_tts.dart';

class TTSService {
  final FlutterTts _flutterTts = FlutterTts();

  TTSService() {
    _flutterTts.setLanguage("de-AT");
    _flutterTts.setSpeechRate(0.5);
    _flutterTts.setVolume(1.0);
    _flutterTts.setPitch(1.0);
    _flutterTts.awaitSpeakCompletion(true);
  }

  Future<void> speak(String text) async {
    await _flutterTts.stop(); // <<< stop vorher
    await _flutterTts.speak(text); // <<< spricht und wartet bis es fertig ist
  }
}
