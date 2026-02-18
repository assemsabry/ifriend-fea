import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart'; // مكتبة flutter_map
import 'package:get/get.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/widgets/app_image.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';
import 'package:ifriend_app/features/new/featuress/parent/alllocation/controller/alllocation_cubit.dart';
import 'package:ifriend_app/features/new/featuress/parent/alllocation/view/screen/alllocationtrack_screen.dart';
import 'package:ifriend_app/features/new/featuress/parent/alllocation/view/screen/sos_history_screen.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart'; // للتعامل مع الإحداثيات
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class AllLocationsScreen extends StatelessWidget {
  const AllLocationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AllLocationCubit, AllLocationState>(
        buildWhen: (previous, current) =>
            current is AllMyChildLocationsSuccessStates,
        builder: (context, state) {
          if (state is AllMyChildLocationsLoadingStates) {
          } else if (state is AllMyChildLocationsErrorStates) {}
          if (state is AllMyChildLocationsSuccessStates) {
            if (state.allMyChildLocationsModel.data!.children!.isEmpty) {}

            final children =
                state.allMyChildLocationsModel.data?.children ?? [];

            // تحديد مركز الخريطة الافتراضي
            LatLng center = const LatLng(30.0444, 31.2357);
            if (children.isNotEmpty) {
              center = LatLng(
                children.first.currentLocation?.latitude!.toDouble() ?? 30.0444,
                children.first.currentLocation?.longitude!.toDouble() ??
                    31.2357,
              );
            }
            return Stack(
              children: [
                Positioned.fill(
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: center,
                      initialZoom: 14.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.ifriend.app',
                        // لتغيير لون الخريطة للرمادي مثل الصورة، يمكن استخدام ColorFiltered
                      ),
                      // الدوائر الزرقاء حول الأشخاص
                      CircleLayer(
                        circles: children.expand((child) {
                          final point = LatLng(
                            child.currentLocation?.latitude!.toDouble() ?? 0,
                            child.currentLocation?.longitude!.toDouble() ?? 0,
                          );

                          return [
                            // الدائرة الكبيرة (الأكثر شفافية)
                            CircleMarker(
                              point: point,
                              radius: 120.r, // القطر الأكبر
                              useRadiusInMeter: false,
                              color: ColorsManager.primary.withOpacity(0.05),
                              borderStrokeWidth: 0,
                            ),
                            // الدائرة المتوسطة
                            CircleMarker(
                              point: point,
                              radius: 36.r, // القطر المتوسط
                              useRadiusInMeter: false,
                              color: ColorsManager.primary.withOpacity(0.1),
                              borderStrokeWidth: 0,
                            ),
                          ];
                        }).toList(),
                      ),
                      // علامات الأشخاص (Markers)
                      MarkerLayer(
                        markers: children.map((child) {
                          return Marker(
                            point: LatLng(
                              child.currentLocation?.latitude!.toDouble() ?? 0,
                              child.currentLocation?.longitude!.toDouble() ?? 0,
                            ),
                            width: 60.w,
                            height: 60.h,
                            child: _buildChildMarker(
                              child.avatarUrl,
                              // loc?.isInSafeZone ?? true
                              //     ? Colors.green
                              //     : Colors.red,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                Positioned(
                  top: 50.h,
                  right: 20.w,
                  child: _buildTopActionButton(Iconsax.setting_2),
                ),

                DraggableScrollableSheet(
                  initialChildSize: 0.3,
                  minChildSize: 0.15,
                  maxChildSize: 0.3,
                  snap: true,
                  builder: (context, scrollController) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(15.w, 0, 15.w, 20.h),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                controller: scrollController,
                                padding: EdgeInsets.all(20.w),
                                itemCount: children.length + 1,
                                itemBuilder: (context, index) {
                                  if (index == 0) return _buildHeader();

                                  final child = children[index - 1];
                                  final loc = child.currentLocation;

                                  return _buildChildTile(
                                    name:
                                        "${child.firstName} ${child.lastName}",
                                    address: loc?.address ?? "",
                                    distance: "Lat: ${loc?.latitude}",
                                    time: _formatDate(loc?.lastUpdated),
                                    avatar: child.avatarUrl,
                                    color: Colors.transparent,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

String _formatDate(String? dateStr) {
  if (dateStr == null) return "غير معروف";
  try {
    DateTime dt = DateTime.parse(dateStr);
    return DateFormat('hh:mm a').format(dt);
  } catch (e) {
    return "منذ قليل";
  }
}

Widget _buildHeader() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomText(
        title: "All Child’s",
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: ColorsManager.baseBlack,
      ),

      Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: ColorsManager.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: InkWell(
          onTap: () {
            Get.to(() => SosHistoryScreen());
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                title: "SOS History",
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: ColorsManager.primary,
              ),
              SizedBox(width: 8.w),
              Icon(Iconsax.undo, size: 20.sp, color: ColorsManager.primary),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildChildMarker(String? imageUrl) {
  return Container(
    padding: EdgeInsets.all(5.w), // عرض الإطار الأزرق
    decoration: const BoxDecoration(
      color: ColorsManager.primary, // اللون الأزرق الصريح
      shape: BoxShape.circle,
    ),
    child: Container(
      padding: EdgeInsets.all(2.w), // إطار أبيض رقيق داخلي
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        backgroundImage: (imageUrl != null && imageUrl.isNotEmpty)
            ? NetworkImage(imageUrl)
            : null,
        child: (imageUrl == null || imageUrl.isEmpty)
            ? const Icon(Iconsax.user)
            : null,
      ),
    ),
  );
}

Widget _buildTopActionButton(IconData icon) {
  return Container(
    decoration: const BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
    ),
    child: IconButton(
      icon: Icon(icon, color: ColorsManager.primary),
      onPressed: () {
        AllLocationCubit.get(Get.context!).getAllSaveZone();
        AllLocationCubit.get(Get.context!).getAllMyChild();
        Get.to(() => AllLocationtrackScreen());
      },
    ),
  );
}

Widget _buildChildTile({
  required String name,
  required String address,
  required String distance,
  required String time,
  required String? avatar,
  required Color color,
}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 15.h),
    child: Row(
      children: [
        Container(
          width: 55.w,
          height: 55.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color.withOpacity(0.5), width: 2),
          ),
          child: CircleAvatar(
            backgroundColor: color.withOpacity(0.1),
            backgroundImage: (avatar != null && avatar.isNotEmpty)
                ? NetworkImage(avatar)
                : null,
            child: (avatar == null || avatar.isEmpty)
                ? Icon(Iconsax.user, color: color)
                : null,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    title: name,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorsManager.neutral700,
                  ),
                  CustomText(
                    title: time,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,

                    color: ColorsManager.neutral400,
                  ),
                ],
              ),
              SizedBox(height: 4.h),

              Row(
                spacing: 5.w,
                children: [
                  Icon(
                    Iconsax.gps,
                    size: 20.sp,
                    color: ColorsManager.neutral500,
                  ),
                  Flexible(
                    child: CustomText(
                      title: address,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 12.sp,
                      color: ColorsManager.neutral500,
                    ),
                  ),
                  CustomText(
                    title: distance,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorsManager.primary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildCcchildTile(
  String name,
  String address,
  String distance,
  String time,
  Color color,
) {
  return Padding(
    padding: EdgeInsets.only(bottom: 20.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 50.w,
          height: 50.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.2),
          ),
          child: AppImage(path: "assets/images/avatar1.png"),
        ),
        SizedBox(width: 12.w),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    title: name,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorsManager.neutral700,
                  ),
                  CustomText(
                    title: time,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,

                    color: ColorsManager.neutral400,
                  ),
                ],
              ),
              SizedBox(height: 4.h),

              Row(
                spacing: 5.w,
                children: [
                  Icon(
                    Iconsax.gps,
                    size: 20.sp,
                    color: ColorsManager.neutral500,
                  ),
                  Flexible(
                    child: CustomText(
                      title: address,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 12.sp,
                      color: ColorsManager.neutral500,
                    ),
                  ),
                  CustomText(
                    title: distance,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorsManager.primary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
