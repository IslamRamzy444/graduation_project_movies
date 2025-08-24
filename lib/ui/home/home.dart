import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_movies/ui/home/home_screen/home_Screen.dart';
import 'package:graduation_project_movies/ui/home/profile_screen/profile_screen.dart';
import 'package:graduation_project_movies/ui/home/search_screen/search_screen.dart';
import 'package:graduation_project_movies/utils/app_assets.dart';

import '../../utils/app_colors.dart';
import 'browse_screen/browse_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    SearchScreen(),
    BrowseScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBody: false,
      bottomNavigationBar: SizedBox(
        height: height*0.127,
        child: FloatingNavbar(
          selectedItemColor: AppColors.primaryColor,
          backgroundColor: AppColors.darkGreyColor,
          selectedBackgroundColor: AppColors.transparentColor,
          onTap: (int val) {
            currentIndex = val;
            setState(() {});
            //returns tab id which is user tapped
          },
          currentIndex: currentIndex,
          items: [
            floatingNavbarItem(
                icon: AppAssets.homeIcon,
                color: currentIndex == 0
                    ? AppColors.primaryColor
                    : AppColors.whiteColor
            ),
            floatingNavbarItem(
                icon: AppAssets.searchIcon,
                color: currentIndex == 1
                    ? AppColors.primaryColor
                    : AppColors.whiteColor
            ),
            floatingNavbarItem(
                icon: AppAssets.browseIcon,
                color: currentIndex == 2
                    ? AppColors.primaryColor
                    : AppColors.whiteColor
            ),
            floatingNavbarItem(
                icon: AppAssets.profileIcon,
                color: currentIndex == 3
                    ? AppColors.primaryColor
                    : AppColors.whiteColor
            ),
          ],
        ),
      ),
      //bottomNavigationBar:
      body:  Column(
        children: [
          Expanded(
            child: screens[currentIndex],
          ),
        ],
      ),
    );
  }

  FloatingNavbarItem floatingNavbarItem(
      {required String icon, required Color color}) {
    return FloatingNavbarItem(
        customWidget: ImageIcon(
      AssetImage(
        icon,
      ),
      color: color,
    ));
  }
}
