import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_movies/l10n/app_localizations.dart';
import 'package:graduation_project_movies/ui/updateProfile/buttom_sheet.dart';
import 'package:graduation_project_movies/ui/widgets/custom_Elevated_button.dart';
import 'package:graduation_project_movies/ui/widgets/custom_text_form_field.dart';
import 'package:graduation_project_movies/utils/app_assets.dart';
import 'package:graduation_project_movies/utils/app_colors.dart';
import 'package:graduation_project_movies/models/user_response.dart';
import 'package:graduation_project_movies/utils/app_styles.dart';
import '../../cubits/avatar_cubit/avatar_cubit.dart';
import '../home/profile_screen/cubit/profile_view_model.dart';
import 'cubit/update_view_model.dart';

class UpdateProfileScreen extends StatefulWidget {
  final Data? userData;
  final String? token;
  final ProfileViewModel? profileViewModel;

  const UpdateProfileScreen({
    super.key,
    this.userData,
    this.token,
    this.profileViewModel,
  });

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;

  List<String> avatars = [
    AppAssets.avatar1,
    AppAssets.avatar2,
    AppAssets.avatar3,
    AppAssets.avatar4,
    AppAssets.avatar5,
    AppAssets.avatar6,
    AppAssets.avatar7,
    AppAssets.avatar8,
    AppAssets.avatar9
  ];

  late UpdateProfileViewModel viewModel;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.userData?.name ?? '');
    phoneController = TextEditingController(text: widget.userData?.phone ?? '');
    emailController = TextEditingController(text: widget.userData?.email ?? '');

    viewModel = UpdateProfileViewModel(
      context: context,
      token: widget.token,
      profileViewModel: widget.profileViewModel,
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (BuildContext context) {
        var cubit = AvatarCubit();
        if (widget.userData?.avaterId != null) {
          int avatarIndex =
          (widget.userData!.avaterId! - 1).clamp(0, avatars.length - 1);
          cubit.updateAvatar(avatarIndex);
        }
        return cubit;
      },
      child: BlocBuilder<AvatarCubit, AvatarState>(
        builder: (BuildContext context, state) {
          final avatarCubit = context.read<AvatarCubit>();

          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.transparentColor,
              title: Text(
                AppLocalizations.of(context)!.pick_avatar,
                style: AppStyles.regular16PrimaryRoboto,
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.02),

                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        elevation: 50,
                        backgroundColor: AppColors.darkGreyColor,
                        builder: (bottomSheetContext) {
                          return ButtomSheet(avatarCubit: avatarCubit);
                        },
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Image(
                        image: AssetImage(avatars[state.currentIndex]),
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.02),

                  CustomTextField(
                    controller: nameController,
                    prefixIcon: ImageIcon(
                      AssetImage(AppAssets.personIcon),
                      color: AppColors.whiteColor,
                    ),
                    hintText: AppLocalizations.of(context)!.name,
                    hintStyle: AppStyles.regular15WhiteRoboto,
                    labelStyle: AppStyles.regular16WhiteRoboto,
                  ),

                  SizedBox(height: height * 0.02),

                  CustomTextField(
                    controller: emailController,
                    prefixIcon: ImageIcon(
                      AssetImage(AppAssets.emailIcon),
                      color: AppColors.whiteColor,
                    ),
                    hintText: AppLocalizations.of(context)!.email,
                    hintStyle: AppStyles.regular15WhiteRoboto,
                    labelStyle: AppStyles.regular16WhiteRoboto,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  SizedBox(height: height * 0.02),

                  CustomTextField(
                    controller: phoneController,
                    prefixIcon: ImageIcon(
                      AssetImage(AppAssets.phoneIcon),
                      color: AppColors.whiteColor,
                    ),
                    hintText: AppLocalizations.of(context)!.phone,
                    hintStyle: AppStyles.regular15WhiteRoboto,
                    labelStyle: AppStyles.regular16WhiteRoboto,
                    keyboardType: TextInputType.phone,
                  ),

                  SizedBox(height: height * 0.02),

                  InkWell(
                    onTap: () {
                      // reset password
                    },
                    child: Text(
                      AppLocalizations.of(context)!.reset_password,
                      style: AppStyles.regular20White.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),

                  Expanded(child: SizedBox()),

                  CustomElevatedButton(
                    buttonText: AppLocalizations.of(context)!.delete_account,
                    onPressed: () {
                      viewModel.deleleteUser(widget.token!);
                    },
                    buttonColor: AppColors.redColor,
                    borderColor: AppColors.redColor,
                    buttonTextStyle: AppStyles.regular20White,
                  ),

                  SizedBox(height: height * 0.01),

                  CustomElevatedButton(
                    buttonText: AppLocalizations.of(context)!.update_data,
                    onPressed: () => viewModel.updateProfile(
                      avatarCubit: avatarCubit,
                      email: emailController.text.trim(),
                      name: nameController.text.trim(),
                      phone: phoneController.text.trim(),
                    ),
                  ),

                  SizedBox(height: height * 0.03),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
