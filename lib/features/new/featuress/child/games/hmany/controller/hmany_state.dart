import 'package:equatable/equatable.dart';

class HmanyState extends Equatable {
  final int level;
  final List<String> board; // قائمة الأشكال المبعثرة في الشاشة
  final Map<String, int> targetCounts; // الأشكال المطلوب عدها وعددها الصحيح
  final Map<String, int> userAnswers; // إجابات المستخدم الحالية
  final bool isSuccess;

  const HmanyState({
    required this.level,
    required this.board,
    required this.targetCounts,
    this.userAnswers = const {},
    this.isSuccess = false,
  });

  HmanyState copyWith({
    int? level,
    List<String>? board,
    Map<String, int>? targetCounts,
    Map<String, int>? userAnswers,
    bool? isSuccess,
  }) {
    return HmanyState(
      level: level ?? this.level,
      board: board ?? this.board,
      targetCounts: targetCounts ?? this.targetCounts,
      userAnswers: userAnswers ?? this.userAnswers,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [
    level,
    board,
    targetCounts,
    userAnswers,
    isSuccess,
  ];
}
