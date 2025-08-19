import 'package:flutter/material.dart';
import 'package:graduation_project_movies/ui/onboarding/intro_screen.dart';
import 'package:graduation_project_movies/utils/app_routes.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:graduation_project_movies/utils/app_theme.dart';

import 'l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.introScreenRouteName,
      routes: {
        AppRoutes.introScreenRouteName:(context)=>IntroScreen()
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale("en"),
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
    );
  }
}
