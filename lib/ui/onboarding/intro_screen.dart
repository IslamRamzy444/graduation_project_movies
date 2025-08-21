import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_movies/ui/onboarding/cubit/onboarding_cubit.dart';
import 'package:graduation_project_movies/ui/onboarding/onboarding_fifth_screen.dart';
import 'package:graduation_project_movies/ui/onboarding/onboarding_fourth_screen.dart';
import 'package:graduation_project_movies/ui/onboarding/onboarding_second_screen.dart';
import 'package:graduation_project_movies/ui/onboarding/onboarding_sixth_screen.dart';
import 'package:graduation_project_movies/ui/onboarding/onboarding_third_screen.dart';
import 'cubit/onboarding_states.dart';
import 'onboarding_first_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnBoardingViewModel(),
      child: BlocBuilder<OnBoardingViewModel, OnboardingState>(
        builder: (context, state) {
          int currentPage = 0;
          if (state is OnboardingFirstPage) currentPage = 0;
          else if (state is OnboardingNormalPage) currentPage = state.currentPage;
          else if (state is OnboardingLastPage) currentPage = state.currentPage;
          
          return Scaffold(
            body: IndexedStack(
              index: currentPage,
              children: [
                OnboardingSecondScreen(),
                OnboardingThirdScreen(),
                OnboardingFourthScreen(),
                OnboardingFifthScreen(),
                OnboardingSixthScreen(),
              ],
            ),
          );
        },
      ),
    );
  }
}