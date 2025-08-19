import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';

class CustomElevatedButton extends StatelessWidget {
  Color buttonColor;
  Color? borderColor;
  TextStyle? buttonTextStyle;
  String buttonText;
  VoidCallback onPressed;
  Widget? leadingIcon;
  MainAxisAlignment rowMainAxesAlignment;
  bool isDateAndTime;

  CustomElevatedButton({
    this.isDateAndTime = false,
    this.rowMainAxesAlignment = MainAxisAlignment.center,
    super.key,
    this.leadingIcon,
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
            //horizontal: screenSize.width * 0.02,
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
          children: [
            if (leadingIcon != null) SizedBox(width: screenSize.width * 0.01),
            Text(
              buttonText,
              style: buttonTextStyle ?? AppStyles.regular20BlackRoboto,
            ),
          ],
        ));
  }
}
