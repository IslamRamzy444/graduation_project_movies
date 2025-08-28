abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginErrorState extends LoginStates {
  String error;

  LoginErrorState({required this.error});
}

class LoginSuccessState extends LoginStates {}
