import 'package:easy_world_vendor/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/colors.dart';
import '../../utils/custom_text_style.dart';
import '../../utils/image_path.dart';

class CustomPasswordField extends StatelessWidget {
  final String hint;
  final FocusNode? focusNode;
  final bool eye;
  final VoidCallback onEyeClick;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final Function(String)? onSubmitted;
  final String? labelText;

  const CustomPasswordField({
    Key? key,
    required this.hint,
    required this.eye,
    required this.onEyeClick,
    required this.controller,
    required this.textInputAction,
    this.validator,
    this.onSubmitted,
    this.focusNode,
    this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextFormField(
      focusNode: focusNode,
      onFieldSubmitted: onSubmitted,
      controller: controller,
      validator: validator ?? Validators.checkPasswordField,
      obscureText: eye,
      maxLines: 1,
      textInputAction: textInputAction,
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
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.borderColor),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.red),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.primaryColor),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.red),
        ),
        suffixIcon: IconButton(
          onPressed: onEyeClick,
          icon:
              (eye)
                  ? SvgPicture.asset(
                    ImagePath.eyeOff,
                    height: 22,
                    colorFilter: const ColorFilter.mode(
                      AppColors.textGreyColor,
                      BlendMode.srcIn,
                    ),
                    fit: BoxFit.scaleDown,
                  )
                  : SvgPicture.asset(
                    ImagePath.eye,
                    height: 12,
                    colorFilter: const ColorFilter.mode(
                      AppColors.textGreyColor,
                      BlendMode.srcIn,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
        ),
        errorStyle: const TextStyle(fontSize: 12),
        hintText: hint,
        hintStyle: CustomTextStyles.f13W400(
          color: AppColors.secondaryTextColor,
        ),
      ),
      style: CustomTextStyles.f13W400(
        color: isDark ? AppColors.extraWhite : AppColors.blackColor,
      ),
    );
  }
}
