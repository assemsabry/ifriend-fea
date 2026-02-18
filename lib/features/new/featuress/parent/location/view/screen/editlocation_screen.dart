import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ifriend_app/core/routing/sizing.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';
import 'package:ifriend_app/core/widgets/def_appbar.dart';
import 'package:ifriend_app/core/widgets/def_button.dart';
import 'package:ifriend_app/core/widgets/def_form_field.dart';
import 'package:ifriend_app/features/new/featuress/parent/alllocation/controller/editlocation_cubit.dart';
import 'package:latlong2/latlong.dart';

class EditlocationScreen extends StatelessWidget {
  const EditlocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditLocationCubit, EditLocationState>(
      builder: (context, state) {
        var cubit = EditLocationCubit.get(context);
        return Scaffold(
          appBar: DefAppbar(title: "Edit Location", backIcon: true),
          body: Form(
            key: cubit.formKey,
            child: Container(
              padding: AppSizing.customPadding(),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(height: 30.h),
                  DefFormField(
                    label: "Location Name",
                    titleOnTop: true,
                    hintText: "Home, School, Club, e.g.",
                    controller: cubit.locationNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter location name";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.h),
                  DefFormField(
                    label: "Safe zone",
                    titleOnTop: true,
                    hintText: "Enter zone length ",
                    controller: cubit.locationSaveZoneController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter safe zone";
                      }
                      return null;
                    },
                    suffixIcon: Row(
                      mainAxisSize: .min,
                      children: [
                        CustomText(title: "(M)", color: ColorsManager.primary),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  buildMapSection(context, cubit),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            height: 100.h,
            padding: AppSizing.customPadding(),
            child: Column(
              children: [
                Row(
                  spacing: 6.w,
                  children: [
                    Expanded(
                      child: DefButton(
                        title: "Delete",
                        textcolor: ColorsManager.red,
                        buttoncolor: ColorsManager.red.withOpacity(0.1),
                        onPressed: () {
                          if (cubit.formKey.currentState!.validate()) {
                            cubit.deleteLocation();
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: DefButton(
                        title: "Save",
                        onPressed: () {
                          if (cubit.formKey.currentState!.validate()) {
                            cubit.editLocation();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildMapSection(BuildContext context, EditLocationCubit cubit) {
    final LatLng defaultPoint = LatLng(30.0444, 31.2357);

    LatLng point = cubit.currentPosition ?? defaultPoint;

    return Container(
      height: 400.h,
      decoration: BoxDecoration(
        border: Border.all(color: ColorsManager.borderColor),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                initialCenter: point,
                initialZoom: 13.0,
                onTap: (tapPos, latLng) {
                  cubit.updateLocation(latLng); // تحديث عند الضغط على الخريطة
                },
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c', 'd'],
                ),
                CircleLayer(
                  circles: [
                    CircleMarker(
                      point: point,
                      color: ColorsManager.primary.withOpacity(0.1),
                      borderStrokeWidth: 2,
                      borderColor: ColorsManager.primary.withOpacity(0.5),
                      useRadiusInMeter: true,
                      radius: double.parse(
                        cubit.locationSaveZoneController.text,
                      ),
                      //Get.width * 4,
                    ),
                  ],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: point,
                      width: 40,
                      height: 40,
                      child: Icon(
                        Iconsax.location5,
                        color: ColorsManager.primary,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // شريط البحث
            Positioned(
              top: 15.h,
              left: 15.w,
              right: 15.w,
              child: DefFormField(
                borderSide: ColorsManager.primary.withOpacity(0.3),
                label: "Find your location",
                filled: true,
                fillColor: Colors.white,
                controller: cubit.locationSearchController,
                onChanged: (value) {
                  cubit.searchLocation(value);
                },
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(
                    right: 4.0,
                    left: 4,
                    top: 3,
                    bottom: 3,
                  ),
                  child: InkWell(
                    onTap: () {
                      cubit.searchLocation(cubit.locationSearchController.text);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: ColorsManager.primary.withOpacity(0.2),
                      ),
                      child: Icon(
                        Iconsax.search_normal,
                        size: 20,
                        color: ColorsManager.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
