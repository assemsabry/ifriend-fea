import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifriend_app/features/old/onboarding/data/domain/usecases/get_onboarding_seen.dart';
import 'package:ifriend_app/features/old/onboarding/data/domain/usecases/set_onboarding_seen.dart';
import 'package:ifriend_app/features/old/onboarding/presentation/cubit/onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final GetOnboardingSeen getOnboardingSeen;
  final SetOnboardingSeen setOnboardingSeen;

  OnboardingCubit({
    required this.getOnboardingSeen,
    required this.setOnboardingSeen,
  }) : super(OnboardingState.intial());

  Future<void> loadSeen() async {
    emit(state.copyWith(isLoading: true));
    final seen = await getOnboardingSeen();
    emit(state.copyWith(isLoading: false, isCompleted: seen));
  }

  void jumpTo(int pageIndex) {
    emit(state.copyWith(pageIndex: pageIndex));
  }

  Future<void> continueOrFinish({required int totalPages}) async {
    final next = state.pageIndex + 1;
    if (next >= totalPages) {
      emit(state.copyWith(isLoading: true));
      await setOnboardingSeen.call(true);
      emit(state.copyWith(isLoading: false, isCompleted: true));
    } else {
      emit(state.copyWith(pageIndex: next));
    }
  }

  Future<void> skip() async {
    emit(state.copyWith(isLoading: true));
    await setOnboardingSeen.call(true);
    emit(state.copyWith(isLoading: false, isCompleted: true));
  }
}
