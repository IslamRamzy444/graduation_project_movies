import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';

typedef OnValidator = String? Function(String?)?;

class CustomTextField extends StatelessWidget {
  Color boarderSideColor;
  String? hintText;
  TextStyle? hintStyle;
  String? labelText;
  TextStyle? labelStyle;
  Widget? prefixIcon;
  Widget? suffixIcon;
  TextEditingController controller;
  OnValidator? validator;
  TextInputType? keyboardType;
  bool obscureText;
  String? obscuringCharacter;
  int? maxLines;

  CustomTextField({
    this.maxLines,
    this.obscuringCharacter,
    this.obscureText = false,
    super.key,
    this.keyboardType = TextInputType.text,
    required this.controller,
    this.boarderSideColor = AppColors.darkGreyColor,
    this.hintText,
    this.hintStyle,
    this.labelStyle,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintStyle: hintStyle ?? AppStyles.regular16WhiteRoboto,
        hintText: hintText,
        labelStyle: labelStyle ?? AppStyles.regular14PrimaryRoboto,
        labelText: labelText,
        enabledBorder: decorationBoarder(colorBoarderSide: boarderSideColor),
        focusedBorder: decorationBoarder(colorBoarderSide: boarderSideColor),
        errorBorder: decorationBoarder(colorBoarderSide: AppColors.redColor),
        focusedErrorBorder: decorationBoarder(
          colorBoarderSide: AppColors.redColor,
        ),
        errorStyle: AppStyles.regular16DarkGreyRoboto
            .copyWith(color: AppColors.redColor),
      ),
      cursorColor: AppColors.primaryColor,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter ?? '.',
      style: Theme.of(context).textTheme.bodySmall,
    );
  }

  OutlineInputBorder decorationBoarder({required Color colorBoarderSide}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: colorBoarderSide, width: 1),
    );
  }
}
