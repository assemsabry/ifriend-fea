import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:ifriend_app/core/helpers/auth_local_datasource.dart';
import 'package:ifriend_app/core/networking/auth_interceptor.dart';
import 'package:ifriend_app/core/networking/dio_factory.dart';
import 'package:ifriend_app/features/child_profile/presentation/bloc/child_profile_bloc.dart';
import 'package:ifriend_app/features/login/data/datasources/login_api_service.dart';
import 'package:ifriend_app/features/login/data/repositories/login_repository_impl.dart';
import 'package:ifriend_app/features/login/domain/repositories/login_repository.dart';
import 'package:ifriend_app/features/login/domain/usecases/login_with_facebook.dart';
import 'package:ifriend_app/features/login/domain/usecases/login_with_google.dart';
import 'package:ifriend_app/features/device_management/data/datasources/device_management_remote_datasource.dart';
import 'package:ifriend_app/features/device_management/data/repositories/device_management_repository_impl.dart';
import 'package:ifriend_app/features/device_management/domain/repositories/device_management_repository.dart';
import 'package:ifriend_app/features/device_management/domain/usecases/get_linked_devices_usecase.dart';
import 'package:ifriend_app/features/device_management/domain/usecases/remove_device_usecase.dart';
import 'package:ifriend_app/features/device_management/presentation/bloc/device_management_bloc.dart';
import 'package:ifriend_app/features/onboarding/data/datasoucres/onboarding_local_datasource.dart';
import 'package:ifriend_app/features/onboarding/data/domain/repo/onboarding_repo.dart';
import 'package:ifriend_app/features/onboarding/data/repo/onboarding_repo_impl.dart';
import 'package:ifriend_app/features/permissions/data/services/permission_service.dart';
import 'package:ifriend_app/features/permissions/presentation/bloc/permission_bloc.dart';
import 'package:ifriend_app/features/device_link/data/datasources/link_api_service.dart';
import 'package:ifriend_app/features/device_link/data/repositories/link_repository_impl.dart';
import 'package:ifriend_app/features/device_link/domain/repositories/device_repository.dart';
import 'package:ifriend_app/features/device_link/domain/usecases/generate_child_qr_use_case.dart';
import 'package:ifriend_app/features/device_link/presentation/bloc/device_link_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ifriend_app/features/notifications/data/sources/notification_api_service.dart';
import 'package:ifriend_app/features/notifications/data/repos/notification_repository_impl.dart';
import 'package:ifriend_app/features/notifications/domain/repos/notification_repository.dart';
import 'package:ifriend_app/features/notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:ifriend_app/features/notifications/domain/usecases/mark_notification_read_usecase.dart';
import 'package:ifriend_app/features/notifications/domain/usecases/mark_all_notifications_read_usecase.dart';
import 'package:ifriend_app/features/notifications/presentation/bloc/notification_bloc.dart';

import 'package:ifriend_app/features/complete_profile/data/dataSource/complete_profile_data_remote.dart';
import 'package:ifriend_app/features/complete_profile/data/repo/complete_profile_repo_impl.dart';
import 'package:ifriend_app/features/complete_profile/domain/repo/complete_profile_repo.dart';
import 'package:ifriend_app/features/complete_profile/domain/useCases/complete_profile_use_cases.dart';
import 'package:ifriend_app/features/home_layout/presentation/cubit/home_layout_cubit.dart';

import '../../features/complete_profile/presentation/manager/complete_profile_cubit.dart';
import 'package:ifriend_app/features/device_linking_scan_qr/data/datasources/scan_qr_data_remote.dart';
import 'package:ifriend_app/features/device_linking_scan_qr/data/repositories/scan_qr_repo_impl.dart';
import 'package:ifriend_app/features/device_linking_scan_qr/domain/repository/scan_qr_repo.dart';
import 'package:ifriend_app/features/device_linking_scan_qr/domain/usecases/scan_qr_usecase.dart';
import 'package:ifriend_app/features/device_linking_scan_qr/domain/usecases/confirm_link_usecase.dart';
import 'package:ifriend_app/features/device_linking_scan_qr/presentation/cubit/scan_qr_cubit.dart';
import 'package:ifriend_app/features/onboarding/presentation/cubit/onboarding_cubit.dart';

