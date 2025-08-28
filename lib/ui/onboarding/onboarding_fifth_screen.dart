import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_movies/ui/onboarding/cubit/onboarding_cubit.dart';

//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../l10n/app_localizations.dart';
import '../../utils/app_assets.dart';
import '../widgets/custom_onboarding_item.dart';

class OnboardingFifthScreen extends StatelessWidget {
  const OnboardingFifthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return CustomOnboardingItem(
      img: AppAssets.drStrangeImage,
      firstText: AppLocalizations.of(context)!.rate_review_learn,
      secondText: AppLocalizations.of(context)!.boarding_content_five,
      onNextPressed: () => context.read<OnBoardingViewModel>().nextPage(3),
      onBackPressed: () => context.read<OnBoardingViewModel>().previousPage(3),
      contHeight: 0.392,
      isLastScreen: false,
    );
  }
}
