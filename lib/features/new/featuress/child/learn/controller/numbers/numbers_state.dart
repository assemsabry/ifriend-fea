import 'package:equatable/equatable.dart';

class NumbersState extends Equatable {
  final int level;
  final List<String> board;
  final int currentIndex; // هذا هو الأهم حالياً لتحديد الرقم الظاهر
  final bool isSpeaking;

  const NumbersState({
    required this.level,
    required this.board,
    this.currentIndex = 0,
    this.isSpeaking = false,
  });

  NumbersState copyWith({
    int? level,
    List<String>? board,
    int? currentIndex,
    bool? isSpeaking,
  }) {
    return NumbersState(
      level: level ?? this.level,
      board: board ?? this.board,
      currentIndex: currentIndex ?? this.currentIndex,
      isSpeaking: isSpeaking ?? this.isSpeaking,
    );
  }

  @override
  List<Object?> get props => [level, board, currentIndex, isSpeaking];
}
