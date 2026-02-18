import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ifriend_app/core/constants/imges.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/widgets/def_button.dart';
import 'package:ifriend_app/features/new/config/themes/sizing.dart';
import 'package:ifriend_app/features/new/coree/constants/def_appbar.dart';
import 'package:ifriend_app/features/new/coree/local/hive_helper.dart';
import 'package:ifriend_app/features/new/featuress/auth/login/view/screen/login_screen.dart';
import 'package:ifriend_app/features/new/featuress/parent/profile/view/widget/menu_list.dart';
import 'package:ifriend_app/features/new/featuress/parent/profile/view/widget/optional_tile.dart';
import 'package:ifriend_app/features/new/featuress/parent/profile/view/widget/profile_card.dart';
import 'package:ifriend_app/features/new/featuress/parent/profile/view/widget/upgrade_banner.dart';

class ParentProfileScreen extends StatelessWidget {
  const ParentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefAppbar(title: "My Profile", centerTitle: true),
      body: Container(
        padding: AppSizing.customPadding(),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            const ProfileCard(),
            const SizedBox(height: 16),
            const UpgradeBanner(),
            const SizedBox(height: 16),
            OptionalTile(
              icon: Images.deviceIcon,
              label: "Child's Devices",
              color: ColorsManager.primary,
              onTap: () {},
              isLogout: false,
            ),
            OptionalTile(
              icon: Images.premiumIcon,
              label: 'Premium',
              color: ColorsManager.primary,
              onTap: () {},
              isLogout: false,
            ),
            OptionalTile(
              icon: Images.referIcon,
              label: 'Refer and earn',
              color: ColorsManager.primary,
              onTap: () {},
              isLogout: false,
            ),
            OptionalTile(
              icon: Images.privacyIcon,
              label: 'Privacy',
              color: ColorsManager.primary,
              onTap: () {},
              isLogout: false,
            ),
            OptionalTile(
              icon: Images.aboutIcon,
              label: 'About app',
              color: ColorsManager.primary,
              onTap: () {},
              isLogout: false,
            ),
            OptionalTile(
              icon: Images.feedbackIcon,
              label: 'Feedback & Contact us',
              color: ColorsManager.primary,
              onTap: () {},
              isLogout: false,
            ),
            OptionalTile(
              icon: Images.logoutIcon,
              label: 'Logout',
              color: Colors.red,
              isLogout: true,
              onTap: () {
                Get.offAll(() => LoginScreen());
              },
            ),

            // MenuList(),
          ],
        ),
      ),
    );
  }
}
