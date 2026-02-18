part of 'modes_cubit.dart';

@immutable
abstract class ModesState {}

class ModesStateInitialStates extends ModesState {}

class ModesLoadingStates extends ModesState {}

class ModesSuccessStates extends ModesState {
  final ModesModel modesModel;

  ModesSuccessStates({required this.modesModel});
}

class ModesErrorStates extends ModesState {
  final String error;

  ModesErrorStates({required this.error});
}

class ModesUpdateLoadingStates extends ModesState {}

class ModesUpdateSuccessStates extends ModesState {}

class ModesUpdateErrorStates extends ModesState {
  final String error;

  ModesUpdateErrorStates({required this.error});
}

class ModesSwitchLoadingStates extends ModesState {}

class ModesSwitchSuccessStates extends ModesState {}

class ModesSwitchErrorStates extends ModesState {
  final String error;

  ModesSwitchErrorStates({required this.error});
}

class ModesChangeTypeStates extends ModesState {}

TimeOfDay parseTime(String? time) {
  if (time == null || time.trim().isEmpty) {
    return TimeOfDay.now();
  }

  final value = time.trim().toUpperCase();

  // 🟢 AM / PM format
  if (value.contains('AM') || value.contains('PM')) {
    final isPM = value.contains('PM');

    final clean = value.replaceAll('AM', '').replaceAll('PM', '').trim();

    final parts = clean.split(':');

    int hour = int.parse(parts[0]);
    int minute = parts.length > 1 ? int.parse(parts[1]) : 0;

    // 12 AM = 0
    if (!isPM && hour == 12) hour = 0;

    // PM + not 12
    if (isPM && hour != 12) hour += 12;

    return TimeOfDay(hour: hour, minute: minute);
  }

  // 🟢 24-hour format
  if (value.contains(':')) {
    final parts = value.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  // fallback
  return TimeOfDay.now();
}
