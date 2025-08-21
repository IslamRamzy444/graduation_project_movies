import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_movies/ui/auth/login/forget_password.dart';
import 'package:graduation_project_movies/ui/auth/login/login_screen.dart';
import 'package:graduation_project_movies/ui/onboarding/intro_screen.dart';
import 'package:graduation_project_movies/ui/updateProfile/update_profile_screen.dart';
import 'package:graduation_project_movies/utils/app_routes.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:graduation_project_movies/utils/app_theme.dart';

import 'cubits/language_cubit.dart';

import 'l10n/app_localizations.dart';

void main() {
  runApp(
      BlocProvider(create: (context) => LanguageCubit(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, Locale>(builder: (context, locale) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.updateProfileScreenRouteName,
        routes: {
          AppRoutes.loginScreenRouteName: (context) => LoginScreen(),
          AppRoutes.introScreenRouteName: (context) => IntroScreen(),
          AppRoutes.updateProfileScreenRouteName: (context) =>
              UpdateProfileScreen(),
          AppRoutes.forgetPasswordScreenRouteName: (context) =>
              ForgetPassword(),
        },
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: locale,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
      );
    });
  }
}
