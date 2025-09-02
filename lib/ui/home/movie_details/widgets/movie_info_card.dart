import 'package:flutter/material.dart';
import 'package:graduation_project_movies/utils/app_colors.dart';
import 'package:graduation_project_movies/utils/app_styles.dart';

class MovieInfoCard extends StatelessWidget {
  IconData iconData;
  String info;
  MovieInfoCard({super.key,required this.iconData,required this.info});

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.sizeOf(context).width;
    var height=MediaQuery.sizeOf(context).height;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.04*width,vertical: 0.01*height),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.darkGreyColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(iconData,color: AppColors.primaryColor,),
          Text(info,style: AppStyles.bold24WhiteRoboto,)
        ],
      ),
  );
  }
}