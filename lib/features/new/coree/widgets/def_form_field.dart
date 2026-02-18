import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/widgets/defrich_text.dart';

class DefFormField extends StatelessWidget {
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
  final bool? filled;
  final Color? fillColor;
  final Color? richTextColor;
  final Color? borderSide;

  const DefFormField({
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
    this.filled,
    this.fillColor,
    this.richTextColor,
    this.borderSide,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      children: [
        if (titleOnTop)
          DefrichText(
            title: label,
            textColor: richTextColor,
            optional: optional ?? false,
          ),
        if (titleOnTop) SizedBox(height: 7.0.h),
        TextFormField(
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
            filled: filled ?? false,

            fillColor: fillColor ?? Colors.transparent,
            contentPadding:
                contentPadding ??
                EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.021,
                  horizontal: MediaQuery.of(context).size.height * 0.021,
                ),
            hintText: hintText ?? label,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(
                color: borderSide ?? ColorsManager.borderColor,
              ),
            ),
            errorText: errorText,
            hintStyle: TextStyle(
              fontSize: 14.sp,
              color: ColorsManager.neutral500,
            ),
            labelStyle: TextStyle(
              fontSize: 14.sp,
              color: ColorsManager.neutral500,
            ),
            suffixIcon: suffixIcon,
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
        ),
      ],
    );
  }
}
