part of 'complete_profile_cubit.dart';

@immutable
class CompleteProfileState {
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final File? imageFile;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;
  final ProfileEntity? profile;

  const CompleteProfileState({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    this.imageFile,
    required this.isSubmitting,
    required this.isSuccess,
    this.errorMessage,
    this.profile,
  });

  factory CompleteProfileState.initial() => const CompleteProfileState(
    firstName: '',
    lastName: '',
    phone: '',
    email: '',
    imageFile: null,
    isSubmitting: false,
    isSuccess: false,
    errorMessage: null,
    profile: null,
  );

  CompleteProfileState copyWith({
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    File? imageFile,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
    ProfileEntity? profile,
  }) {
    return CompleteProfileState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      imageFile: imageFile ?? this.imageFile,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
      profile: profile ?? this.profile,
    );
  }
}
