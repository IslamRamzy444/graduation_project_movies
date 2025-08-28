import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_movies/api/api_manager.dart';
import 'package:graduation_project_movies/ui/auth/register/cubit/register_navigator.dart';
import 'package:graduation_project_movies/ui/auth/register/cubit/user_states.dart';

class RegisterViewModel extends Cubit<UserStates> {
  late RegisterNavigator navigator;

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var rePasswordController = TextEditingController();
  var phoneController = TextEditingController();

  int avatarId = 1;

  RegisterViewModel() : super(UserLoadingState());

  void register() async {
    if (formKey.currentState?.validate() == true) {
      emit(UserLoadingState());
      navigator.showLoading("Loading...");

      try {
        var response = await ApiManager.registerWithApi(
          nameController.text,
          emailController.text,
          passwordController.text,
          rePasswordController.text,
          phoneController.text,
          avatarId,
        );

        navigator.hideLoading();

        if (response?.statusCode == 400 || response?.data == null) {
          emit(UserErrorState(errorMessage: response!.message!));
          navigator.showMessage(response.message ?? "Registration failed",
              title: "Error");
        } else {
          emit(UserSuccessState(
              successMessage: response!.message!, userData: response.data!));
          navigator.showSuccessDialog(response.message ?? "Success", () {
            navigator.navigateToHomeScreen();
          });
        }
      } catch (e) {
        navigator.hideLoading();
        emit(UserErrorState(errorMessage: e.toString()));
        navigator.showMessage("Something went wrong", title: "Error");
      }
    }
  }
}
