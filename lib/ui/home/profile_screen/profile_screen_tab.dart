import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';

typedef OnTap = void Function();

class ProfileScreenTab extends StatelessWidget {
  String icon;
  VoidCallback onTap;
  String text;
  bool isSelected;

  ProfileScreenTab(
      {super.key,
      required this.icon,
      required this.onTap,
      required this.text,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width * 0.4,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: isSelected
                        ? AppColors.primaryColor
                        : AppColors.transparentColor))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ImageIcon(
              AssetImage(icon),
              size: 50,
              color: AppColors.primaryColor,
            ),
            Text(
              text,
              style: AppStyles.regular20White,
            )
          ],
        ),
      ),
    );
  }
}
