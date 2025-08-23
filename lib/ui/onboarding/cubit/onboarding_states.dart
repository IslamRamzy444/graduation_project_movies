
abstract class OnboardingState {}

class OnboardingFirstPage extends OnboardingState {
  final int currentPage;
  OnboardingFirstPage({required this.currentPage});
}

class OnboardingLastPage extends OnboardingState {
  final int currentPage;
  OnboardingLastPage({required this.currentPage});
}

class OnboardingNormalPage extends OnboardingState {
  final int currentPage;
  OnboardingNormalPage({required this.currentPage});
}

class OnboardingFinished extends OnboardingState {}
