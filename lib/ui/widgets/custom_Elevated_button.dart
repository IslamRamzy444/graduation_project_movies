import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';

class CustomElevatedButton extends StatelessWidget {
  final Color buttonColor;
  final Color? borderColor;
  final TextStyle? buttonTextStyle;
  final String buttonText;
  final VoidCallback onPressed;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final MainAxisAlignment rowMainAxesAlignment;

  const CustomElevatedButton({
    this.rowMainAxesAlignment = MainAxisAlignment.center,
    super.key,
    this.leadingIcon,
    this.trailingIcon,
    this.buttonTextStyle,
    this.buttonColor = AppColors.primaryColor,
    required this.buttonText,
    required this.onPressed,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: EdgeInsets.symmetric(
          vertical: screenSize.height * 0.02,
          horizontal: screenSize.width * 0.02,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            width: 1,
            color: borderColor ?? AppColors.primaryColor,
          ),
        ),
        backgroundColor: buttonColor,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: rowMainAxesAlignment,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leadingIcon != null) leadingIcon!,
          if (leadingIcon != null) SizedBox(width: screenSize.width * 0.02),
          Text(
            buttonText,
            style: buttonTextStyle ?? AppStyles.regular20BlackRoboto,
          ),
          if (trailingIcon != null) SizedBox(width: screenSize.width * 0.02),
          if (trailingIcon != null) trailingIcon!,
        ],
      ),
    );
  }
}
