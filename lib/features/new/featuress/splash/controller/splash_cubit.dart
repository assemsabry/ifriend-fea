import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void startTimer() {
    Timer(const Duration(seconds: 3), () {
      if (!isClosed) {
        emit(SplashNavigate());
      }
    });
  }

  // Future<void> start() async {
  //   emit(SplashLoading());

  //   await Future.delayed(const Duration(seconds: 3));

  //   final info = await PackageInfo.fromPlatform();
  //   final currentVersion = info.version;

  //   final latestVersion = "1.0.1+11";
  //   final forceUpdate = true;
  //   final storeUrl =
  //       "https://play.google.com/store/apps/details?id=com.quickpad.adqora";

  //   final needUpdate =
  //       forceUpdate && isUpdateRequired(currentVersion, latestVersion);

  //   if (needUpdate) {
  //     emit(SplashForceUpdate(storeUrl));
  //   } else {
  //     emit(SplashNavigate());
  //   }
  // }
}
