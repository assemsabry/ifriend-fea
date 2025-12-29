import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ifriend_app/features/complete_profile/domain/entity/profile_entity.dart';
import 'package:ifriend_app/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:ifriend_app/features/profile/domain/usecases/update_profile_usecase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase _getProfileUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;

  ProfileCubit({
    required GetProfileUseCase getProfileUseCase,
    required UpdateProfileUseCase updateProfileUseCase,
  }) : _getProfileUseCase = getProfileUseCase,
       _updateProfileUseCase = updateProfileUseCase,
       super(ProfileInitial());

  Future<void> getParentProfile() async {
    emit(ProfileLoading());
    try {
      final result = await _getProfileUseCase.call();
      result.fold(
        (failure) {
          emit(ProfileError(message: failure.message));
        },
        (profile) {
          emit(ProfileLoaded(profile: profile));
        },
      );
    } catch (e) {
      emit(ProfileError(message: 'Unexpected error'));
    }
  }

  Future<void> updateParentProfile({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    File? avatar,
  }) async {
    emit(ProfileLoading());
    try {
      final result = await _updateProfileUseCase.call(
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        email: email,
        avatar: avatar,
      );

      result.fold(
        (failure) {
          emit(ProfileError(message: failure.message));
        },
        (profile) {
          emit(ProfileLoaded(profile: profile));
        },
      );
    } catch (e) {
      emit(ProfileError(message: 'Unexpected error'));
    }
  }
}
