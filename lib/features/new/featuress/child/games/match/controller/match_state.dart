import 'package:equatable/equatable.dart';

class MatchState extends Equatable {
  final int level;
  final List<String> colorNames; // أسماء الألوان (المربعات العلوية)
  final List<String> shuffledApples; // التفاحات الملونة المبعثرة
  final Map<String, bool> matches; // الألوان التي تم حلها بنجاح
  final bool isSuccess;

  const MatchState({
    required this.level,
    this.colorNames = const [],
    this.shuffledApples = const [],
    this.matches = const {},
    this.isSuccess = false,
  });

  MatchState copyWith({
    int? level,
    List<String>? colorNames,
    List<String>? shuffledApples,
    Map<String, bool>? matches,
    bool? isSuccess,
  }) {
    return MatchState(
      level: level ?? this.level,
      colorNames: colorNames ?? this.colorNames,
      shuffledApples: shuffledApples ?? this.shuffledApples,
      matches: matches ?? this.matches,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [
    level,
    colorNames,
    shuffledApples,
    matches,
    isSuccess,
  ];
}
