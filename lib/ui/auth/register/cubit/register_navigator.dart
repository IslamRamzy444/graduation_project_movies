abstract class RegisterNavigator {
  void showLoading(String loadingText);

  void hideLoading();

  void showMessage(String message, {String? title});

  void showSuccessDialog(String message, Function onClick);

  void navigateToHomeScreen();

  void navigateToLoginScreen();
}
