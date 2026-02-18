part of 'alllocation_cubit.dart';

@immutable
abstract class AllLocationState {}

class AllLocationStateInitialStates extends AllLocationState {}

class AllLocationLoadingStates extends AllLocationState {}

class AllLocationSuccessStates extends AllLocationState {
  final AllsavezoneModel allsavezoneModel;

  AllLocationSuccessStates({required this.allsavezoneModel});
}

class AllLocationErrorStates extends AllLocationState {
  final String error;

  AllLocationErrorStates({required this.error});
}

class AllMyChildLocationsLoadingStates extends AllLocationState {}

class AllMyChildLocationsSuccessStates extends AllLocationState {
  final AllMyChildLocationModel allMyChildLocationsModel;

  AllMyChildLocationsSuccessStates({required this.allMyChildLocationsModel});
}

class AllMyChildLocationsErrorStates extends AllLocationState {
  final String error;

  AllMyChildLocationsErrorStates({required this.error});
}

class ChildLocationLoadingStates extends AllLocationState {}

class ChildLocationSuccessStates extends AllLocationState {
  final ChildlocationModel childlocationModel;

  ChildLocationSuccessStates({required this.childlocationModel});
}

class ChildLocationErrorStates extends AllLocationState {
  final String error;

  ChildLocationErrorStates({required this.error});
}

class AllMyChildLoadingStates extends AllLocationState {}

class AllMyChildSuccessStates extends AllLocationState {
  final AllMyChildModel allMyChildModel;

  AllMyChildSuccessStates({required this.allMyChildModel});
}

class AllMyChildErrorStates extends AllLocationState {
  final String error;

  AllMyChildErrorStates({required this.error});
}

class DeleteTaskLoadingStates extends AllLocationState {}

class DeleteTaskSuccessStates extends AllLocationState {}

class DeleteTaskErrorStates extends AllLocationState {
  final String error;

  DeleteTaskErrorStates({required this.error});
}

class AllLocationChangeTypeStates extends AllLocationState {}

class AllLocationCleanDataStates extends AllLocationState {}

class PickFileSuccessStates extends AllLocationState {}

class AddressLoading extends AllLocationState {}

class AddressSuccess extends AllLocationState {}

class AddressError extends AllLocationState {
  final String error;

  AddressError({required this.error});
}
