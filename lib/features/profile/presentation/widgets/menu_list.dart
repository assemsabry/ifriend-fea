import 'package:flutter/material.dart';
import 'package:ifriend_app/core/constants/imges.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/widgets/custom_asset_image_widget.dart';
import 'package:ifriend_app/core/helpers/auth_local_datasource.dart';
import 'package:ifriend_app/core/routing/routes.dart';
import 'package:ifriend_app/core/di/injection.dart' as di;

import '../../../../core/theme/styles_manager.dart';

class MenuList extends StatelessWidget {
  MenuList({super.key});

  final List<MenuItem> menuItems = [
    MenuItem(
      icon: Images.deviceIcon,
      label: "Child's Devices",
      color: ColorsManager.primary,
    ),
    MenuItem(
      icon: Images.premiumIcon,
      label: 'Premium',
      color: ColorsManager.primary,
    ),
    MenuItem(
      icon: Images.referIcon,
      label: 'Refer and earn',
      color: ColorsManager.primary,
    ),
    MenuItem(
      icon: Images.privacyIcon,
      label: 'Privacy',
      color: ColorsManager.primary,
    ),
    MenuItem(
      icon: Images.aboutIcon,
      label: 'About app',
      color: ColorsManager.primary,
    ),
    MenuItem(
      icon: Images.feedbackIcon,
      label: 'Feedback & Contact us',
      color: ColorsManager.primary,
    ),
    MenuItem(
      icon: Images.logoutIcon,
      label: 'Logout',
      color: Colors.red,
      isLogout: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        menuItems.length,
        (index) => Column(
          children: [
            _MenuTile(item: menuItems[index]),
            if (index < menuItems.length - 1)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(height: 1, color: Colors.grey[200]),
              ),
          ],
        ),
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final MenuItem item;

  const _MenuTile({required this.item});

  void _handleTap(BuildContext context) {
    if (item.isLogout) {
      // Show logout confirmation dialog
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(ctx).pop(); // Close dialog

                // Show loading indicator
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                );

                // Clear auth data
                try {
                  final authDataSource = di.sl<AuthLocalDataSource>();
                  await authDataSource.clear();

                  if (context.mounted) {
                    Navigator.of(context).pop(); // Close loading

                    // Navigate to login and clear stack
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.loginScreen,
                      (route) => false,
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    Navigator.of(context).pop(); // Close loading
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Logout failed: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              child: const Text('Logout', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );
      return;
    }

    // Handle navigation based on menu item
    switch (item.label) {
      case "Child's Devices":
        Navigator.of(context).pushNamed('/childsDevices');
        break;
      case 'Premium':
        // TODO: Navigate to premium screen
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Premium feature coming soon')),
        );
        break;
      case 'Refer and earn':
        // TODO: Navigate to referral screen
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Referral feature coming soon')),
        );
        break;
      case 'Privacy':
        // TODO: Navigate to privacy policy
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Privacy policy coming soon')),
        );
        break;
      case 'About app':
        // TODO: Navigate to about screen
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('About screen coming soon')),
        );
        break;
      case 'Feedback & Contact us':
        // TODO: Navigate to feedback screen
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Feedback feature coming soon')),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _handleTap(context),
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: item.isLogout
                      ? Color(0xffFFECEC)
                      : ColorsManager.primary50,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CustomAssetImageWidget(
                    item.icon,
                    color: item.color,
                    height: 24,
                    width: 24,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  item.label,
                  style: TextStyles.font14Grey500Weight.copyWith(
                    color: item.isLogout ? Colors.red : Colors.black,
                  ),
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey[400], size: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItem {
  final String icon;
  final String label;
  final Color color;
  final bool isLogout;

  MenuItem({
    required this.icon,
    required this.label,
    required this.color,
    this.isLogout = false,
  });
}
