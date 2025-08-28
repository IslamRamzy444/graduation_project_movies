import 'package:flutter/material.dart';
import 'package:graduation_project_movies/l10n/app_localizations.dart';
import 'package:graduation_project_movies/models/dummy_class.dart';
import 'package:graduation_project_movies/ui/home/profile_screen/profile_screen_tab.dart';
import 'package:graduation_project_movies/ui/widgets/custom_Elevated_button.dart';
import 'package:graduation_project_movies/utils/app_assets.dart';
import 'package:graduation_project_movies/utils/app_colors.dart';

import '../../../utils/app_styles.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool watchHistory = true;

  //this class will be filled with the history and watch list then from the api
  List<DummyClass> movieList = [];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
            color: AppColors.darkGreyColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //this will change to network image to load the image that the user used it when creating the account
                    Image.asset(
                      AppAssets.avatar1,
                      scale: 0.8,
                    ),
                    Column(
                      children: [
                        Text(
                          "12",
                          style: AppStyles.bold36White,
                        ),
                        Text(
                          AppLocalizations.of(context)!.wish_list,
                          style: AppStyles.bold24White,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text("12", style: AppStyles.bold36White),
                        Text(
                          AppLocalizations.of(context)!.history,
                          style: AppStyles.bold24White,
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                //here we will add the name of the user
                Text(
                  "user_name",
                  style: AppStyles.bold20White,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomElevatedButton(
                      buttonText: AppLocalizations.of(context)!.edit_profile,
                      onPressed: () {},
                      size: Size(width * 0.64, height * 0.07),
                    ),
                    CustomElevatedButton(
                      buttonText: AppLocalizations.of(context)!.exit,
                      buttonTextStyle: AppStyles.regular20White,
                      onPressed: () {},
                      size: Size(width * 0.26, height * 0.07),
                      buttonColor: AppColors.redColor,
                      borderColor: AppColors.redColor,
                      suffixIcon: ImageIcon(AssetImage(AppAssets.exitIcon),
                          color: AppColors.whiteColor),
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProfileScreenTab(
                      icon: AppAssets.watchListIcon,
                      onTap: () {
                        watchHistory = !watchHistory;
                        setState(() {});
                      },
                      text: AppLocalizations.of(context)!.watch_list,
                      isSelected: watchHistory,
                    ),
                    ProfileScreenTab(
                      icon: AppAssets.historyIcon,
                      onTap: () {
                        watchHistory = !watchHistory;
                        setState(() {});
                      },
                      text: AppLocalizations.of(context)!.history,
                      isSelected: !watchHistory,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: movieList.isEmpty
                ? Image.asset(AppAssets.emptyIcon)
                : ListView.builder(
              itemBuilder: (context, index) {
                return null;
              },
              itemCount: movieList.length,
            ),
          )
        ],
      )),
    );
  }
}
