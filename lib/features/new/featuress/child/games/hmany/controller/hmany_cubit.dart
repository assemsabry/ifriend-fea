import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:ifriend_app/features/new/featuress/child/games/hmany/controller/hmany_state.dart';

class HmanyCubit extends Cubit<HmanyState> {
  final FlutterTts _flutterTts = FlutterTts();

  HmanyCubit()
    : super(const HmanyState(level: 1, board: [], targetCounts: {})) {
    _initTts();
    setupLevel(1);
  }
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

  Future<void> _speak(String text) async {
    await _flutterTts.stop();
    await _flutterTts.speak(text);
  }

  final List<String> _wrongMessages = [
    "Oops! Try again!",
    "Don't give up!",
    "You can do it!",
    "Almost there!",
  ];

  final List<String> _successMessages = [
    "Great job!",
    "Amazing!",
    "You are a star!",
    "Fantastic work!",
  ];

  final List<String> _winMessages = [
    "Congratulations! You finished the game!",
    "You are a champion!",
    "Wonderful! You completed all levels!",
  ];

  final List<String> _shapes = [
    "circul.svg",
    // "non.svg",
    "Star.svg",
    "Rectangle.svg",
    "Polygon.svg",
  ];
  final Map<String, TextEditingController> controllers = {};

  void setupLevel(int level) {
    Random random = Random();
    List<String> board = [];
    Map<String, int> counts = {};

    int totalItems = 10 + (level * 5); // مستوى 1 = 15 شكل، مستوى 5 = 35 شكل

    List<String> currentLevelShapes = (_shapes..shuffle()).take(4).toList();
    controllers.clear();
    for (var shape in currentLevelShapes) {
      controllers[shape] = TextEditingController();
    }

    for (int i = 0; i < totalItems; i++) {
      String randomShape =
          currentLevelShapes[random.nextInt(currentLevelShapes.length)];
      board.add(randomShape);
      counts[randomShape] = (counts[randomShape] ?? 0) + 1;
    }

    board.shuffle();

    emit(
      HmanyState(
        level: level,
        board: board,
        targetCounts: counts,
        userAnswers: {for (var shape in currentLevelShapes) shape: 0},
        isSuccess: false,
      ),
    );
  }

  void updateAnswer(String shape, String value) {
    int? count = int.tryParse(value);
    if (count == null) return;

    final newAnswers = Map<String, int>.from(state.userAnswers);
    newAnswers[shape] = count;

    emit(state.copyWith(userAnswers: newAnswers));
    _checkWin(newAnswers);
  }

  void _checkWin(Map<String, int> answers) {
    bool allCorrect = true;
    state.targetCounts.forEach((shape, count) {
      if (answers[shape] != count) {
        allCorrect = false;
      }
    });

    if (allCorrect) {
      _speak(_successMessages[state.level % _successMessages.length]);

      for (var controller in controllers.values) {
        controller.clear();
      }
      emit(state.copyWith(isSuccess: true));
      Future.delayed(const Duration(seconds: 2), () {
        nextLevel();
      });
    } else {
      bool allFilled = true;

      answers.forEach((key, value) {
        if (value == 0) {
          allFilled = false;
        }
      });

      if (allFilled) {
        _speak(_wrongMessages[state.level % _wrongMessages.length]);
      }
    }
  }

  void nextLevel() {
    _speak("Level completed! Get ready!");

    if (state.level < 5) {
      setupLevel(state.level + 1);
    } else {
      _speak(_winMessages[0]);
    }
  }

  @override
  Future<void> close() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
    return super.close();
  }
}
