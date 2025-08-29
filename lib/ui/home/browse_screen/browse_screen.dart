import 'package:flutter/material.dart';

import 'package:graduation_project_movies/ui/home/home_screen/film_card.dart';
import 'package:graduation_project_movies/utils/app_assets.dart';
import 'package:graduation_project_movies/utils/app_colors.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  int selectedIndex = 0;

  final List<String> categories = [
    "Action",
    "Adventure",
    "Animation",
    "Comedy",
    "Drama",
    "Romance",
  ];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.01, vertical: height * 0.02),
          child: SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final isSelected = selectedIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.04, vertical: height * 0.01),
                    constraints: const BoxConstraints(minHeight: 40),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.blackColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.primaryColor),
                    ),
                    child: Text(
                      categories[index],
                      style: TextStyle(
                          color: isSelected
                              ? AppColors.blackColor
                              : AppColors.primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.04, vertical: height * 0.02),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 12,
            childAspectRatio: 0.7,
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            return FilmCard(
              image: AppAssets.movieImage,
              rating: "4.5",
            );
          },
        ),
      ),
    );
  }
}
