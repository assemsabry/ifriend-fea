import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:ifriend_app/features/new/featuress/child/games/all/controller/games_state.dart';

class GameCubit extends Cubit<GameState> {
  final FlutterTts _flutterTts = FlutterTts();

  GameCubit() : super(const GameState(level: 1, board: [])) {
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
  final Map<int, List<String>> _levelsData = {
    1: [
      "cat.svg",
      "Dog 1.svg",
      "Lion.svg",
      "Panda.svg",
      "Bear.svg",
      "Raccoon.svg",
      "Fox.svg",
      "Monkey.svg",
    ],
    2: [
      "Elephant.svg",
      "Giraffe.svg",
      "Zebra.svg",
      "Tiger.svg",
      "Hippo.svg",
      "Gorilla.svg",
      "Crocodile.svg",
      "Snake.svg",
    ],
    3: [
      "Wolf.svg",
      "Leopard.svg",
      "Moose.svg",
      "Buffalo.svg",
      "Sloth.svg",
      "Koala.svg",
      "Owl.svg",
      "Squirrel.svg",
    ],
    4: [
      "Cat 1.svg",
      "Dog 2.svg",
      "Chicken.svg",
      "Pig.svg",
      "Cow.svg",
      "Sheep.svg",
      "Duck.svg",
      "Horse.svg",
    ],
    5: [
      "Pikachu.svg",
      "Doraemon.svg",
      "Chococat.svg",
      "Keroppi.svg",
      "Cat 5.svg",
      "Dog 5.svg",
      "Ant.svg",
      "Hedgehog.svg",
    ],
  };

  void setupLevel(int level) {
    List<String>? baseImages = _levelsData[level];
    if (baseImages == null) return;

    List<String> fullBoard = [...baseImages, ...baseImages];

    fullBoard.shuffle();

    emit(
      GameState(
        level: level,
        board: fullBoard,
        flippedIndexes: [],
        matchedIndexes: [],
        isBusy: false,
      ),
    );
  }

  void onCardClick(int index) {
    if (state.isBusy ||
        state.flippedIndexes.contains(index) ||
        state.matchedIndexes.contains(index)) {
      return;
    }

    final newFlipped = [...state.flippedIndexes, index];
    emit(state.copyWith(flippedIndexes: newFlipped));

    if (newFlipped.length == 2) {
      _processMatching(newFlipped);
    }
  }

  bool isMatched = false;
  void _processMatching(List<int> flipped) {
    emit(state.copyWith(isBusy: true));

    if (state.board[flipped[0]] == state.board[flipped[1]]) {
      emit(state.copyWith(isMatched: true));
      _speak(_successMessages[state.level % _successMessages.length]);

      Future.delayed(const Duration(seconds: 2), () {
        emit(state.copyWith(isMatched: false));
      });
      final newMatched = [...state.matchedIndexes, ...flipped];
      emit(
        state.copyWith(
          matchedIndexes: newMatched,
          flippedIndexes: [],
          isBusy: false,
        ),
      );

      if (newMatched.length == 16) {
        Future.delayed(const Duration(milliseconds: 800), () => nextLevel());
        Future.delayed(const Duration(seconds: 2), () {
          emit(state.copyWith(isMatched: false));
        });
      }
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        emit(state.copyWith(isMatched: false));
        _speak(_wrongMessages[state.level % _wrongMessages.length]);
      });
      Future.delayed(const Duration(seconds: 1), () {
        emit(state.copyWith(flippedIndexes: [], isBusy: false));
      });
    }
  }

  void nextLevel() {
    if (state.level < 5) {
      _speak("Level completed! Get ready for the next one!");

      setupLevel(state.level + 1);
    } else {
      _speak(_winMessages[0]);

      // هنا يمكنك إطلاق حدث الفوز النهائي باللعبة
    }
  }
}
