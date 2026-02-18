import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifriend_app/core/helpers/connectivity_helper.dart';
import 'package:ifriend_app/core/services/endpoint.dart';
import 'package:ifriend_app/features/new/featuress/child/apps/controller/syncapps_state.dart';
import 'package:ifriend_app/features/new/featuress/child/apps/model/syncapps_model.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:installed_apps/app_info.dart';
import 'package:ifriend_app/features/new/coree/dio/dio_helper.dart';
import 'package:ifriend_app/features/new/coree/local/hive_helper.dart';

class SyncAppsCubit extends Cubit<SyncAppsState> {
  SyncAppsCubit() : super(SyncAppsInitial());

  static SyncAppsCubit get(BuildContext context) => BlocProvider.of(context);

  List<SyncappsModel> _allApps = [];
  Map<String, dynamic> prepareAppsForBackend() {
    return {"apps": _allApps.map((e) => e.toJson()).toList()};
  }

  Future<void> getApps() async {
    emit(SyncAppsLoading());
    try {
      List<AppInfo> apps = await InstalledApps.getInstalledApps(withIcon: true);

      _allApps = apps
          .map(
            (app) => SyncappsModel(
              appName: app.name,
              packageName: app.packageName,
              icon: app.icon,
              isBlocked: false,
            ),
          )
          .toList();
      print(apps.first);
      sendApps();
      emit(SyncAppsSuccess(List.from(_allApps)));
    } catch (e) {
      emit(SyncAppsError(e.toString()));
    }
  }

  void toggleBlock(String packageName) {
    int index = _allApps.indexWhere((app) => app.packageName == packageName);
    if (index != -1) {
      _allApps[index].isBlocked = !_allApps[index].isBlocked;
      emit(
        SyncAppsSuccess(List.from(_allApps)),
      ); // إعادة إرسال الحالة لتحديث الواجهة
    }
  }

  Future<void> sendApps() async {
    final data = prepareAppsForBackend();

    try {
      final hasInternet = await FastConnectivityHelper.hasNetwork();
      if (!hasInternet) {
        emit(SyncAppsSendError("internet"));
        return;
      }

      emit(SyncAppsSendLoading());

      final value = await DioHelper.postData(
        url: EndPoints.syncApps,
        query: {"deviceId": HiveHelper.getData("deviceId")},
        token: HiveHelper.getData("token"),
        data: data,
        option: true,
      );

      if (value.data["success"] == true) {
        //AddLocationModel = AddLocationModel.fromJson(value.data);

        emit(SyncAppsSendSuccess());
      } else {
        log(value.data["message"] ?? "error");
        emit(SyncAppsSendError("error"));
      }
    } catch (e) {
      log(e.toString());

      // emailBackendError = true;

      // 4) خطأ Exception

      emit(SyncAppsSendError("unknown"));
    }
  }
}
