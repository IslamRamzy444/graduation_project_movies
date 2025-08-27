import 'package:flutter/material.dart';
import 'package:graduation_project_movies/ui/home/profile_screen/history_tab.dart';
import 'package:graduation_project_movies/ui/home/profile_screen/watch_list_tab.dart';
import 'package:graduation_project_movies/ui/widgets/custom_Elevated_button.dart';
import 'package:graduation_project_movies/utils/app_assets.dart';
import 'package:graduation_project_movies/utils/app_colors.dart';
import 'package:graduation_project_movies/utils/app_styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.06, vertical: height * 0.02),
              child: Row(children: [
                Column(
                  children: [
                    Image.asset(AppAssets.avatar8,
                        height: height * 0.13, width: height * 0.13),
                    SizedBox(height: height * 0.01),
                    Text(
                      "John Safwat",
                      style: AppStyles.bold20WhiteRoboto,
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.06, vertical: height * 0.09),
                  child: Column(
                    children: [
                      Text(
                        "12",
                        style: AppStyles.bold24White,
                      ),
                      SizedBox(height: height * 0.03),
                      Text(
                        "Wish List",
                        style: AppStyles.bold24White,
                      )
                    ],
                  ),
                ),
                Spacer(),
                Column(
                  children: [
                    Text(
                      "10",
                      style: AppStyles.bold24White,
                    ),
                    SizedBox(height: height * 0.03),
                    Text(
                      "History",
                      style: AppStyles.bold24White,
                    )
                  ],
                ),
              ]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.03, vertical: height * 0.01),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CustomElevatedButton(
                      buttonText: "Edit Profile",
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: width * 0.02),
                  Expanded(
                    flex: 1,
                    child: CustomElevatedButton(
                      buttonText: "Exit",
                      onPressed: () {},
                      buttonColor: AppColors.redColor,
                      borderColor: AppColors.redColor,
                      rowMainAxesAlignment: MainAxisAlignment.center,
                      trailingIcon: Image.asset(
                        AppAssets.exitIcon,
                      ),
                      buttonTextStyle: AppStyles.regular20White,
                    ),
                  ),
                ],
              ),
            ),
            TabBar(
              indicatorColor: AppColors.primaryColor,
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelColor: AppColors.whiteColor,
              labelColor: AppColors.whiteColor,
              dividerColor: Colors.black,
              dividerHeight: 1,
              labelStyle: AppStyles.regular20WhiteRoboto,
              tabs: [
                Tab(
                  icon: Image.asset(AppAssets.watchIcon, height: 28, width: 28),
                  text: "Watch List",
                ),
                Tab(
                  icon:
                      Image.asset(AppAssets.historyIcon, height: 28, width: 28),
                  text: "History",
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  WatchListTab(),
                  HistoryTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
