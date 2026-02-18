part of 'editlocation_cubit.dart';

@immutable
abstract class EditLocationState {}

class EditLocationInitial extends EditLocationState {}

class EditLocationLoading extends EditLocationState {}

class EditLocationSuccess extends EditLocationState {
  // final LoginModel loginModel;

  // LoginSuccess({required this.loginModel});
}

class EditLocationFailure extends EditLocationState {
  final String error;
  EditLocationFailure(this.error);
}

class EditLocationChangeVisibility extends EditLocationState {}

class EditLocationLoadingWidget extends EditLocationState {}

class EditLocationClearAllData extends EditLocationState {}

class LocationLoaded extends EditLocationState {
  final LatLng position;
  final String? Editress;

  LocationLoaded({required this.position, this.Editress});
}

class LocationLoading extends EditLocationState {}

class LocationError extends EditLocationState {}
