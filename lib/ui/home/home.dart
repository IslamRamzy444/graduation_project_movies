import 'package:flutter/material.dart';

import 'package:graduation_project_movies/ui/home/home_screen/home_Screen.dart';
import 'package:graduation_project_movies/ui/home/profile_screen/profile_screen.dart';
import 'package:graduation_project_movies/ui/home/search_screen/search_screen.dart';
import 'package:graduation_project_movies/utils/app_assets.dart';
import 'package:graduation_project_movies/utils/app_colors.dart';

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
      backgroundColor: AppColors.darkGreyColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: screens[currentIndex],
          ),

          Positioned(
            bottom: height*0.03,
            left: width * 0.08,
            right: width * 0.08,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: width*0.02, vertical: height*0.015),
              decoration: BoxDecoration(
                color: AppColors.darkGreyColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildNavItem(icon: AppAssets.homeIcon, index: 0),
                  buildNavItem(icon: AppAssets.searchIcon, index: 1),
                  buildNavItem(icon: AppAssets.browseIcon, index: 2),
                  buildNavItem(icon: AppAssets.profileIcon, index: 3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNavItem({required String icon, required int index}) {
    bool isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageIcon(
            AssetImage(icon),
            color: isSelected ? AppColors.primaryColor : AppColors.whiteColor,
            size: 26,
          ),
          const SizedBox(height: 4),
          Container(
            height: 4,
            width: 4,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryColor : Colors.transparent,
              shape: BoxShape.circle,
            ),
          )
        ],
      ),
    );
  }
}