import '../../features/login/domain/usecases/register_device.dart';
import '../../features/onboarding/data/domain/usecases/get_onboarding_seen.dart';
import '../../features/onboarding/data/domain/usecases/set_onboarding_seen.dart';
import 'package:ifriend_app/features/profile/datasource/data/data_profile_remote.dart';
import 'package:ifriend_app/features/profile/datasource/repo/profile_repo_impl.dart';
import 'package:ifriend_app/features/profile/domain/repo/profile_repo.dart';
import 'package:ifriend_app/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:ifriend_app/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:ifriend_app/features/profile/presentation/manager/profile_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(prefs);

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(sl()),
  );

  sl.registerLazySingleton<Dio>(() => DioFactory.create(sl()));

  sl.registerLazySingleton<OnboardingLocalDatasource>(
    () => OnboardingLocalDatasourceImpl(sl()),
  );

  sl.registerLazySingleton<OnboardingRepo>(() => OnboardingRepoImpl(sl()));

  // Onboarding use cases & cubit
  sl.registerLazySingleton<GetOnboardingSeen>(() => GetOnboardingSeen(sl()));
  sl.registerLazySingleton<SetOnboardingSeen>(() => SetOnboardingSeen(sl()));
  sl.registerFactory<OnboardingCubit>(() => OnboardingCubit(
        getOnboardingSeen: sl(),
        setOnboardingSeen: sl(),
      ));

  sl.registerLazySingleton<LoginApiService>(() => LoginApiService(sl()));

  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(sl()));

  sl.registerLazySingleton<LoginWithGoogleUseCase>(
    () => LoginWithGoogleUseCase(sl()),
  );

  sl.registerLazySingleton<LoginWithFacebookUseCase>(
    () => LoginWithFacebookUseCase(sl()),
  );

  sl.registerLazySingleton<RegisterDeviceUseCase>(
    () => RegisterDeviceUseCase(sl()),
  );

  // Complete Profile feature DI
  sl.registerLazySingleton<CompleteProfileRemoteDataSource>(
    () => CompleteProfileRemoteDataSource(),
  );
  sl.registerLazySingleton<CompleteProfileRepository>(
    () => CompleteProfileRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<CreateParentProfileUseCase>(
    () => CreateParentProfileUseCase(sl()),
  );
  sl.registerLazySingleton<CompleteProfileCubit>(
    () => CompleteProfileCubit(createUseCase: sl()),
  );

  // Profile feature DI
  sl.registerLazySingleton<ProfileRemoteDataSource>(() => ProfileRemoteDataSource());
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(sl()));
  sl.registerLazySingleton<GetProfileUseCase>(() => GetProfileUseCase(sl()));
  sl.registerLazySingleton<UpdateProfileUseCase>(() => UpdateProfileUseCase(sl()));
  sl.registerFactory<ProfileCubit>(() => ProfileCubit(getProfileUseCase: sl(), updateProfileUseCase: sl()));

  // Device linking (scan QR) feature DI
  sl.registerLazySingleton<ScanQrRemoteDataSource>(() => ScanQrRemoteDataSource(dio: sl()));

  sl.registerLazySingleton<ScanQrRepository>(() => ScanQrRepositoryImpl(remote: sl()));

  sl.registerLazySingleton<ScanQrUseCase>(() => ScanQrUseCase(sl()));

  // Confirm link use case
  sl.registerLazySingleton<ConfirmLinkUseCase>(() => ConfirmLinkUseCase(sl()));

  sl.registerFactory<ScanQrCubit>(() => ScanQrCubit(usecase: sl()));
  // Child Profile dependencies
  sl.registerFactory<ChildProfileBloc>(
    () => ChildProfileBloc(),
  );

  // Permission dependencies
  sl.registerLazySingleton<PermissionService>(
    () => PermissionService(),
  );

  sl.registerFactory<PermissionBloc>(
    () => PermissionBloc(sl()),
  );

  // Device Link dependencies
  sl.registerLazySingleton<LinkApiService>(() => LinkApiService(sl()));
  sl.registerLazySingleton<DeviceRepository>(() => LinkRepositoryImpl(sl()));
  sl.registerLazySingleton<GenerateChildQrUseCase>(
    () => GenerateChildQrUseCase(sl()),
  );
  sl.registerFactory<DeviceLinkBloc>(
    () => DeviceLinkBloc(sl()),
  );

  // Notifications dependencies
  sl.registerLazySingleton<NotificationApiService>(() => NotificationApiService(sl()));
  sl.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<GetNotificationsUseCase>(
    () => GetNotificationsUseCase(sl()),
  );
  sl.registerLazySingleton<MarkNotificationReadUseCase>(
    () => MarkNotificationReadUseCase(sl()),
  );
  sl.registerLazySingleton<MarkAllNotificationsReadUseCase>(
    () => MarkAllNotificationsReadUseCase(sl()),
  );
  sl.registerFactory<NotificationBloc>(
    () => NotificationBloc(
      getNotificationsUseCase: sl(),
      markNotificationReadUseCase: sl(),
      markAllNotificationsReadUseCase: sl(),
    ),
  );

  // Device Management dependencies
  sl.registerLazySingleton<DeviceManagementRemoteDataSource>(
    () => DeviceManagementRemoteDataSource(dio: sl()),
  );
  sl.registerLazySingleton<DeviceManagementRepository>(
    () => DeviceManagementRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<GetLinkedDevicesUseCase>(
    () => GetLinkedDevicesUseCase(sl()),
  );
  sl.registerLazySingleton<RemoveDeviceUseCase>(
    () => RemoveDeviceUseCase(sl()),
  );
  sl.registerFactory<DeviceManagementBloc>(
    () => DeviceManagementBloc(
      getLinkedDevicesUseCase: sl(),
      removeDeviceUseCase: sl(),
    ),
  );

  // Home Layout
  sl.registerFactory<HomeLayoutCubit>(() => HomeLayoutCubit());
}
