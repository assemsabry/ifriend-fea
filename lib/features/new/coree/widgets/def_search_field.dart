import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';

class DefSearchField extends StatelessWidget {
  final String? initialValue;
  final String label;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool readOnly;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Function(String value)? onChanged;
  final Function(String?)? onSaved;
  final Function(String)? onFieldSubmitted;
  final Function(PointerDownEvent)? onTapOutside;
  final int? maxLength;
  final bool titleOnTop;
  final bool requiredStyle;
  final String? Function(String?)? validator;
  final CrossAxisAlignment? crossAxisAlignment;
  final void Function()? onTap;
  final int? maxLines;
  final bool? optional;
  final bool? obscureText;
  final String? errorText;
  final TextInputAction? textInputAction;
  final String? helperText;
  final EdgeInsetsGeometry? contentPadding;
  const DefSearchField({
    super.key,
    required this.label,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.readOnly = false,
    this.controller,
    this.keyboardType,
    this.onChanged,
    this.onFieldSubmitted,
    this.initialValue,
    this.maxLength,
    this.onSaved,
    this.onTapOutside,
    this.titleOnTop = false,
    this.requiredStyle = true,
    this.validator,
    this.crossAxisAlignment,
    this.onTap,
    this.optional,
    this.maxLines,
    this.obscureText,
    this.textInputAction,
    this.errorText,
    this.helperText,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      textInputAction: textInputAction ?? TextInputAction.next,
      initialValue: initialValue,
      style: const TextStyle(color: ColorsManager.primary),
      controller: controller,
      decoration: InputDecoration(
        helperStyle: const TextStyle(
          color: ColorsManager.neutral500,
          fontWeight: FontWeight.bold,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        helperText: helperText,
        filled: true,
        fillColor: ColorsManager.baseWhite,
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.020,
              horizontal: MediaQuery.of(context).size.height * 0.020,
            ),
        hintText: hintText ?? label,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: ColorsManager.neutral100),
        ),
        errorText: errorText,
        hintStyle: TextStyle(fontSize: 14.sp, color: ColorsManager.neutral500),
        labelStyle: TextStyle(fontSize: 14.sp, color: ColorsManager.neutral500),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            margin: EdgeInsets.only(right: 5.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: ColorsManager.neutral50,
            ),
            child: Icon(Iconsax.search_normal, size: 22.sp),
          ),
        ),
        prefixIcon: prefixIcon,
      ),
      onSaved: onSaved,
      onTapOutside: onTapOutside,
      maxLength: maxLength,
      maxLines: maxLines,
      readOnly: readOnly,
      keyboardType: keyboardType,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
    );
  }
}
