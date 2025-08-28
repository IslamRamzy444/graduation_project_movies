import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_movies/ui/onboarding/cubit/onboarding_cubit.dart';
import 'package:graduation_project_movies/ui/widgets/custom_onboarding_item.dart';

//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../l10n/app_localizations.dart';

import '../../utils/app_assets.dart';

class OnboardingSecondScreen extends StatelessWidget {
  const OnboardingSecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return CustomOnboardingItem(
        img: AppAssets.avengersImage,
        firstText: AppLocalizations.of(context)!.discover_movies,
        secondText: AppLocalizations.of(context)!.boarding_content_two,
        onNextPressed: () => context.read<OnBoardingViewModel>().nextPage(0),
        onBackPressed: () => context.read<OnBoardingViewModel>().previousPage(0),
        contHeight:0.378,
        isFirstScreen: false,
    );
  }
}
