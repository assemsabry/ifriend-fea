import 'package:flutter/material.dart';
import 'package:ifriend_app/features/profile/presentation/widgets/menu_list.dart';
import 'package:ifriend_app/features/profile/presentation/widgets/profile_card.dart';
import 'package:ifriend_app/features/profile/presentation/widgets/upgrade_banner.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileCard(),
            const SizedBox(height: 16),
            const UpgradeBanner(),
            const SizedBox(height: 16),
            MenuList(),
          ],
        ),
      ),
    );
  }
}
