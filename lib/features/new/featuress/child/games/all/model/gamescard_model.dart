class GameCardModel {
  final int level;
  final List<String> board;
  final List<int> flippedIndexes;
  final List<int> matchedIndexes;

  const GameCardModel({
    required this.level,
    required this.flippedIndexes,
    required this.matchedIndexes,
    required this.board,
  });

  GameCardModel copyWith({
    int? level,
    List<int>? flippedIndexes,
    List<int>? matchedIndexes,
    List<String>? board,
  }) {
    return GameCardModel(
      level: level ?? this.level,
      flippedIndexes: flippedIndexes ?? this.flippedIndexes,
      matchedIndexes: matchedIndexes ?? this.matchedIndexes,
      board: board ?? this.board,
    );
  }
}
