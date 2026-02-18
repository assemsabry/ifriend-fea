import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';
import 'package:ifriend_app/features/new/featuress/parent/alllocation/controller/alllocation_cubit.dart';
import 'package:ifriend_app/features/new/featuress/parent/alllocation/controller/editlocation_cubit.dart';
import 'package:ifriend_app/features/new/featuress/parent/alllocation/model/allsavezone_model.dart';
import 'package:ifriend_app/features/new/featuress/parent/location/view/screen/editlocation_screen.dart';

class LocationCard extends StatelessWidget {
  final SafeZones? safeZones;
  const LocationCard({super.key, this.safeZones});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 100.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorsManager.baseWhite,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ListTile(
        title: CustomText(
          title: safeZones?.name ?? "Home",
          fontSize: 17.sp,
          fontWeight: FontWeight.bold,
        ),
        subtitle: BlocBuilder<AllLocationCubit, AllLocationState>(
          builder: (context, state) {
            return CustomText(
              title: safeZones?.address ?? "unknown",
              color: ColorsManager.neutral300,
            );
          },
        ),
        leading: Icon(
          Iconsax.location,
          size: 35.sp,
          color: ColorsManager.primary,
        ),
        trailing: InkWell(
          onTap: () {
            EditLocationCubit.get(context).oninitial(safeZones: safeZones!);
            Get.to(() => EditlocationScreen());
          },
          child: Icon(
            Iconsax.edit,
            size: 25.sp,
            color: ColorsManager.neutral400,
          ),
        ),
      ),
    );
  }
}
