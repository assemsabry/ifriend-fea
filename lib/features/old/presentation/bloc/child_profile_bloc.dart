import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifriend_app/features/old/presentation/bloc/child_profile_event.dart';
import 'package:ifriend_app/features/old/presentation/bloc/child_profile_state.dart';

class ChildProfileBloc extends Bloc<ChildProfileEvent, ChildProfileState> {
  ChildProfileBloc() : super(const ChildProfileState()) {
    on<NameChanged>(_onNameChanged);
    on<DateOfBirthChanged>(_onDateOfBirthChanged);
    on<GenderSelected>(_onGenderSelected);
    on<AvatarSelected>(_onAvatarSelected);
    on<SubmitChildProfile>(_onSubmitChildProfile);
  }

  void _onNameChanged(NameChanged event, Emitter<ChildProfileState> emit) {
    final newState = state.copyWith(name: event.name);
    emit(newState.copyWith(isValid: _validateState(newState)));
  }

  void _onDateOfBirthChanged(
    DateOfBirthChanged event,
    Emitter<ChildProfileState> emit,
  ) {
    final newState = state.copyWith(dateOfBirth: event.dateOfBirth);
    emit(newState.copyWith(isValid: _validateState(newState)));
  }

  void _onGenderSelected(
    GenderSelected event,
    Emitter<ChildProfileState> emit,
  ) {
    final newState = state.copyWith(gender: event.gender);
    emit(newState.copyWith(isValid: _validateState(newState)));
  }

  void _onAvatarSelected(
    AvatarSelected event,
    Emitter<ChildProfileState> emit,
  ) {
    final newState = state.copyWith(avatarPath: event.avatarPath);
    emit(newState.copyWith(isValid: _validateState(newState)));
  }

  void _onSubmitChildProfile(
    SubmitChildProfile event,
    Emitter<ChildProfileState> emit,
  ) {
    // This will be handled in the UI layer to navigate to next screen
    // No state change needed here for now
  }

  bool _validateState(ChildProfileState state) {
    return state.name.trim().isNotEmpty &&
        state.dateOfBirth != null &&
        state.gender != null;
  }
}
