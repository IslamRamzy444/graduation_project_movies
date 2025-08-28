import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:graduation_project_movies/ui/auth/login/cubit/login_navigator.dart';
import 'package:graduation_project_movies/ui/auth/login/cubit/login_states.dart';
import 'package:graduation_project_movies/ui/auth/login/cubit/login_view_model.dart';
import 'package:graduation_project_movies/utils/alert_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:graduation_project_movies/utils/app_colors.dart';
import 'package:graduation_project_movies/utils/app_routes.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../cubits/language_cubit/language_cubit.dart';

// import '../../../l10n/app_localizations.dart';

import '../../../utils/app_assets.dart';
import '../../../utils/app_styles.dart';
import '../../widgets/custom_Elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginNavigator {
  bool isHidden = true;
  late LoginViewModel viewModel;

  @override
  void initState() {
    viewModel = LoginViewModel();
    viewModel.navigator = this;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var languageCubit = context.read<LanguageCubit>();
    final locale = context.watch<LanguageCubit>().state;
    var screenSize = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
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
                    key: viewModel.formKey,
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
                          controller: viewModel.emailController,
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
                          controller: viewModel.passwordController,
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
                                      AppAssets.eyeOffIcon,
                                      color: AppColors.whiteColor,
                                    )
                                  : Icon(
                                      Icons.remove_red_eye,
                                      color: AppColors.whiteColor,
                                    )),
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        SizedBox(height: screenSize.height * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              // style: ButtonStyle(),
                              onPressed: () {
                                navigateToForgetPasswordScreen();
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
                        BlocListener<LoginViewModel, LoginStates>(
                          listener: (context, state) {
                            if (state is LoginLoadingState) {
                              showLoading(
                                  AppLocalizations.of(context)!.login_loading);
                            } else if (state is LoginErrorState) {
                              showMessage(state.errorMessage);
                            } else {
                              showSuccessDialog(
                                  AppLocalizations.of(context)!.login_succeeded,
                                  () => navigateToHomeScreen());
                            }
                          },
                          child: CustomElevatedButton(
                            buttonText: AppLocalizations.of(context)!.login,
                            onPressed: () {
                              viewModel.login();
                            },
                          ),
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
                                padding:
                                    WidgetStatePropertyAll(EdgeInsets.zero),
                              ),
                              onPressed: () {
                                navigateToRegisterScreen();
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
                          onPressed: () async {
                            showLoading(AppLocalizations.of(context)!
                                .login_with_google_loading);
                            await Future.delayed(const Duration(seconds: 2));
                            hideLoading();
                            showSuccessDialog(
                              AppLocalizations.of(context)!.login_succeeded,
                              () => navigateToHomeScreen(),
                            );
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
  void showLoading(String loadingText) {
    DialogUtils.showLoading(context: context, loadingText: loadingText);
  }

  @override
  void showMessage(String message) {
    DialogUtils.showMessage(
        context: context,
        message: message,
        postActionName: AppLocalizations.of(context)!.ok);
  }

  @override
  void showSuccessDialog(String message, Function onclick) {
    DialogUtils.showMessage(
        context: context,
        message: message,
        postActionName: AppLocalizations.of(context)!.ok,
        posAction: onclick);
  }

  @override
  void navigateToForgetPasswordScreen() {
    Navigator.of(context).pushNamed(AppRoutes.forgetPasswordScreenRouteName);
  }

  @override
  void navigateToRegisterScreen() {
    Navigator.of(context).pushNamed(AppRoutes.registerScreenRouteName);
  }
}
