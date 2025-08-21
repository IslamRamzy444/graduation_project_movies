import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_movies/utils/app_assets.dart';
import 'package:graduation_project_movies/utils/app_colors.dart';

import '../../cubits/avatar_cubit/avatar_cubit.dart';

class ButtomSheet extends StatelessWidget {
  AvatarCubit avatarCubit;

  ButtomSheet({super.key, required this.avatarCubit});

  final List<String> avatars = [
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
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height * 0.4,
      child: BlocProvider.value(
        value: avatarCubit,
        child: BlocBuilder<AvatarCubit, AvatarState>(
          builder: (context, state) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: avatars.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    context.read<AvatarCubit>().updateAvatar(index);
                  },
                  child: Container(
                    margin: EdgeInsets.all(width * 0.03),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.primaryColor),
                      color: state.currentIndex == index
                          ? AppColors.primaryColorLight
                          : AppColors.darkGreyColor,
                    ),
                    child: Image.asset(avatars[index]),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
