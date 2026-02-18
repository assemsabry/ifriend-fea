import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:ifriend_app/features/new/featuress/child/learn/controller/numbers/numbers_state.dart';

class NumbersCubit extends Cubit<NumbersState> {
  final FlutterTts _flutterTts = FlutterTts();

  NumbersCubit() : super(const NumbersState(level: 1, board: [])) {
    _initTts();
    setupLevel(1);
  }

  final Map<String, String> _numberWords = {
    "01": "Pineapple",
    "02": "Cherries",
    "03": "Apples",
    "04": "Tomatoes",
    "05": "Blackberries",
    "06": "Strawberries",
    "07": "Mangoes",
    "08": "Lemons",
    "09": "Eggplants",
    "10": "Bananas",
  };

  void _initTts() async {
    await _flutterTts.setLanguage("en-US");

    // الحصول على كل الأصوات المتاحة على الجهاز
    List<dynamic> voices = await _flutterTts.getVoices;

    try {
      // البحث عن صوت بجودة عالية (Natural)
      var bestVoice = voices.firstWhere(
        (voice) =>
            voice["name"].toString().toLowerCase().contains("natural") ||
            voice["name"].toString().toLowerCase().contains("premium"),
        orElse: () => voices.first,
      );

      if (bestVoice != null) {
        await _flutterTts.setVoice({
          "name": bestVoice["name"],
          "locale": bestVoice["locale"],
        });
      }
    } catch (e) {
      print("Error finding natural voice: $e");
    }

    await _flutterTts.setPitch(1.3);
    await _flutterTts.setSpeechRate(0.4);
    // await _flutterTts.setEngine("com.google.android.tts");
  }

  final Map<int, List<String>> _numbersLevels = {
    1: ["01.svg"],
    2: ["02.svg"],
    3: ["03.svg"],
    4: ["04.svg"],
    5: ["05.svg"],
    6: ["06.svg"],
    7: ["07.svg"],
    8: ["08.svg"],
    9: ["09.svg"],
    10: ["10.svg"],
  };

  void setupLevel(int level) {
    List<String>? baseAssets = _numbersLevels[level];
    if (baseAssets == null) return;
    emit(state.copyWith(level: level, board: baseAssets, currentIndex: 0));
  }

  // الدالة المطلوبة للنطق المزدوج
  void speakCurrentNumber() async {
    String fileName = state.board[state.currentIndex];
    String rawNumber = fileName.split('.').first;
    String numberToSpeak = int.parse(rawNumber).toString();
    String word = _numberWords[rawNumber] ?? "";
    emit(state.copyWith(isSpeaking: true));
    await _flutterTts.setLanguage("en-US");
    // ينطق: "1" ثم "1 Egg"
    await _flutterTts.speak(numberToSpeak);
    await Future.delayed(const Duration(milliseconds: 1000));
    await _flutterTts.speak("$numberToSpeak $word");
    emit(state.copyWith(isSpeaking: false));
  }

  void nextNumber() {
    if (state.currentIndex < state.board.length - 1) {
      emit(state.copyWith(currentIndex: state.currentIndex + 1));
    } else {
      nextLevel();
    }
  }

  void nextLevel() {
    if (state.level < _numbersLevels.length) {
      setupLevel(state.level + 1);
    } else {
      setupLevel(1);
    }
  }
}
