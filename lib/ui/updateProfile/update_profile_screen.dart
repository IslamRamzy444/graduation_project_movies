import 'package:flutter/material.dart';
import 'package:graduation_project_movies/l10n/app_localizations.dart';
import 'package:graduation_project_movies/ui/widgets/custom_Elevated_button.dart';
import 'package:graduation_project_movies/ui/widgets/custom_text_form_field.dart';
import 'package:graduation_project_movies/utils/app_assets.dart';
import 'package:graduation_project_movies/utils/app_colors.dart';

import '../../utils/app_styles.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        title: Text(
          AppLocalizations.of(context)!.pick_avatar,
          style: AppStyles.regular16PrimaryRoboto,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.02,
            ),
            Container(
                alignment: Alignment.center,
                child: Image(image: AssetImage(AppAssets.avatar1))),
            SizedBox(
              height: height * 0.02,
            ),
            CustomTextField(
              controller: nameController,
              prefixIcon: ImageIcon(
                AssetImage(AppAssets.personIcon),
                color: AppColors.whiteColor,
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            CustomTextField(
              controller: phoneController,
              prefixIcon: ImageIcon(
                AssetImage(AppAssets.phoneIcon),
                color: AppColors.whiteColor,
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
              AppLocalizations.of(context)!.reset_password,
              style: AppStyles.regular20White,
            ),
            Expanded(child: SizedBox()),
            CustomElevatedButton(
                buttonText: AppLocalizations.of(context)!.delete_account,
                onPressed: () {},
                buttonColor: AppColors.redColor,
                borderColor: AppColors.redColor,
                buttonTextStyle: AppStyles.regular20White,
            ),
            SizedBox(
              height: height * 0.01,
            ),
            CustomElevatedButton(
              buttonText: AppLocalizations.of(context)!.update_data,
              onPressed: () {},
            ),
            SizedBox(height: height*0.03,)
          ],
        ),
      ),
    );
  }
}
