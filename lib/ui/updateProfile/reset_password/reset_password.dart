import 'package:flutter/material.dart';
import 'package:graduation_project_movies/models/user_response.dart';
import 'package:graduation_project_movies/ui/home/profile_screen/cubit/profile_view_model.dart';
import 'package:graduation_project_movies/l10n/app_localizations.dart';
import 'package:graduation_project_movies/ui/updateProfile/cubit/update_view_model.dart';
import 'package:graduation_project_movies/ui/widgets/custom_Elevated_button.dart';
import 'package:graduation_project_movies/ui/widgets/custom_text_form_field.dart';
import 'package:graduation_project_movies/utils/app_assets.dart';
import 'package:graduation_project_movies/utils/app_colors.dart';
import 'package:graduation_project_movies/utils/app_styles.dart';

class ResetPassword extends StatefulWidget {
  final Data? userData;
  final String? token;
  final ProfileViewModel? profileViewModel;

  const ResetPassword(
      {super.key, this.userData, this.token, this.profileViewModel});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController reNewPasswordController = TextEditingController();
  late UpdateProfileViewModel viewModel;
  bool obscured1 = true;
  bool obscured2 = true;
  bool obscured3 = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel = UpdateProfileViewModel(
        context: context,
        profileViewModel: widget.profileViewModel,
        token: widget.token);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height=MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.reset_password,
          style: AppStyles.regular16PrimaryRoboto,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.04 * width),
          child: Column(
            children: [
              CircleAvatar(
                radius: 0.09 * width,
                child: Image.asset(
                    "assets/images/avatar_${widget.userData!.avaterId}.png"),
              ),
              SizedBox(height: 0.01*height,),
              Text(
                widget.userData?.name ?? "",
                style: AppStyles.regular15WhiteRoboto,
              ),
              SizedBox(height: 0.01*height,),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: oldPasswordController,
                        obscureText: obscured1,
                        prefixIcon: ImageIcon(
                          AssetImage(AppAssets.passwordIcon),
                          color: AppColors.whiteColor,
                        ),
                        hintText: AppLocalizations.of(context)!.password,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return AppLocalizations.of(context)!
                                .empty_password_error;
                          }
                          if (text.trim().length < 8) {
                            return AppLocalizations.of(context)!
                                .short_password_error;
                          }
                          return null;
                        },
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              obscured1 = !obscured1;
                            });
                          },
                          child: obscured1
                              ? Icon(Icons.visibility_off,
                                  color: AppColors.whiteColor)
                              : Icon(Icons.visibility,
                                  color: AppColors.whiteColor),
                        ),
                      ),
                      SizedBox(height: 0.02*height,),
                      CustomTextField(
                        controller: newPasswordController,
                        obscureText: obscured2,
                        prefixIcon: ImageIcon(
                          AssetImage(AppAssets.passwordIcon),
                          color: AppColors.whiteColor,
                        ),
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return AppLocalizations.of(context)!
                                .empty_password_error;
                          }
                          if (text.trim().length < 8) {
                            return AppLocalizations.of(context)!
                                .short_password_error;
                          }
                          return null;
                        },
                        hintText: "Enter your new password",
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              obscured2 = !obscured2;
                            });
                          },
                          child: obscured2
                              ? Icon(Icons.visibility_off,
                                  color: AppColors.whiteColor)
                              : Icon(Icons.visibility,
                                  color: AppColors.whiteColor),
                        ),
                      ),
                      SizedBox(height: 0.02*height,),
                      CustomTextField(
                        controller: reNewPasswordController,
                        obscureText: obscured3,
                        prefixIcon: ImageIcon(
                          AssetImage(AppAssets.passwordIcon),
                          color: AppColors.whiteColor,
                        ),
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return AppLocalizations.of(context)!
                                .empty_password_error;
                          }
                          if (text.trim().length < 8) {
                            return AppLocalizations.of(context)!
                                .short_password_error;
                          }
                          if (reNewPasswordController.text.trim() !=
                              text.trim()) {

                            return AppLocalizations.of(context)!
                                .mis_match_re_password;
                          }
                          return null;
                        },
                        hintText: "Re-Enter your new password",
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              obscured3 = !obscured3;
                            });
                          },
                          child: obscured3
                              ? Icon(Icons.visibility_off,
                                  color: AppColors.whiteColor)
                              : Icon(Icons.visibility,
                                  color: AppColors.whiteColor),
                        ),
                      ),
                      SizedBox(height: 0.02*height,),
                      CustomElevatedButton(
                        buttonText: AppLocalizations.of(context)!.reset_password, 
                        onPressed:  () {
                          resetPassword();
                        },
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
  void resetPassword(){
    if(_formKey.currentState?.validate()==true){
      viewModel.resetPassword(widget.token!, oldPasswordController.text, newPasswordController.text);
    }
  }
}
