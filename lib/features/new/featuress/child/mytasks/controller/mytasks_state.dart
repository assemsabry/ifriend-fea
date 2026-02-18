part of 'mytasks_cubit.dart';

@immutable
abstract class MyTasksState {}

class MyTasksStateInitialStates extends MyTasksState {}

class MyTasksLoadingStates extends MyTasksState {}

class MyTasksSuccessStates extends MyTasksState {
  final MyTasksModel myTasksModel;

  MyTasksSuccessStates({required this.myTasksModel});
}

class MyTasksErrorStates extends MyTasksState {
  final String error;

  MyTasksErrorStates({required this.error});
}

class MyTasksUpdateLoadingStates extends MyTasksState {}

class MyTasksUpdateSuccessStates extends MyTasksState {}

class MyTasksUpdateErrorStates extends MyTasksState {
  final String error;

  MyTasksUpdateErrorStates({required this.error});
}

class MyTasksSwitchLoadingStates extends MyTasksState {}

class MyTasksSwitchSuccessStates extends MyTasksState {}

class MyTasksSwitchErrorStates extends MyTasksState {
  final String error;

  MyTasksSwitchErrorStates({required this.error});
}

class MyTasksChangeTypeStates extends MyTasksState {}

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
