import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/widgets/app_image.dart';
import 'package:ifriend_app/features/new/featuress/parent/home/controller/parenthome_cubit.dart';
import 'package:latlong2/latlong.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CurrentlocationWidget extends StatelessWidget {
  const CurrentlocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final LatLng defaultPoint = LatLng(30.0444, 31.2357);

    // LatLng point = AddLocationCubit.get(context).currentPosition ?? defaultPoint;

    return BlocBuilder<ParentHomeCubit, ParentHomeState>(
      builder: (context, state) {
        return Skeletonizer(
          enabled: state is ParentHomeLoadingState,
          child: Container(
            height: 150.h,
            decoration: BoxDecoration(
              // border: Border.all(color: ColorsManager.borderColor),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(
                    ParentHomeCubit.get(context)
                            .homeParentModel
                            ?.data
                            ?.location
                            ?.latitude
                            ?.toDouble() ??
                        30.0444,
                    ParentHomeCubit.get(context)
                            .homeParentModel
                            ?.data
                            ?.location
                            ?.longitude
                            ?.toDouble() ??
                        31.2357,
                  ),
                  initialZoom: 10.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.ifriend.app',
                  ),
                  CircleLayer(
                    circles: [
                      CircleMarker(
                        point: LatLng(
                          ParentHomeCubit.get(context)
                                  .homeParentModel
                                  ?.data
                                  ?.location
                                  ?.latitude
                                  ?.toDouble() ??
                              30.0444,
                          ParentHomeCubit.get(context)
                                  .homeParentModel
                                  ?.data
                                  ?.location
                                  ?.longitude
                                  ?.toDouble() ??
                              31.2357,
                        ),
                        radius: 70.r, // القطر الأكبر
                        useRadiusInMeter: false,
                        color: ColorsManager.primary.withOpacity(0.05),
                        borderStrokeWidth: 0,
                      ),
                      // الدائرة المتوسطة
                      CircleMarker(
                        point: LatLng(
                          ParentHomeCubit.get(context)
                                  .homeParentModel
                                  ?.data
                                  ?.location
                                  ?.latitude
                                  ?.toDouble() ??
                              30.0444,
                          ParentHomeCubit.get(context)
                                  .homeParentModel
                                  ?.data
                                  ?.location
                                  ?.longitude
                                  ?.toDouble() ??
                              31.2357,
                        ),
                        radius: 40.r, // القطر المتوسط
                        useRadiusInMeter: false,
                        color: ColorsManager.primary.withOpacity(0.05),
                        borderColor: ColorsManager.primary.withOpacity(0.5),

                        borderStrokeWidth: 0,
                      ),
                    ],
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(
                          ParentHomeCubit.get(context)
                                  .homeParentModel
                                  ?.data
                                  ?.location
                                  ?.latitude
                                  ?.toDouble() ??
                              30.0444,
                          ParentHomeCubit.get(context)
                                  .homeParentModel
                                  ?.data
                                  ?.location
                                  ?.longitude
                                  ?.toDouble() ??
                              31.2357,
                        ),
                        width: 60.w,
                        height: 60.h,
                        child: CircleAvatar(
                          radius: 22.r,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: ColorsManager.primary,
                                width: 5.w,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: AppImage(
                                path:
                                    ParentHomeCubit.get(
                                      context,
                                    ).homeParentModel?.data?.child?.avatarUrl ??
                                    "assets/images/avatar1.png",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
