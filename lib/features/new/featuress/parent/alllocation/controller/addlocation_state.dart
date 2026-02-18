part of 'addlocation_cubit.dart';

@immutable
abstract class AddLocationState {}

class AddLocationInitial extends AddLocationState {}

class AddLocationLoading extends AddLocationState {}

class AddLocationSuccess extends AddLocationState {
  // final LoginModel loginModel;

  // LoginSuccess({required this.loginModel});
}

class AddLocationFailure extends AddLocationState {
  final String error;
  AddLocationFailure(this.error);
}

class AddLocationChangeVisibility extends AddLocationState {}

class AddLocationLoadingWidget extends AddLocationState {}

class AddLocationClearAllData extends AddLocationState {}

class LocationLoaded extends AddLocationState {
  final LatLng position;
  final String? address;

  LocationLoaded({required this.position, this.address});
}

class LocationLoading extends AddLocationState {}

class LocationError extends AddLocationState {}
