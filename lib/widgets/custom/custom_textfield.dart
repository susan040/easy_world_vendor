import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../utils/custom_text_style.dart';

class CustomTextField extends StatelessWidget {
  final Function(String)? onValueChange;
  final FocusNode? focusNode;
  final String hint;
  final IconData? preIconPath;
  final IconData? suffixIconPath;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final Color? border;
  final Color? fillColor;
  final bool? readOnly;
  final bool? showError;
  final bool? autofocus;
  final String? labelText;
  final Function()? onTap;
  final Function(String)? onSubmitted;
  final int? maxCharacters;
  final TextCapitalization textCapitalization;

  const CustomTextField({
    super.key,
    this.fillColor,
    required this.hint,
    this.preIconPath,
    this.suffixIconPath,
    this.onValueChange,
    this.controller,
    this.validator,
    required this.textInputAction,
    required this.textInputType,
    this.border,
    this.readOnly = false,
    this.showError = true,
    this.textCapitalization = TextCapitalization.sentences,
    this.onTap,
    this.onSubmitted,
    this.autofocus = false,
    this.maxCharacters,
    this.focusNode,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextFormField(
      focusNode: focusNode,
      maxLength: maxCharacters,
      autofocus: autofocus!,
      textCapitalization: textCapitalization,
      onFieldSubmitted: onSubmitted,
      onTap: (onTap != null) ? onTap! : null,
      readOnly: (readOnly == null) ? false : readOnly!,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      maxLines: 1,
      validator: (validator != null) ? validator : null,
      controller: (controller != null) ? controller : null,
      onChanged: (text) {
        if (onValueChange != null) {
          onValueChange!(text);
        }
      },
      decoration: InputDecoration(
        label:
            labelText != null
                ? Text(
                  labelText ?? "",
                  style: CustomTextStyles.f16W400(
                    color: AppColors.primaryColor,
                  ),
                )
                : null,
        fillColor: fillColor ?? Colors.transparent,
        filled: fillColor != null,
        prefixIcon: (preIconPath != null) ? Icon(preIconPath) : null,
        suffixIcon:
            (suffixIconPath != null)
                ? Icon(
                  suffixIconPath,
                  size: 22,
                  color:
                      isDark ? AppColors.extraWhite : AppColors.textGreyColor,
                )
                : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            width: 1,
            color: border ?? AppColors.borderColor,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            width: 1,
            color: border ?? AppColors.errorColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            width: 1,
            color: border ?? AppColors.primaryColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            width: 1,
            color: border ?? AppColors.errorColor,
          ),
        ),
        errorStyle:
            (showError!)
                ? const TextStyle(fontSize: 12)
                : const TextStyle(fontSize: 0),
        hintText: hint,
        hintStyle: CustomTextStyles.f12W400(
          color: isDark ? AppColors.extraWhite : AppColors.secondaryTextColor,
        ),
      ),
      style: CustomTextStyles.f12W400(
        color:
            (readOnly ?? false)
                ? isDark
                    ? AppColors.extraWhite
                    : AppColors.blackColor
                : null,
      ),
    );
  }
}
