import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_movies/l10n/app_localizations.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:graduation_project_movies/ui/widgets/custom_Elevated_button.dart';
import 'package:graduation_project_movies/utils/app_assets.dart';
import 'package:graduation_project_movies/utils/app_routes.dart';
import 'package:graduation_project_movies/utils/app_styles.dart';

class OnboardingFirstScreen extends StatelessWidget {
  const OnboardingFirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding:EdgeInsets.all(width*0.037),
        decoration:BoxDecoration(
          image:DecorationImage(image: AssetImage(AppAssets.allMoviesImage,),fit: BoxFit.cover,),
      ),
        child:SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "${AppLocalizations.of(context)!.boarding_title_one}\n",
                      style: AppStyles.medium36White,
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context)!.boarding_content_one,
                      style: AppStyles.regular20GreyWhite,
                    ),

                  ],
                ),
              ),
              SizedBox(height: height*0.025,),
              CustomElevatedButton(buttonText: AppLocalizations.of(context)!.explore_now, onPressed:(){
                Navigator.pushReplacementNamed(context, AppRoutes.introScreenRouteName);
              }),
            ],
          ),
        ),
      )
    );
  }
}
