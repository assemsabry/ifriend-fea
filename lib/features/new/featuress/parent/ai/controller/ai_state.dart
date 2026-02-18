// part of 'ai_cubit.dart';

// @immutable
// abstract class AiState {}

// class AiStateInitialStates extends AiState {}

// class AiLoadingStates extends AiState {}

// class AiSuccessStates extends AiState {
//   final AiModel AiModel;

//   AiSuccessStates({required this.AiModel});
// }

// class AiErrorStates extends AiState {
//   final String error;

//   AiErrorStates({required this.error});
// }

// class AiUpdateLoadingStates extends AiState {}

// class AiUpdateSuccessStates extends AiState {}

// class AiUpdateErrorStates extends AiState {
//   final String error;

//   AiUpdateErrorStates({required this.error});
// }

// class AiSwitchLoadingStates extends AiState {}

// class AiSwitchSuccessStates extends AiState {}

// class AiSwitchErrorStates extends AiState {
//   final String error;

//   AiSwitchErrorStates({required this.error});
// }

// class AiChangeTypeStates extends AiState {}

// TimeOfDay parseTime(String? time) {
//   if (time == null || time.trim().isEmpty) {
//     return TimeOfDay.now();
//   }

//   final value = time.trim().toUpperCase();

//   // 🟢 AM / PM format
//   if (value.contains('AM') || value.contains('PM')) {
//     final isPM = value.contains('PM');

//     final clean = value.replaceAll('AM', '').replaceAll('PM', '').trim();

//     final parts = clean.split(':');

//     int hour = int.parse(parts[0]);
//     int minute = parts.length > 1 ? int.parse(parts[1]) : 0;

//     // 12 AM = 0
//     if (!isPM && hour == 12) hour = 0;

//     // PM + not 12
//     if (isPM && hour != 12) hour += 12;

//     return TimeOfDay(hour: hour, minute: minute);
//   }

//   // 🟢 24-hour format
//   if (value.contains(':')) {
//     final parts = value.split(':');
//     return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
//   }

//   // fallback
//   return TimeOfDay.now();
// }
