import 'package:flutter/material.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/theme/styles_manager.dart';
import 'package:ifriend_app/core/widgets/custom_asset_image_widget.dart';

class OptionalTile extends StatelessWidget {
  final void Function()? onTap;
  final String icon;
  final String label;
  final Color color;
  final bool isLogout;
  const OptionalTile({
    super.key,
    required this.onTap,
    required this.icon,
    required this.label,
    required this.color,
    required this.isLogout,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
                  color: isLogout ? Color(0xffFFECEC) : ColorsManager.primary50,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CustomAssetImageWidget(
                    icon,
                    color: color,
                    height: 24,
                    width: 24,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: TextStyles.font14Grey500Weight.copyWith(
                    color: isLogout ? Colors.red : Colors.black,
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
