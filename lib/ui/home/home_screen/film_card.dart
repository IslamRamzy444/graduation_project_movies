import 'package:flutter/material.dart';
import 'package:graduation_project_movies/utils/app_styles.dart';

import '../../../utils/app_colors.dart';
class FilmCard extends StatelessWidget {
  String image;
  String rating;
  FilmCard({super.key,required this.image, required this.rating});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Image.asset(image),
        Container(
          margin: EdgeInsets.symmetric(horizontal: width*0.03,vertical: height*0.005),
          padding: EdgeInsets.symmetric(horizontal: width*0.015,vertical: height*0.003),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.lightGreyColor
          ),
            child: Text("$rating ⭐",style: AppStyles.regular16WhiteRoboto,)
        )
      ],
    );
  }
}
