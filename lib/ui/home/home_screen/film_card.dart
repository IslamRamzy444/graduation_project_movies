import 'package:flutter/material.dart';
import 'package:graduation_project_movies/utils/app_styles.dart';

import '../../../utils/app_colors.dart';
class FilmCard extends StatelessWidget {
  String image;
  double? rating;
  bool isCategory;
  FilmCard({super.key,required this.image, required this.rating,this.isCategory=false});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            image,
            fit: BoxFit.cover,
            width: isCategory?width*0.33:double.infinity,
            height: isCategory?width*0.43:double.infinity,
          ),
        ),
        Container(
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.symmetric(horizontal: width*0.03,vertical: height*0.005),
          padding: EdgeInsets.symmetric(horizontal: width*0.015,vertical: height*0.003),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.lightGreyColor
          ),
            child: Text("$rating ⭐",style: AppStyles.regular16WhiteRoboto,)
        )
      ],
    );
  }
}
