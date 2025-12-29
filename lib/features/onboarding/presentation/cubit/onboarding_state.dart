import 'package:equatable/equatable.dart';

class OnboardingState extends Equatable {
  final int pageIndex;
  final bool isCompleted;
  final bool isLoading;

  const OnboardingState({
    required this.pageIndex,
    required this.isCompleted,
    this.isLoading = false,
  });

  factory OnboardingState.intial() =>
      const OnboardingState(pageIndex: 0, isCompleted: false);

  OnboardingState copyWith({
    int? pageIndex,
    bool? isCompleted,
    bool? isLoading,
  }) {
    return OnboardingState(
      pageIndex: pageIndex ?? this.pageIndex,
      isCompleted: isCompleted ?? this.isCompleted,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [pageIndex, isCompleted, isLoading];
}
