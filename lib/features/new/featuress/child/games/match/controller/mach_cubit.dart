import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifriend_app/features/new/featuress/child/games/match/controller/match_state.dart';

class MatchCubit extends Cubit<MatchState> {
  // الحالة الابتدائية متوافقة الآن مع المتغيرات الجديدة
  MatchCubit() : super(const MatchState(level: 1)) {
    setupLevel();
  }

  final Map<String, Color> colorData = {
    "white": Colors.white,
    "yellow": Colors.yellow,
    "orange": Colors.orange,
    "red": Colors.red,
    "pink": Colors.pink,
    "green": Colors.green,
    "blue": Colors.blue,
    "purple": Colors.purple,
    "brown": Colors.brown,
    "gray": Colors.grey,
    "black": Colors.black,
  };

  void setupLevel() {
    List<String> colors = colorData.keys.toList();
    List<String> shuffledApples = List.from(colors)..shuffle();

    emit(
      state.copyWith(
        colorNames: colors,
        shuffledApples: shuffledApples,
        matches: {}, // تم تصحيح الخطأ هنا (إسناد قيمة للمتغير matches)
        isSuccess: false,
      ),
    );
  }

  void matchColor(String colorName, String appleColor) {
    if (colorName == appleColor) {
      final newMatches = Map<String, bool>.from(state.matches);
      newMatches[colorName] = true;

      emit(state.copyWith(matches: newMatches));

      // التحقق من الفوز عند مطابقة جميع الألوان
      if (newMatches.length == state.colorNames.length) {
        emit(state.copyWith(isSuccess: true));
        // يمكنك إضافة تأخير ثم استدعاء المستوى التالي
        // Future.delayed(const Duration(seconds: 2), () => nextLevel());
      }
    }
  }

  Color getColorFromName(String name) {
    return colorData[name] ?? Colors.transparent;
  }

  void nextLevel() {
    if (state.level < 5) {
      emit(state.copyWith(level: state.level + 1));
      setupLevel();
    }
  }
}
