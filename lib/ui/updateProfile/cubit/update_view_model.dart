import 'package:flutter/material.dart';
import 'package:graduation_project_movies/api/api_manager.dart';
import 'package:graduation_project_movies/utils/alert_dialog.dart';
import 'package:graduation_project_movies/l10n/app_localizations.dart';
import 'package:graduation_project_movies/utils/app_routes.dart';
import '../../../cubits/avatar_cubit/avatar_cubit.dart';
import '../../home/profile_screen/cubit/profile_view_model.dart';

class UpdateProfileViewModel {
  final BuildContext? context;
  final String? token;
  final ProfileViewModel? profileViewModel;

  UpdateProfileViewModel({
    this.context,
    this.token,
    this.profileViewModel,
  });

  void showLoading(String loadingText) {
    DialogUtils.showLoading(context: context!, loadingText: loadingText);
  }

  void hideLoading() {
    DialogUtils.hideLoading(context: context!);
  }

  void showMessage(String message) {
    DialogUtils.showMessage(
      context: context!,
      message: message,
      postActionName: AppLocalizations.of(context!)!.ok,
    );
  }

  void showSuccessDialog(String message, Function onclick) {
    DialogUtils.showMessage(
      context: context!,
      message: message,
      postActionName: AppLocalizations.of(context!)!.ok,
      posAction: onclick,
    );
  }

  Future<void> updateProfile({
    required AvatarCubit avatarCubit,
    required String email,
    required String name,
    required String phone,
  }) async {
    if (token!.isEmpty) {
      showMessage('No authentication token found');
      return;
    }

    showLoading(AppLocalizations.of(context!)!.updating_profile);

    try {
      int avatarId = avatarCubit.state.currentIndex + 1;

      await ApiManager.updateProfileData(
        token!,
        email.isNotEmpty ? email : null,
        name.isNotEmpty ? name : null,
        phone.isNotEmpty ? phone : null,
        avatarId,
      );

      hideLoading();

      // Refresh profile if needed
      profileViewModel?.getProfile(token!);

      showSuccessDialog(
        AppLocalizations.of(context!)!.profile_updated_successfully,
            () => Navigator.of(context!).pop(),
      );
    } catch (e) {
      hideLoading();
      showMessage('Error: ${e.toString()}');
    }
  }
  void deleleteUser(String credential) async{
    showLoading(AppLocalizations.of(context!)!.loading);
    try{
      var response=await ApiManager.deleteUser(credential);
      hideLoading();
      showSuccessDialog(
        response!.message!, 
       ()=>Navigator.pushReplacementNamed(context!, AppRoutes.loginScreenRouteName)
      );
    }catch(e){
      hideLoading();
      showMessage(e.toString());
    }
  }
}
