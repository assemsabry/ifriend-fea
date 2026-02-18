import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/widgets/app_image.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';
import 'package:ifriend_app/core/widgets/def_button.dart';
import 'package:ifriend_app/core/widgets/def_form_field.dart';
import 'package:ifriend_app/features/new/featuress/parent/appmanag/controller/modes_cubit.dart';
import 'package:ifriend_app/features/new/featuress/parent/appmanag/model/modes_model.dart';
import 'package:ifriend_app/features/new/featuress/parent/appmanag/model/timepicker_type.dart';
import 'package:ifriend_app/features/new/featuress/parent/appmanag/view/widget/choosedays_selected.dart';
import 'package:ifriend_app/features/new/featuress/parent/home/model/appmode_model.dart';

class EditmodesScreen extends StatelessWidget {
  final AppMode appMode;
  final Modes modes;
  const EditmodesScreen({
    super.key,
    required this.modes,
    required this.appMode,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ModesCubit, ModesState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            AppImage(path: appMode.imagePath, height: 55.h, width: 55.w),
            CustomText(
              title: modes.type ?? "",
              fontSize: 26.sp,
              fontWeight: FontWeight.w500,
              color: ColorsManager.baseBlack,
            ),
            Row(
              spacing: 10.w,
              children: [
                Expanded(
                  child: DefFormField(
                    filled: true,
                    fillColor: ColorsManager.neutral50,
                    label: "From",
                    titleOnTop: true,
                    readOnly: true,
                    controller: TextEditingController(
                      text: ModesCubit.get(context).startTime?.format(context),
                    ),
                    richTextColor: ColorsManager.neutral500,
                    suffixIcon: AppImage(path: "assets/svg/aiicon.svg"),
                    onTap: () => ModesCubit.get(
                      context,
                    ).openTimePicker(context, TimePickType.start),
                  ),
                ),
                Expanded(
                  child: DefFormField(
                    filled: true,
                    fillColor: ColorsManager.neutral50,
                    label: "to",
                    titleOnTop: true,
                    readOnly: true,
                    controller: TextEditingController(
                      text: ModesCubit.get(context).endTime?.format(context),
                    ),
                    richTextColor: ColorsManager.neutral500,
                    suffixIcon: AppImage(path: "assets/svg/aiicon.svg"),
                    onTap: () => ModesCubit.get(
                      context,
                    ).openTimePicker(context, TimePickType.end),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: ColorsManager.neutral50,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    title: "Apply every day",
                    fontSize: 14.sp,
                    color: ColorsManager.baseBlack,
                    fontWeight: FontWeight.w500,
                  ),
                  Switch(
                    value: ModesCubit.get(context).isAllDay,
                    onChanged: (bool newValue) {
                      ModesCubit.get(context).setIsAllDay(newValue);
                    },
                    activeThumbColor: ColorsManager.baseWhite,
                    thumbIcon: WidgetStateProperty.all(
                      Icon(Icons.check, color: ColorsManager.baseWhite),
                    ),

                    inactiveTrackColor: ColorsManager.neutral100,
                    activeTrackColor: ColorsManager.primary,
                    inactiveThumbColor: Colors.white,

                    trackOutlineColor: WidgetStateProperty.all(
                      Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),
            if (!ModesCubit.get(context).isAllDay) ...[
              ChoosedaysSelectedWidget(
                selectedIndices: ModesCubit.get(context).selectedDays,
                onChange: (Set<int> value) {
                  ModesCubit.get(context).setSelectedDays(value);
                },
              ),
              SizedBox(height: 20.h),
            ],
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ColorsManager.neutral50,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    title: "All apps are blocked except Contacts",
                    fontSize: 14.sp,
                    color: ColorsManager.baseBlack,
                    fontWeight: FontWeight.w500,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(25),
                    child: AppImage(
                      path: "assets/images/call.jpg",
                      height: 30.h,
                      width: 30.w,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50.h),
            DefButton(
              title: "Save",
              onPressed: () {
                ModesCubit.get(context).updateMode(modeId: modes.id.toString());
              },
            ),
            SizedBox(height: 10.h),

            TextButton(
              onPressed: () {},
              child: CustomText(
                title: "Cancel",
                color: ColorsManager.primary,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        );
      },
    );
  }
}
