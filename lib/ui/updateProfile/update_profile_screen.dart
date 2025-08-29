import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:graduation_project_movies/l10n/app_localizations.dart';
import 'package:graduation_project_movies/ui/updateProfile/buttom_sheet.dart';
import 'package:graduation_project_movies/ui/widgets/custom_Elevated_button.dart';
import 'package:graduation_project_movies/ui/widgets/custom_text_form_field.dart';
import 'package:graduation_project_movies/utils/app_assets.dart';
import 'package:graduation_project_movies/utils/app_colors.dart';

import '../../cubits/avatar_cubit/avatar_cubit.dart';
import '../../utils/app_styles.dart';

class UpdateProfileScreen extends StatelessWidget {
  UpdateProfileScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (BuildContext context) {
        return AvatarCubit();
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
                  SizedBox(
                    height: height * 0.02,
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        elevation: 50,
                        backgroundColor: AppColors.darkGreyColor,
                        //barrierColor: AppColors.darkGreyColor,
                        builder: (buttomSheetContext) {
                          return ButtomSheet(
                            avatarCubit: avatarCubit,
                          );
                        },
                      );
                    },
                    child: Container(
                        alignment: Alignment.center,
                        child: Image(
                            image: AssetImage(avatars[state.currentIndex]))),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomTextField(
                    controller: nameController,
                    prefixIcon: ImageIcon(
                      AssetImage(AppAssets.personIcon),
                      color: AppColors.whiteColor,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomTextField(
                    controller: phoneController,
                    prefixIcon: ImageIcon(
                      AssetImage(AppAssets.phoneIcon),
                      color: AppColors.whiteColor,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(
                    AppLocalizations.of(context)!.reset_password,
                    style: AppStyles.regular20White,
                  ),
                  Expanded(child: SizedBox()),
                  CustomElevatedButton(
                    buttonText: AppLocalizations.of(context)!.delete_account,
                    onPressed: () {},
                    buttonColor: AppColors.redColor,
                    borderColor: AppColors.redColor,
                    buttonTextStyle: AppStyles.regular20White,
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  CustomElevatedButton(
                    buttonText: AppLocalizations.of(context)!.update_data,
                    onPressed: () {},
                  ),
                  SizedBox(
                    height: height * 0.03,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
