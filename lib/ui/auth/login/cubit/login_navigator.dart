abstract class LoginNavigator {
  void showLoading(String loadingText);

  void hideLoading();

  void showMessage(String message);

  void showSuccessDialog(String message, Function onclick);

  void navigateToHomeScreen();
}
