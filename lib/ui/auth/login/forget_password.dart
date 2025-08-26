import 'package:flutter/material.dart';
import 'package:graduation_project_movies/l10n/app_localizations.dart';
import 'package:graduation_project_movies/ui/widgets/custom_Elevated_button.dart';
import 'package:graduation_project_movies/ui/widgets/custom_text_form_field.dart';
import 'package:graduation_project_movies/utils/app_assets.dart';
import 'package:graduation_project_movies/utils/app_colors.dart';
import 'package:graduation_project_movies/utils/app_styles.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(AppLocalizations.of(context)!.forget_password,
              style: AppStyles.regular16PrimaryRoboto),
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: AppStyles.regular16PrimaryRoboto.color),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.04, vertical: height * 0.02),
          child: Column(
            children: [
              Image.asset(AppAssets.forgetPassword),
              CustomTextField(
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'please Enter Email';
                  }
                  final bool emailValid = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                  ).hasMatch(text);
                  if (!emailValid) {
                    return 'please Enter Valid Email';
                  }
                  return null;
                },
                controller: emailController,
                hintStyle: AppStyles.regular15WhiteRoboto,
                prefixIcon: Image.asset(
                  AppAssets.emailIcon,
                  color: AppColors.whiteColor,
                ),
                hintText: AppLocalizations.of(context)!.email,
                keyboardType: TextInputType.emailAddress,
                labelStyle: AppStyles.regular16WhiteRoboto,
              ),
              SizedBox(height: height * 0.03),
              CustomElevatedButton(
                buttonText: AppLocalizations.of(context)!.verify_email,
                buttonTextStyle: AppStyles.regular20BlackRoboto,
                onPressed: () {
                  //TODO: Login logic;
                },
              ),
            ],
          ),
        ));
  }
}
