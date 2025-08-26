import 'package:flutter/material.dart';
import 'package:graduation_project_movies/l10n/app_localizations.dart';

// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import '../../l10n/app_localizations.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import 'custom_Elevated_button.dart';

class CustomOnboardingItem extends StatelessWidget {
  String img;
  String firstText;
  String? secondText;
  double contHeight;
  VoidCallback onNextPressed;
  VoidCallback onBackPressed;
  bool isFirstScreen;
  bool isLastScreen;

  CustomOnboardingItem({
    super.key,
    required this.img,
    this.contHeight = 0.300,
    required this.firstText,
    this.secondText,
    required this.onNextPressed,
    this.isFirstScreen = false,
    required this.onBackPressed,
    this.isLastScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image(
          image: AssetImage(img),
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.0372,
            vertical: isLastScreen ? height * 0.0190 : height * 0.0200,
          ),
          height: height * contHeight,
          decoration: BoxDecoration(
            color: AppColors.blackColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45),
              topRight: Radius.circular(45),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  firstText,
                  textAlign: TextAlign.center,
                  style: AppStyles.bold24White,
                ),
                isLastScreen
                    ? SizedBox.shrink()
                    : SizedBox(height: height * 0.02),
                Text(
                  secondText ?? "",
                  textAlign: TextAlign.center,
                  style: AppStyles.regular20White,
                ),
                isLastScreen
                    ? SizedBox.shrink()
                    : SizedBox(height: height * 0.02),
                _buildButtons(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtons(BuildContext context) {
    if (isFirstScreen) {
      return CustomElevatedButton(
        buttonText: AppLocalizations.of(context)!.next,
        onPressed: onNextPressed,
      );
    } else if (isLastScreen) {
      return Column(
        children: [
          CustomElevatedButton(
            buttonText: AppLocalizations.of(context)!.finish,
            onPressed: onNextPressed,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          CustomElevatedButton(
            buttonText: AppLocalizations.of(context)!.back,
            buttonColor: Colors.transparent,
            borderColor: AppColors.primaryColor,
            buttonTextStyle: AppStyles.regular20White,
            onPressed: onBackPressed,
          ),
        ],
      );
    } else {
      return Column(
        children: [
          CustomElevatedButton(
            buttonText: AppLocalizations.of(context)!.next,
            onPressed: onNextPressed,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          CustomElevatedButton(
            buttonText: AppLocalizations.of(context)!.back,
            buttonColor: Colors.transparent,
            borderColor: AppColors.primaryColor,
            buttonTextStyle: AppStyles.regular20White,
            onPressed: onBackPressed,
          ),
        ],
      );
    }
  }
}
