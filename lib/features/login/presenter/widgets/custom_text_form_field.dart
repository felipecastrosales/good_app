import 'package:flutter/material.dart';

import 'package:good_app/app/core/ui/colors/app_colors.dart';
import 'package:good_app/app/core/ui/styles/app_borders.dart';
import 'package:good_app/app/core/ui/styles/app_text_styles.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final IconData prefixIcon;
  final Widget? suffixIcon;
  final bool isSecret;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;

  const CustomTextFormField({
    Key? key,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.isSecret = false,
    required this.controller,
    required this.validator,
    required this.onChanged,
    this.keyboardType,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  static const customBorder = AppBorders.primaryBorder;
  bool isObscure = false;

  @override
  void initState() {
    super.initState();
    isObscure = widget.isSecret;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: widget.keyboardType,
        obscureText: isObscure,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          fillColor: AppColors.backgroundMiddle,
          filled: true,
          isDense: true,
          hintText: widget.hintText,
          hintStyle: AppTextStyles.hintText,
          contentPadding: const EdgeInsets.all(16),
          prefixIcon: Icon(widget.prefixIcon, color: AppColors.grey),
          // suffixIcon: widget.isSecret
          // ? IconButton(
          //     onPressed: () => setState(() => isObscure = !isObscure),
          //     icon: isObscure ? AppIcons.visibility : AppIcons.visibilityOff,
          //   )
          // : null,
          border: customBorder(AppColors.grey),
          errorBorder: customBorder(AppColors.red),
          enabledBorder: customBorder(AppColors.backgroundDark),
          disabledBorder: customBorder(AppColors.backgroundDark),
          focusedBorder: customBorder(AppColors.primary),
          focusedErrorBorder: customBorder(AppColors.red),
        ),
      ),
    );
  }
}
