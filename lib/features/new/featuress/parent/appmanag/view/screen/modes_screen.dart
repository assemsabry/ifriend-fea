import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/routing/sizing.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';
import 'package:ifriend_app/core/widgets/def_appbar.dart';
import 'package:ifriend_app/features/new/featuress/parent/appmanag/controller/modes_cubit.dart';
import 'package:ifriend_app/features/new/featuress/parent/appmanag/view/widget/allmodes_widget.dart';

class ModesScreen extends StatelessWidget {
  const ModesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefAppbar(title: "Modes", backIcon: true),
      body: Container(
        padding: AppSizing.customPadding(),
        child: RefreshIndicator(
          onRefresh: () async {
            ModesCubit.get(context).getAllModes();
          },
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(height: 10.h),
              Padding(
                padding: AppSizing.customPadding(),
                child: CustomText(
                  title:
                      "Modes like Sleep, Study, or Family Time\n for better control.",
                  color: ColorsManager.neutral600,
                  textAlign: TextAlign.center,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 20.h),

              AllmodesWidget(),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: Container(
      //   height: 100.h,
      //   padding: AppSizing.customPadding(),
      //   child: Column(
      //     children: [DefButton(title: "Next", onPressed: () {})],
      //   ),
      // ),
    );
  }
}
