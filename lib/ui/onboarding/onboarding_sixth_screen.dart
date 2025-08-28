import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_movies/ui/onboarding/cubit/onboarding_cubit.dart';

//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../l10n/app_localizations.dart';
import '../../utils/app_assets.dart';
import '../widgets/custom_onboarding_item.dart';

class OnboardingSixthScreen extends StatelessWidget {
  const OnboardingSixthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return CustomOnboardingItem(
      img: AppAssets.nineteen17Image,
      firstText: AppLocalizations.of(context)!.start_watching,
      onNextPressed: () => context.read<OnBoardingViewModel>().finishOnBoarding(context),
      onBackPressed: () => context.read<OnBoardingViewModel>().previousPage(4),
      contHeight: 0.250,
      isLastScreen: true,
    );
  }
}
