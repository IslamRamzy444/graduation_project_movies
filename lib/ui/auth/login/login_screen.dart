import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:graduation_project_movies/utils/app_colors.dart';
import 'package:graduation_project_movies/utils/app_routes.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../cubits/language_cubit/language_cubit.dart';
//import '../../../l10n/app_localizations.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_styles.dart';
import '../../widgets/custom_Elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isHidden = true;
  TextEditingController emailController =
      TextEditingController(text: 'farouk@gmail.com');
  TextEditingController passwordController =
      TextEditingController(text: '12345678945');
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var languageCubit = context.read<LanguageCubit>();
    final locale = context.watch<LanguageCubit>().state;
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.04),
          child: SingleChildScrollView(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  AppAssets.topLoginLogo,
                  height: screenSize.height * 0.2,
                ),
                SizedBox(height: screenSize.height * 0.04),
                Form(
                  key: formKey,
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextField(
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return AppLocalizations.of(context)!
                                .empty_email_error;
                          }
                          final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                          ).hasMatch(text);
                          if (!emailValid) {
                            return AppLocalizations.of(context)!
                                .invalid_email_error;
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
                      SizedBox(height: screenSize.height * 0.02),
                      CustomTextField(
                        labelStyle: AppStyles.regular16WhiteRoboto,
                        obscureText: isHidden,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return AppLocalizations.of(context)!
                                .empty_password_error;
                          }
                          if (text.length < 8) {
                            return AppLocalizations.of(context)!
                                .short_password_error;
                          }

                          return null;
                        },
                        controller: passwordController,
                        hintStyle: AppStyles.regular15WhiteRoboto,
                        prefixIcon: Image.asset(
                          AppAssets.passwordIcon,
                          color: AppColors.whiteColor,
                        ),
                        hintText: AppLocalizations.of(context)!.password,
                        suffixIcon: InkWell(
                            onTap: () {
                              isHidden = !isHidden;
                              setState(() {});
                            },
                            child: isHidden
                                ? Image.asset(
                                    //TODO: onClick hide and Show
                                    AppAssets.eyeOffIcon,
                                    color: AppColors.whiteColor,
                                  )
                                : Icon(
                                    Icons.remove_red_eye,
                                    color: AppColors.whiteColor,
                                  )),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: screenSize.height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            // style: ButtonStyle(),
                            onPressed: () {
                              //TODO: Navigate to forget password screen
                              Navigator.of(context).pushNamed(
                                  AppRoutes.forgetPasswordScreenRouteName);
                            },
                            child: Text(
                              AppLocalizations.of(
                                context,
                              )!
                                  .forget_password_question,
                              style: AppStyles.regular14PrimaryRoboto,
                            ),
                          ),
                        ],
                      ),
                      CustomElevatedButton(
                        buttonText: AppLocalizations.of(context)!.login,
                        onPressed: () {
                          //TODO: Login logic;
                          login();
                        },
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.do_not_have_account,
                            style: AppStyles.regular14WhiteRoboto,
                          ),
                          SizedBox(width: screenSize.width * 0.015),
                          TextButton(
                            style: ButtonStyle(
                              padding: WidgetStatePropertyAll(EdgeInsets.zero),
                            ),
                            onPressed: () {
                              //TODO: Navigate to register
                              Navigator.of(context)
                                  .pushNamed(AppRoutes.registerScreenRouteName);
                            },
                            child: Text(
                                AppLocalizations.of(context)!.create_account,
                                style: AppStyles.regular14PrimaryRoboto),
                          ),
                        ],
                      ),
                      //SizedBox(height: screenSize.height * 0.02),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              height: screenSize.height * 0.04,
                              color: AppColors.primaryColor,
                              thickness: 1,
                              indent: screenSize.width * 0.05,
                              endIndent: screenSize.width * 0.05,
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.or,
                            style: AppStyles.regular15PrimaryRoboto,
                          ),
                          Expanded(
                            child: Divider(
                              height: screenSize.height * 0.04,
                              color: AppColors.primaryColor,
                              thickness: 1,
                              indent: screenSize.width * 0.05,
                              endIndent: screenSize.width * 0.05,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                      CustomElevatedButton(
                        leadingIcon: Image.asset(AppAssets.googleIcon),
                        buttonTextStyle: AppStyles.regular16DarkGreyRoboto,
                        buttonColor: AppColors.primaryColor,
                        buttonText: AppLocalizations.of(
                          context,
                        )!
                            .login_with_google,
                        onPressed: () {
                          //TODO: google login logic
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenSize.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ToggleSwitch(
                      changeOnTap: true,
                      customWidgets: [
                        Image.asset(AppAssets.usaFlagIcon,
                            width: 24, height: 24),
                        Image.asset(AppAssets.egFlagIcon,
                            width: 24, height: 24),
                      ],
                      minWidth: 60,
                      minHeight: 30,
                      initialLabelIndex: locale.languageCode == 'en' ? 0 : 1,
                      cornerRadius: 30.0,
                      radiusStyle: true,
                      borderWidth: 2.0,
                      borderColor: [AppColors.primaryColor],
                      dividerColor: Colors.transparent,
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.transparent,
                      activeBgColors: [
                        [AppColors.primaryColor],
                        [AppColors.primaryColor],
                      ],
                      onToggle: (index) {
                        if (index == 0) {
                          languageCubit.changeLanguage(Locale('en'));
                        } else {
                          languageCubit.changeLanguage(Locale('ar'));
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    if (formKey.currentState?.validate() == true) {}
  }
}
