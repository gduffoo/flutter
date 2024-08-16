import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  final IconData? icon;
  final IconData? suffixIcon;

  const CustomTextFormField(
      {super.key,
      this.label,
      this.hintText,
      this.errorText,
      this.obscureText = false,
      this.onChanged,
      this.validator,
      this.prefixIcon,
      this.icon,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(borderRadius: BorderRadius.circular(30));

    return TextFormField(
      obscureText: obscureText,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        enabledBorder: border,
        focusedBorder:
            border.copyWith(borderSide: BorderSide(color: colors.primary)),
        errorBorder:
            border.copyWith(borderSide: BorderSide(color: Colors.red.shade800)),
        focusedErrorBorder:
            border.copyWith(borderSide: BorderSide(color: Colors.red.shade800)),
        label: label != null ? Text(label!) : null,
        isDense: true,
        hintText: hintText,
        focusColor: colors.primary,
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: colors.secondary,
              )
            : null,
        icon: icon != null
            ? Icon(
                icon,
                color: colors.secondary,
              )
            : null,
        suffixIcon: suffixIcon != null
            ? Icon(
                suffixIcon,
                color: colors.secondary,
              )
            : null,
        errorText: errorText,
      ),
    );
  }
}
