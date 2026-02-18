import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';
import 'package:ifriend_app/core/widgets/def_button.dart';

class SosCard extends StatelessWidget {
  const SosCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ColorsManager.borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        spacing: 10.h,
        crossAxisAlignment: .start,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 90,
                    height: 60,
                    child: Stack(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(
                            'assets/images/games.png',
                          ),
                        ),
                        Positioned(
                          left: 20.w,
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 5),
                              color: Color(0xFFFFEBEE),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.warning_amber_rounded,
                              color: Color(0xFFE53935),
                              size: 35,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomText(
                    title: "SOS",
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorsManager.red,
                  ),
                ],
              ),

              CustomText(
                title: "07:24 PM - Today",
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: ColorsManager.neutral500,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Row(
                spacing: 3.w,
                children: [
                  Icon(
                    Iconsax.location5,
                    size: 25,
                    color: ColorsManager.neutral600,
                  ),
                  CustomText(
                    title: "Mohandessin – Nile St.",
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorsManager.neutral600,
                  ),
                ],
              ),
              DefButton(
                minWidth: 0,
                borderRadius: 50,
                height: 40.h,
                title: "",

                widget: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 3.w,
                  children: [
                    Icon(Iconsax.gps, size: 25, color: ColorsManager.baseWhite),
                    CustomText(
                      title: "View on map",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorsManager.baseWhite,
                    ),
                  ],
                ),

                onPressed: () {},
              ),
            ],
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: ColorsManager.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              spacing: 5.w,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Iconsax.eye4, size: 20, color: ColorsManager.green),
                CustomText(
                  title: "Seen",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorsManager.green,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
