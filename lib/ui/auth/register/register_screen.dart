import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:graduation_project_movies/l10n/app_localizations.dart';
import 'package:graduation_project_movies/ui/auth/register/cubit/register_view_model.dart';
import 'package:graduation_project_movies/ui/widgets/custom_Elevated_button.dart';
import 'package:graduation_project_movies/ui/widgets/custom_text_form_field.dart';
import 'package:graduation_project_movies/utils/alert_dialog.dart';
import 'package:graduation_project_movies/utils/app_assets.dart';
import 'package:graduation_project_movies/utils/app_colors.dart';
import 'package:graduation_project_movies/utils/app_routes.dart';
import 'package:graduation_project_movies/utils/app_styles.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../cubits/language_cubit/language_cubit.dart';

import 'cubit/register_navigator.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    implements RegisterNavigator {
  late RegisterViewModel viewModel;
  bool obscured1 = true;
  bool obscured2 = true;

  List<String> avatars = [
    AppAssets.avatar1,
    AppAssets.avatar2,
    AppAssets.avatar3,
    AppAssets.avatar4,
    AppAssets.avatar5,
    AppAssets.avatar6,
    AppAssets.avatar7,
    AppAssets.avatar8,
    AppAssets.avatar9,
  ];

  @override
  void initState() {
    super.initState();
    viewModel = RegisterViewModel();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var languageCubit = context.read<LanguageCubit>();
    final locale = context.watch<LanguageCubit>().state;
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.register,
              style: AppStyles.regular16PrimaryRoboto),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.04 * width),
            child: Column(
              children: [
                /// Avatar selector
                SizedBox(
                  height: 0.17 * height,
                  child: CarouselSlider(
                    options: CarouselOptions(
                        height: 0.15 * height,
                        enlargeCenterPage: true,
                        viewportFraction: 0.3),
                    items: avatars.map((avatar) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            viewModel.avatarId = avatars.indexOf(avatar) + 1;
                          });
                        },
                        child: CircleAvatar(
                          radius: 0.09 * width,
                          child: Image.asset(avatar),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Text(AppLocalizations.of(context)!.avatar,
                    style: AppStyles.regular16WhiteRoboto),
                SizedBox(height: 0.01 * height),

                /// Form
                Form(
                  key: viewModel.formKey,

                  child: Column(
                    children: [
                      CustomTextField(
                        controller: viewModel.nameController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return AppLocalizations.of(context)!
                                .empty_name_error;
                          }
                          return null;
                        },
                        hintText: AppLocalizations.of(context)!.name,
                        prefixIcon: ImageIcon(

                          AssetImage(AppAssets.userNameIcon),
                          color: AppColors.whiteColor,
                        ),
                      ),
                      SizedBox(height: 0.02 * height),

                      CustomTextField(
                        controller: viewModel.emailController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return AppLocalizations.of(context)!
                                .empty_email_error;
                          }
                          final bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(text.trim());
                          if (!emailValid) {
                            return AppLocalizations.of(context)!
                                .invalid_email_error;
                          }
                          return null;
                        },
                        hintText: AppLocalizations.of(context)!.email,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: ImageIcon(
                          AssetImage(AppAssets.emailIcon),
                          color: AppColors.whiteColor,
                        ),

                      ),
                      SizedBox(height: 0.02 * height),

                      CustomTextField(
                        controller: viewModel.passwordController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return AppLocalizations.of(context)!
                                .empty_password_error;
                          }
                          if (text.trim().length < 8) {
                            return AppLocalizations.of(context)!
                                .short_password_error;
                          }
                          return null;
                        },
                        hintText: AppLocalizations.of(context)!.password,
                        prefixIcon: ImageIcon(
                          AssetImage(AppAssets.passwordIcon),
                          color: AppColors.whiteColor,
                        ),


                        obscureText: obscured1,
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              obscured1 = !obscured1;
                            });
                          },
                          child: obscured1
                              ? Icon(Icons.visibility_off,
                                  color: AppColors.whiteColor)
                              : Icon(Icons.visibility,
                                  color: AppColors.whiteColor),
                        ),
                      ),
                      SizedBox(height: 0.02 * height),

                      CustomTextField(
                        controller: viewModel.rePasswordController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return AppLocalizations.of(context)!
                                .empty_re_password_error;
                          }
                          if (text.trim().length < 8) {
                            return AppLocalizations.of(context)!
                                .short_password_error;
                          }

                          if (viewModel.passwordController.text.trim() !=
                              text.trim()) {

                            return AppLocalizations.of(context)!
                                .mis_match_re_password;
                          }
                          return null;
                        },
                        hintText:
                            AppLocalizations.of(context)!.confirm_password,
                        prefixIcon: ImageIcon(
                          AssetImage(AppAssets.passwordIcon),
                          color: AppColors.whiteColor,
                        ),
                        obscureText: obscured2,
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              obscured2 = !obscured2;
                            });
                          },
                          child: obscured2
                              ? Icon(Icons.visibility_off,
                                  color: AppColors.whiteColor)
                              : Icon(Icons.visibility,
                                  color: AppColors.whiteColor),
                        ),
                      ),
                      SizedBox(height: 0.02 * height),
                      CustomTextField(
                        controller: viewModel.phoneController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return AppLocalizations.of(context)!
                                .empty_phone_error;
                          }
                          return null;
                        },
                        hintText: AppLocalizations.of(context)!.phone_number,
                        prefixIcon: ImageIcon(
                          AssetImage(AppAssets.phoneIcon),
                          color: AppColors.whiteColor,
                        ),

                      ),
                      SizedBox(height: 0.02 * height),
                      CustomElevatedButton(
                        buttonTextStyle: AppStyles.regular20BlackRoboto,
                        buttonText:
                            AppLocalizations.of(context)!.create_account,
                        onPressed: () {
                          viewModel.register();
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 0.02 * height),

                /// Already have account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.already_have_account,
                        style: AppStyles.regular14WhiteRoboto),
                    InkWell(
                        onTap: () {
                          navigateToLoginScreen();
                        },
                        child: Text(AppLocalizations.of(context)!.login,
                            style: AppStyles.regular14PrimaryRoboto))
                  ],
                ),

                SizedBox(height: 0.02 * height),

                /// Language toggle
                ToggleSwitch(
                  initialLabelIndex: locale.languageCode == 'en' ? 0 : 1,
                  totalSwitches: 2,
                  dividerColor: AppColors.transparentColor,
                  activeFgColor: AppColors.whiteColor,
                  inactiveBgColor: AppColors.transparentColor,
                  activeBgColors: [
                    [AppColors.primaryColor],
                    [AppColors.primaryColor]
                  ],
                  borderColor: [AppColors.primaryColor],
                  borderWidth: 2,
                  minWidth: 60,
                  minHeight: 30,
                  radiusStyle: true,
                  cornerRadius: 30,
                  customWidgets: [
                    Image.asset(AppAssets.usaFlagIcon, width: 24, height: 24),
                    Image.asset(AppAssets.egFlagIcon, width: 24, height: 24),
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
            ),
          ),
        ),
      ),
    );
  }

  @override
  void hideLoading() {
    DialogUtils.hideLoading(context: context);
  }

  @override
  void navigateToHomeScreen() {
    Navigator.pushReplacementNamed(context, AppRoutes.homeScreenRouteName);
  }

  @override
  void navigateToLoginScreen() {
    Navigator.pushNamed(context, AppRoutes.loginScreenRouteName);
  }

  @override
  void showLoading(String loadingText) {
    DialogUtils.showLoading(context: context, loadingText: loadingText);
  }

  @override
  void showMessage(String message, {String? title}) {
    DialogUtils.showMessage(
        context: context,
        message: message,
        title: title,
        postActionName: AppLocalizations.of(context)!.ok);
  }

  @override
  void showSuccessDialog(String message, Function onClick) {
    DialogUtils.showMessage(
        context: context,
        message: message,
        postActionName: AppLocalizations.of(context)!.ok,
        posAction: onClick);
  }
}
