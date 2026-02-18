import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifriend_app/core/constants/imges.dart';
import 'package:ifriend_app/core/helpers/extensions.dart';
import 'package:ifriend_app/core/routing/routes.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/widgets/custom_asset_image_widget.dart';

import 'cubit/home_layout_cubit.dart';
import 'package:ifriend_app/features/old/profile/presentation/manager/profile_cubit.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  void initState() {
    super.initState();
    // Fetch profile on home layout open
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        context.read<ProfileCubit>().getParentProfile();
      } catch (_) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeLayoutCubit>(context);

    // Define the items here to avoid duplicating code in the UI below
    final items = [
      {"icon": Images.homeIcon, "label": "Home"},
      {"icon": Images.pinIcon, "label": "Location"},
      {"icon": Images.messageIcon, "label": "Message"},
      {"icon": Images.profileIcon, "label": "Profile"},
    ];

    return BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text(cubit.title[cubit.currentIndex]),
            leading: SizedBox(),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: () => context.pushNamed(Routes.notificationsScreen),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorsManager.baseWhite,
                      border: Border.all(color: ColorsManager.neutral100),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: CustomAssetImageWidget(
                        Images.notificationIcon,
                        height: 14,
                        width: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          body: state.getWidget(),

          // Custom bottom navigation bar: icon above label (always shows labels, unselected grey)
          bottomNavigationBar: Container(
            height: 72,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, -1),
                ),
              ],
            ),
            child: Row(
              children: List.generate(items.length, (i) {
                final isSelected = cubit.currentIndex == i;
                final color = isSelected ? ColorsManager.primary : Colors.grey;

                return Expanded(
                  child: InkWell(
                    onTap: () => cubit.changeScreen(i),
                    borderRadius: BorderRadius.circular(12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomAssetImageWidget(
                          items[i]["icon"]!,
                          width: 24,
                          height: 24,
                          color: color,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          items[i]["label"]!,
                          style: TextStyle(
                            fontSize: 12,
                            color: color,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
