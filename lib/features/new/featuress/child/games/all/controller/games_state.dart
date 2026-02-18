import 'package:equatable/equatable.dart';

class GameState extends Equatable {
  final int level;
  final List<String> board;
  final List<int> flippedIndexes;
  final List<int> matchedIndexes;
  final bool isBusy;
  final bool isMatched;
  const GameState({
    required this.level,
    required this.board,
    this.flippedIndexes = const [],
    this.matchedIndexes = const [],
    this.isBusy = false,
    this.isMatched = false,
  });

  GameState copyWith({
    int? level,
    List<String>? board,
    List<int>? flippedIndexes,
    List<int>? matchedIndexes,
    bool? isBusy,
    bool? isMatched,
  }) {
    return GameState(
      level: level ?? this.level,
      board: board ?? this.board,
      flippedIndexes: flippedIndexes ?? this.flippedIndexes,
      matchedIndexes: matchedIndexes ?? this.matchedIndexes,
      isBusy: isBusy ?? this.isBusy,
      isMatched: isMatched ?? this.isMatched,
    );
  }

  @override
  List<Object?> get props => [
    level,
    board,
    flippedIndexes,
    matchedIndexes,
    isBusy,
    isMatched,
  ];
}
