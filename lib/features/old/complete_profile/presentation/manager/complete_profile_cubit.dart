import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:ifriend_app/features/old/complete_profile/domain/useCases/complete_profile_use_cases.dart';
import 'package:ifriend_app/features/old/complete_profile/domain/entity/profile_entity.dart';

part 'complete_profile_state.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileState> {
  final ImagePicker _picker = ImagePicker();
  final CreateParentProfileUseCase _createUseCase;

  CompleteProfileCubit({required CreateParentProfileUseCase createUseCase})
    : _createUseCase = createUseCase,
      super(CompleteProfileState.initial());

  void firstNameChanged(String value) =>
      emit(state.copyWith(firstName: value, errorMessage: null));

  void lastNameChanged(String value) =>
      emit(state.copyWith(lastName: value, errorMessage: null));

  void emailChanged(String value) =>
      emit(state.copyWith(email: value, errorMessage: null));

  void phoneChanged(String value) =>
      emit(state.copyWith(phone: value, errorMessage: null));

  Future<void> pickImage(ImageSource source) async {
    try {
      final picked = await _picker.pickImage(
        source: source,
        imageQuality: 70,
        maxWidth: 1024,
        maxHeight: 1024,
      );
      if (picked != null) {
        emit(state.copyWith(imageFile: File(picked.path)));
      }
    } catch (e) {
      // ignore or emit error
    }
  }

  void clearImage() => emit(state.copyWith(imageFile: null));

  Future<void> submit() async {
    if (state.firstName.trim().isEmpty) {
      emit(state.copyWith(errorMessage: 'Please enter first name'));
      return;
    }
    if (state.lastName.trim().isEmpty) {
      emit(state.copyWith(errorMessage: 'Please enter last name'));
      return;
    }
    if (state.phone.trim().isEmpty) {
      emit(state.copyWith(errorMessage: 'Please enter phone number'));
      return;
    }
    String normalizePhone(String input) {
      var digits = input.replaceAll(RegExp(r'[^0-9]'), '');

      // Remove international prefix variants for Egypt
      if (digits.startsWith('00')) {
        // e.g. 00201112345678 -> remove leading 00 -> 201112345678
        digits = digits.replaceFirst(RegExp(r'^00'), '');
      }
      if (digits.startsWith('20')) {
        // remove country code -> remaining should be without leading 0
        digits = digits.substring(2);
      }

      // At this point, digits is expected to be either 10 digits (without leading 0)
      // or 11 digits (with leading 0). Normalize to leading 0 + 10 digits.
      if (digits.length == 10) {
        digits = '0$digits';
      }

      return digits;
    }

    final normalizedPhone = normalizePhone(state.phone);
    if (!(normalizedPhone.length == 11 && normalizedPhone.startsWith('0'))) {
      emit(
        state.copyWith(
          errorMessage: 'Phone number must be 11 digits (e.g. 011xxxxxxxx)',
        ),
      );
      return;
    }

    // Prevent double submit
    if (state.isSubmitting) return;

    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    try {
      final result = await _createUseCase.call(
        firstName: state.firstName,
        lastName: state.lastName,
        phoneNumber: normalizedPhone,
        email: state.email,
        avatar: state.imageFile,
      );

      result.fold(
        (failure) => emit(
          state.copyWith(isSubmitting: false, errorMessage: failure.message),
        ),
        (profileEntity) => emit(
          state.copyWith(
            isSubmitting: false,
            isSuccess: true,
            profile: profileEntity,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(isSubmitting: false, errorMessage: 'Submission failed'),
      );
    }
  }
}
