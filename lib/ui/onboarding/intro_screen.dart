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

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnBoardingViewModel(),
      child: BlocListener<OnBoardingViewModel, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingFinished) {
            return;
          }
          int targetPage = 0;
          if (state is OnboardingFirstPage) targetPage = 0;
          else if (state is OnboardingNormalPage) targetPage = state.currentPage;
          else if (state is OnboardingLastPage) targetPage = state.currentPage;
          
          _pageController.animateToPage(
            targetPage,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        child: Scaffold(
          body: PageView(
            controller: _pageController,
            onPageChanged: (page) {
              context.read<OnBoardingViewModel>().goToPage(page);
            },
            children: [
              OnboardingSecondScreen(),
              OnboardingThirdScreen(),
              OnboardingFourthScreen(),
              OnboardingFifthScreen(),
              OnboardingSixthScreen(),
            ],
          ),
        ),
      ),
    );
  }
}