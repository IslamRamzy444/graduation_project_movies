import 'package:flutter/material.dart';
import 'package:graduation_project_movies/ui/home/home_screen/film_card.dart';
import 'package:graduation_project_movies/ui/widgets/custom_text_form_field.dart';
import 'package:graduation_project_movies/utils/app_assets.dart';
import 'package:graduation_project_movies/utils/app_colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: CustomTextField(
          controller: TextEditingController(),
          prefixIcon: Image.asset(AppAssets.searchIcon),
          hintText: "Search",
          filledColor: AppColors.darkGreyColor,
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
              rating: 4.5,
            );
          },
        ),
      ),
    );
  }
}
