import 'package:flutter/material.dart';
import 'package:graduation_project_movies/models/movies_list_repsonse.dart';
import 'package:graduation_project_movies/ui/home/movie_details/widgets/movie_info_card.dart';
import 'package:graduation_project_movies/ui/home/movie_details/widgets/watch_now_poster.dart';
import 'package:graduation_project_movies/ui/widgets/custom_Elevated_button.dart';
import 'package:graduation_project_movies/utils/app_colors.dart';
import 'package:graduation_project_movies/utils/app_routes.dart';
import 'package:graduation_project_movies/utils/app_styles.dart';

class MovieDetailsScreen extends StatefulWidget {
  MovieDetailsScreen({super.key});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late Movies movie;

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.sizeOf(context).width;
    var height=MediaQuery.sizeOf(context).height;
    movie=ModalRoute.of(context)?.settings.arguments as Movies;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              WatchNowPoster(
                image: movie.mediumCoverImage!, 
                title: movie.title!, 
                year: movie.year.toString(),
                addFav: (){},
                navBack: () {
                  Navigator.pop(context);
                }, 
                play: (){
                  Navigator.pushNamed(context, AppRoutes.watchMovieScreenRouteName,arguments: movie.url);
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width*0.04),
                child: CustomElevatedButton(
                  buttonText: "Watch",
                  buttonTextStyle: AppStyles.bold20WhiteRoboto,
                  borderColor: AppColors.redColor,
                  buttonColor: AppColors.redColor, 
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.watchMovieScreenRouteName,arguments: movie.url);
                  },
                ),
              ),
              SizedBox(height: 0.01*height,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width*0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MovieInfoCard(iconData: Icons.favorite, info: "15"),
                    MovieInfoCard(iconData: Icons.access_time_filled, info: movie.runtime.toString()),
                    MovieInfoCard(iconData: Icons.star, info: movie.rating.toString())
                  ],
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}