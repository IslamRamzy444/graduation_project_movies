import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_movies/ui/auth/login/cubit/login_navigator.dart';
import 'package:graduation_project_movies/ui/auth/login/cubit/login_states.dart';

import '../../../../api/api_manager.dart';

class LoginViewModel extends Cubit<LoginStates> {
  var emailController = TextEditingController(text: 'amr2@gmail.com');
  var passwordController = TextEditingController(text: 'Amr2510@');

  LoginViewModel() : super(LoginLoadingState());
  late LoginNavigator navigator;
  var formKey = GlobalKey<FormState>();

  void login() async {
    if (formKey.currentState?.validate() == true) {
      emit(LoginLoadingState());
      try {
        final response = await ApiManager().login(
          emailController.text,
          passwordController.text,
        );
        if (response != null && response.data != null) {
          emit(LoginSuccessState(successMessage: response));
        } else {
          emit(LoginErrorState(errorMessage: "Invalid email or password"));
          navigator.hideLoading();
        }
      } catch (e) {
        navigator.hideLoading();
        emit(LoginErrorState(errorMessage: "Something went wrong"));
        navigator.showMessage("Something went wrong");
      }
    }
  }
}
