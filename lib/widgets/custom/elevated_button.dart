import 'package:flutter/material.dart';
import '../../utils/custom_text_style.dart';

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final double height;
  final bool isDisabled;
  final Color backGroundColor;
  final Color? textColor;
  const CustomElevatedButton({
    super.key,
    required this.title,
    required this.onTap,
    this.height = 45,
    this.isDisabled = false,
    required this.backGroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backGroundColor,
        minimumSize: Size.fromHeight(height),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      onPressed: isDisabled ? null : onTap,
      child: Text(
        title,
        style: CustomTextStyles.f12W600(color: textColor ?? Colors.white),
      ),
    );
  }
}
