import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/theme/styles_manager.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.suffix,
    this.prefixText,
    this.suffixText,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.obscureText = false,
    this.enableToggleObscure = true,
    this.showClearButton = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.readOnly = false,
    this.enabled = true,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.autofillHints,
    this.cursorColor,
    this.textStyle,
    this.hintStyle,
    this.fillColor,
    this.filled = false,
    this.borderRadius = 12.0,
    this.contentPadding,
    this.focusBorderColor,
    this.enabledBorderColor,
    this.errorBorderColor,
    this.title,
  });

  final TextEditingController? controller;
  final String? initialValue;
  final FocusNode? focusNode;
  final String? label;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? prefix;
  final Widget? suffix;
  final String? prefixText;
  final String? suffixText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final bool obscureText;
  final bool enableToggleObscure; // show eye toggle when obscureText true
  final bool showClearButton;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool readOnly;
  final bool enabled;
  final FormFieldValidator<String?>? validator;
  final FormFieldSetter<String?>? onSaved;
  final ValueChanged<String?>? onChanged;
  final ValueChanged<String?>? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;
  final Color? cursorColor;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Color? fillColor;
  final bool filled;
  final double borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final Color? focusBorderColor;
  final Color? enabledBorderColor;
  final Color? errorBorderColor;
  final String? title;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final TextEditingController _internalController;
  bool _obscure = false;

  TextEditingController get _effectiveController =>
      widget.controller ?? _internalController;

  @override
  void initState() {
    super.initState();
    _internalController = TextEditingController(
      text: widget.initialValue ?? '',
    );
    _obscure = widget.obscureText;
  }

  @override
  void dispose() {
    // Only dispose internal controller if we created it
    if (widget.controller == null) {
      _internalController.dispose();
    }
    super.dispose();
  }

  void _clearText() {
    _effectiveController.clear();
    if (widget.onChanged != null) widget.onChanged!('');
    setState(() {});
  }

  void _toggleObscure() {
    setState(() => _obscure = !_obscure);
  }

  InputBorder _buildBorder(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(widget.borderRadius),
    borderSide: BorderSide(color: color, width: 1.0),
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveTextStyle = widget.textStyle ?? theme.textTheme.bodyMedium;
    final effectiveHintStyle =
        widget.hintStyle ??
        theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor);
    final effectiveContentPadding =
        widget.contentPadding ??
        const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0);

    final enabledColor = widget.enabledBorderColor ?? ColorsManager.neutral100;
    final focusedColor = widget.focusBorderColor ?? ColorsManager.neutral100;
    final errorColor = widget.errorBorderColor ?? theme.colorScheme.error;

    // Build suffix widgets: user-provided suffixIcon/suffix or clear/obscure toggles
    Widget?
    trailing; // will be assigned to suffixIcon for correct sizing/padding
    if (widget.suffixIcon != null) {
      trailing = widget.suffixIcon;
    } else if (widget.obscureText &&
        widget.enableToggleObscure &&
        widget.maxLines == 1) {
      trailing = IconButton(
        onPressed: widget.enabled ? _toggleObscure : null,
        tooltip: _obscure ? 'Show' : 'Hide',
        icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
      );
    }

    // Show clear button when there's text and enabled
    if (widget.showClearButton &&
        widget.enabled &&
        _effectiveController.text.isNotEmpty) {
      final clearButton = IconButton(
        onPressed: _clearText,
        icon: const Icon(Icons.clear),
        tooltip: 'Clear',
      );
      // If there's already a trailing widget (e.g. eye toggle or custom suffixIcon), combine them
      if (trailing != null) {
        trailing = Row(
          mainAxisSize: MainAxisSize.min,
          children: [trailing, clearButton],
        );
      } else if (widget.suffix != null) {
        // If user provided a suffix (non-icon), combine it with clear button
        trailing = Row(
          mainAxisSize: MainAxisSize.min,
          children: [widget.suffix!, clearButton],
        );
      } else {
        trailing = clearButton;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)...[
          Text(widget.title ?? "", style: TextStyles.font16Grey500Weight.copyWith(color: ColorsManager.neutral700)),
          const SizedBox(height: 12.0),
        ],

        TextFormField(
          controller: widget.controller ?? _internalController,
          initialValue: widget.controller == null && widget.initialValue != null
              ? widget.initialValue
              : null,
          focusNode: widget.focusNode,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          textCapitalization: widget.textCapitalization,
          obscureText: _obscure,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          readOnly: widget.readOnly,
          enabled: widget.enabled,
          validator: widget.validator,
          onSaved: widget.onSaved,
          onChanged: (value) {
            setState(() {}); // to update clear button visibility
            if (widget.onChanged != null) widget.onChanged!(value);
          },
          onFieldSubmitted: widget.onFieldSubmitted,
          inputFormatters: widget.inputFormatters,
          autofillHints: widget.autofillHints != null
              ? List<String>.from(widget.autofillHints!)
              : null,
          cursorColor: widget.cursorColor ?? theme.colorScheme.primary,
          style: effectiveTextStyle,
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hintText,
            helperText: widget.helperText,
            errorText: widget.errorText,
            // Hide the default maxLength counter (e.g. "0/10") when maxLength is set
            counterText: widget.maxLength != null ? '' : null,
            prefixIcon: widget.prefixIcon,
            // Prefer using suffixIcon for proper sizing/constraints when possible.
            // If the user passed a non-icon `suffix` widget (like an image), render it inside
            // the `suffixIcon` slot so it follows the decoration constraints and is visible.
            suffixIcon:
                trailing ??
                (widget.suffix != null
                    ? Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: widget.suffix,
                      )
                    : null),
            prefix: widget.prefix,
            prefixText: widget.prefixText,
            suffixText: widget.suffixText,
            isDense: true,
            contentPadding: effectiveContentPadding,
            filled: widget.filled,
            fillColor: widget.fillColor,
            hintStyle: effectiveHintStyle,
            enabledBorder: _buildBorder(enabledColor),
            focusedBorder: _buildBorder(focusedColor),
            errorBorder: _buildBorder(errorColor),
            focusedErrorBorder: _buildBorder(errorColor),
          ),
        ),
      ],
    );
  }
}
