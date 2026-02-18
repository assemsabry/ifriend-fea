
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/features/new/featuress/parent/home/controller/parenthome_cubit.dart';

class ParenthomePage extends StatelessWidget {
  const ParenthomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ParentHomeCubit()..getHomeParent(childId: ""),
      child: BlocConsumer<ParentHomeCubit, ParentHomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          ParentHomeCubit cubit = ParentHomeCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            body: PopScope(
              canPop: false,
              onPopInvoked: (bool bool) {
                //  onWillPop();
              },
              child: cubit.listPage[cubit.currentPage],
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(100),
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                selectedLabelStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorsManager.primary,
                ),
                unselectedLabelStyle: TextStyle(
                  color: ColorsManager.neutral700,
                ),
                showSelectedLabels: true,
                showUnselectedLabels: true,
                currentIndex: cubit.currentPage,
                onTap: (value) {
                  cubit.changePage(value);
                },
                elevation: 10,
                selectedItemColor: ColorsManager.primary,
                unselectedItemColor: ColorsManager.neutral700,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      cubit.currentPage == 0 ? Iconsax.home_15 : Iconsax.home,
                    ),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      cubit.currentPage == 1
                          ? Iconsax.location5
                          : Iconsax.location,
                    ),
                    label: "Location",
                  ),

                  BottomNavigationBarItem(
                    icon: Icon(
                      cubit.currentPage == 2
                          ? Iconsax.messages_25
                          : Iconsax.messages_2,
                    ),
                    label: "Message",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      cubit.currentPage == 3
                          ? IconsaxPlusBold.profile
                          : IconsaxPlusLinear.profile,
                    ),
                    label: "Profile",
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
