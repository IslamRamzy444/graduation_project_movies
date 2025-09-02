import 'package:flutter/material.dart';
import 'package:graduation_project_movies/utils/app_assets.dart';
import 'package:graduation_project_movies/utils/app_colors.dart';
import 'package:graduation_project_movies/utils/app_styles.dart';

class WatchNowPoster extends StatelessWidget {
  String image;
  String title;
  String year;
  VoidCallback play;
  VoidCallback navBack;
  VoidCallback addFav;
  WatchNowPoster({
    super.key,
    required this.image,
    required this.title,
    required this.year,
    required this.play,
    required this.navBack,
    required this.addFav
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return Container(
      width: double.infinity,
      height: 0.45 * height,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                image,
              ),
              fit: BoxFit.cover)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [AppColors.shadedBlackColor, AppColors.blackColor],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            width: double.infinity,
          ),
          Positioned(
            top: 0.01 * height,
            left: 0.02 * width,
            right: 0.02 * width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      navBack();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.whiteColor,
                    )),
                IconButton(
                    onPressed: () {
                      addFav();
                    },
                    icon: Icon(
                      Icons.bookmark,
                      color: AppColors.whiteColor,
                    ))
              ],
            ),
          ),
          InkWell(
            onTap: () {
              play();
            },
            child: Image.asset(
              AppAssets.playIcon,
              height: 0.084 * height,
            ),
          ),
          Positioned(
            bottom: 0.02 * height,
            left: 0.1 * width,
            child: Container(
              width: 0.8 * width,
              child: Column(
                children: [
                  Expanded(
                      child: Text(title, style: AppStyles.bold24WhiteRoboto)),
                  Text(
                    year,
                    style: AppStyles.bold20GreyRoboto,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
