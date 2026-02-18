import 'package:ifriend_app/features/new/featuress/child/apps/model/syncapps_model.dart';

abstract class SyncAppsState {}

class SyncAppsInitial extends SyncAppsState {}

class SyncAppsLoading extends SyncAppsState {}

class SyncAppsSuccess extends SyncAppsState {
  final List<SyncappsModel> apps;
  SyncAppsSuccess(this.apps);
}

class SyncAppsError extends SyncAppsState {
  final String message;
  SyncAppsError(this.message);
}

class SyncAppsSendLoading extends SyncAppsState {}

class SyncAppsSendSuccess extends SyncAppsState {}

class SyncAppsSendError extends SyncAppsState {
  final String message;
  SyncAppsSendError(this.message);
}
