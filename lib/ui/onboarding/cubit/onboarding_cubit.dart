import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:graduation_project_movies/ui/onboarding/cubit/onboarding_states.dart';
import 'package:graduation_project_movies/utils/app_routes.dart';

class OnBoardingViewModel extends Cubit<OnboardingState> {

  OnBoardingViewModel() : super(OnboardingFirstPage(currentPage: 0));

  void nextPage(int currentPage) {
    if(currentPage < 4){
      emit(OnboardingNormalPage(currentPage: currentPage + 1));
    } else {
      emit(OnboardingLastPage(currentPage: currentPage));
    }
  }
  
  void previousPage(int currentPage) {
    if(currentPage > 0){
      emit(OnboardingNormalPage(currentPage: currentPage - 1));
    } else {
      emit(OnboardingFirstPage(currentPage: currentPage));
    }
  }

  void goToPage(int page) {
    if (page >= 0 && page <= 4) {
      if (page == 0) {
        emit(OnboardingFirstPage(currentPage: page));
      } else if (page == 4) {
        emit(OnboardingLastPage(currentPage: page));
      } else {
        emit(OnboardingNormalPage(currentPage: page));
      }
    }
  }
  
  void finishOnBoarding(BuildContext context) {
    Navigator.pushReplacementNamed(context, AppRoutes.loginScreenRouteName);
    emit(OnboardingFinished());
  }
}