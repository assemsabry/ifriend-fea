import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:ifriend_app/features/new/featuress/child/learn/controller/letters/letters_state.dart';

class LettersCubit extends Cubit<LettersState> {
  final FlutterTts _flutterTts = FlutterTts();

  LettersCubit() : super(const LettersState(level: 1, board: [])) {
    _initTts();
    setupLevel(1);
  }

  final Map<String, String> _letterWords = {
    "A": "ALLIGATOR",
    "B": "BEAR",
    "C": "CAT",
    "D": "DUCK",
    "E": "ELEPHANT",
    "F": "FROG",
    "G": "GIRAFFE",
    "H": "HIPPOPOTAMUS",
    "I": "IGUANA",
    "J": "JELLYFISH",
    "K": "KANGAROO",
    "L": "LION",
    "M": "MONKEY",
    "N": "NARWHAL",
    "O": "OCTOPUS",
    "P": "PENGUIN",
    "Q": "QUEEN BEE",
    "R": "RABBIT",
    "S": "SHARK",
    "T": "TURTLE",
    "U": "UNICORN",
    "V": "VULTURE",
    "W": "WHALE",
    "X": "X-RAY FISH",
    "Y": "YAK",
    "Z": "ZEBRA",
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

  final Map<int, List<String>> _lettersLevels = {
    1: ["A.svg"],
    2: ["B.svg"],
    3: ["C.svg"],
    4: ["D.svg"],
    5: ["E.svg"],
    6: ["F.svg"],
    7: ["G.svg"],
    8: ["H.svg"],
    9: ["I.svg"],
    10: ["J.svg"],
    11: ["K.svg"],
    12: ["L.svg"],
    13: ["M.svg"],
    14: ["N.svg"],
    15: ["O.svg"],
    16: ["P.svg"],
    17: ["Q.svg"],
    18: ["R.svg"],
    19: ["S.svg"],
    20: ["T.svg"],
    21: ["U.svg"],
    22: ["V.svg"],
    23: ["W.svg"],
    24: ["X.svg"],
    25: ["Y.svg"],
    26: ["Z.svg"],
  };

  void setupLevel(int level) {
    List<String>? baseAssets = _lettersLevels[level];
    if (baseAssets == null) return;
    emit(state.copyWith(level: level, board: baseAssets, currentIndex: 0));
  }

  // الدالة المطلوبة للنطق المزدوج
  void speakCurrentLetter() async {
    String fileName = state.board[state.currentIndex];
    String rawLetter = fileName.split('.').first;
    String letterToSpeak = rawLetter;
    String word = _letterWords[rawLetter] ?? "";
    emit(state.copyWith(isSpeaking: true));
    await _flutterTts.setLanguage("en-US");
    // ينطق: "1" ثم "1 Egg"
    await _flutterTts.speak(letterToSpeak);
    await Future.delayed(const Duration(milliseconds: 1000));
    await _flutterTts.speak("$letterToSpeak $word");

    emit(state.copyWith(isSpeaking: false));
  }

  void nextLetter() {
    if (state.currentIndex < state.board.length - 1) {
      emit(state.copyWith(currentIndex: state.currentIndex + 1));
    } else {
      nextLevel();
    }
  }

  void nextLevel() {
    if (state.level < _lettersLevels.length) {
      setupLevel(state.level + 1);
    } else {
      setupLevel(1);
    }
  }
}
