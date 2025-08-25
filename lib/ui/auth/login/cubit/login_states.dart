import 'package:graduation_project_movies/models/login_response.dart';

abstract class LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginErrorState extends LoginStates {
  String errorMessage;

  LoginErrorState({required this.errorMessage});
}

class LoginSuccessState extends LoginStates {
  LoginResponse successMessage;

  LoginSuccessState({required this.successMessage});
}
