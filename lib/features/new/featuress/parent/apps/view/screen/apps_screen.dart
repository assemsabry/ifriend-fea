import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/routing/sizing.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/widgets/app_image.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';
import 'package:ifriend_app/features/new/coree/widgets/def_search_field.dart';
import 'package:ifriend_app/features/new/featuress/parent/appmanag/view/widget/apps_appbar.dart';
import 'package:ifriend_app/features/new/featuress/parent/apps/controller/apps_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppsScreen extends StatelessWidget {
  const AppsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppsAppbar(title: "Apps", backIcon: true),
      body: Container(
        padding: AppSizing.customPadding(),
        child: RefreshIndicator(
          onRefresh: () => AppsCubit.get(context).getAllApps(),
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            children: [
              SizedBox(height: 20.h),
              DefSearchField(label: "Search for apps"),
              SizedBox(height: 20.h),

              BlocBuilder<AppsCubit, AppsState>(
                builder: (context, state) {
                  if (state is AppsLoadingStates) {
                    return Skeletonizer(
                      child: ListView.builder(
                        itemCount: 15,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,

                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(bottom: 15.h),
                          child: ListTile(
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            tileColor: ColorsManager.baseWhite,
                            title: CustomText(title: "Among Us"),
                            subtitle: CustomText(
                              title: "Allow",
                              color: ColorsManager.primary,
                            ),
                            leading: AppImage(
                              path: "assets/images/games.png",
                              height: 40.h,
                              width: 40.w,
                            ),
                            trailing: Switch(
                              value: false, // الحالة الحالية
                              onChanged: (bool newValue) {},
                              activeThumbColor: ColorsManager.baseWhite,
                              thumbIcon: WidgetStateProperty.all(
                                Icon(
                                  Icons.check,
                                  color: ColorsManager.baseWhite,
                                ),
                              ),

                              inactiveTrackColor: ColorsManager.neutral100,
                              activeTrackColor: ColorsManager.primary,
                              inactiveThumbColor: Colors.white,

                              trackOutlineColor: WidgetStateProperty.all(
                                Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  if (state is AppsErrorStates) {
                    return Skeletonizer(
                      child: ListView.builder(
                        itemCount: 15,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,

                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(bottom: 15.h),
                          child: ListTile(
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            tileColor: ColorsManager.baseWhite,
                            title: CustomText(title: "Among Us"),
                            subtitle: CustomText(
                              title: "Allow",
                              color: ColorsManager.primary,
                            ),
                            leading: AppImage(
                              path: "assets/images/games.png",
                              height: 40.h,
                              width: 40.w,
                            ),
                            trailing: Switch(
                              value: false, // الحالة الحالية
                              onChanged: (bool newValue) {},
                              activeThumbColor: ColorsManager.baseWhite,
                              thumbIcon: WidgetStateProperty.all(
                                Icon(
                                  Icons.check,
                                  color: ColorsManager.baseWhite,
                                ),
                              ),

                              inactiveTrackColor: ColorsManager.neutral100,
                              activeTrackColor: ColorsManager.primary,
                              inactiveThumbColor: Colors.white,

                              trackOutlineColor: WidgetStateProperty.all(
                                Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  if (state is AppsSuccessStates) {
                    return ListView.builder(
                      itemCount: state.appsModel.data!.apps!.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final app = state.appsModel.data!.apps![index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 15.h),
                          child: ListTile(
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            tileColor: ColorsManager.baseWhite,
                            title: CustomText(title: app.appName!),
                            subtitle: CustomText(
                              title: app.isBlocked! ? "Blocked" : "Allowed",
                              color: app.isBlocked!
                                  ? ColorsManager.red
                                  : ColorsManager.primary,
                            ),
                            leading: Image.memory(
                              base64Decode(
                                app.iconUrl ??
                                    "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",
                              ),
                            ),
                            // AppImage(
                            //   path: app.iconUrl!.isNotEmpty?

                            //   "assets/images/games.png",
                            //   height: 40.h,
                            //   width: 40.w,
                            // ),
                            trailing: Switch(
                              value: app.isBlocked!, // الحالة الحالية
                              onChanged: (bool newValue) {
                                AppsCubit.get(context).switchApp(
                                  appId: app.id!,
                                  isBlocked: newValue,
                                );
                              },
                              activeThumbColor: ColorsManager.baseWhite,
                              thumbIcon: WidgetStateProperty.all(
                                Icon(
                                  Icons.check,
                                  color: ColorsManager.baseWhite,
                                ),
                              ),

                              inactiveTrackColor: ColorsManager.neutral100,
                              activeTrackColor: ColorsManager.primary,
                              inactiveThumbColor: Colors.white,

                              trackOutlineColor: WidgetStateProperty.all(
                                Colors.transparent,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Skeletonizer(
                      child: ListView.builder(
                        itemCount: 15,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,

                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(bottom: 15.h),
                          child: ListTile(
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            tileColor: ColorsManager.baseWhite,
                            title: CustomText(title: "Among Us"),
                            subtitle: CustomText(
                              title: "Allow",
                              color: ColorsManager.primary,
                            ),
                            leading: AppImage(
                              path: "assets/images/games.png",
                              height: 40.h,
                              width: 40.w,
                            ),
                            trailing: Switch(
                              value: false, // الحالة الحالية
                              onChanged: (bool newValue) {},
                              activeThumbColor: ColorsManager.baseWhite,
                              thumbIcon: WidgetStateProperty.all(
                                Icon(
                                  Icons.check,
                                  color: ColorsManager.baseWhite,
                                ),
                              ),

                              inactiveTrackColor: ColorsManager.neutral100,
                              activeTrackColor: ColorsManager.primary,
                              inactiveThumbColor: Colors.white,

                              trackOutlineColor: WidgetStateProperty.all(
                                Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
