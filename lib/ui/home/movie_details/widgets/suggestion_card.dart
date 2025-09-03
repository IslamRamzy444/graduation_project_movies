import 'package:flutter/material.dart';
import 'package:graduation_project_movies/utils/app_colors.dart';
import 'package:graduation_project_movies/utils/app_styles.dart';

class SuggestionCard extends StatelessWidget {
  String backgroundImageUrl;
  double rating;

  SuggestionCard(
      {super.key, required this.backgroundImageUrl, required this.rating});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.all(width * 0.02),
      padding: EdgeInsets.all(width * 0.02),
      alignment: Alignment.topLeft,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width * 0.04),
          image: DecorationImage(
              image: NetworkImage(backgroundImageUrl), fit: BoxFit.fill)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width * 0.02),
            color: Color(0xb5121312).withValues(alpha: 0.71)),
        child: SizedBox(
          width: width * 0.15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$rating',
                style: AppStyles.regular16WhiteRoboto,
              ),
              SizedBox(
                width: width * 0.01,
              ),
              Icon(
                Icons.star,
                color: AppColors.primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
