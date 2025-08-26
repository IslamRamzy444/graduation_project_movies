import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_movies/data/repos/Movies/repos/movies_repo.dart';
import 'package:graduation_project_movies/data/repos/Movies/repos/movies_repo_impl.dart';
import 'package:graduation_project_movies/di/di.dart';
import 'package:graduation_project_movies/models/dummy_class.dart';
import 'package:graduation_project_movies/ui/home/home_screen/cubit/movies_states.dart';
import 'package:graduation_project_movies/ui/home/home_screen/cubit/movies_view_model.dart';
import 'package:graduation_project_movies/ui/home/home_screen/film_card.dart';
import 'package:graduation_project_movies/utils/app_assets.dart';
import 'package:graduation_project_movies/utils/app_colors.dart';
import 'package:graduation_project_movies/utils/app_routes.dart';
import 'package:graduation_project_movies/utils/app_styles.dart';

class HomeScreen extends StatefulWidget {
  MoviesRepo moviesRepo;

  HomeScreen({super.key, required this.moviesRepo});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    widget.moviesRepo =
        MoviesRepoImpl(moviesDataSource: injectMoviesDataSource());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.movieImage),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.dstOut,
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: BlocBuilder<MoviesViewModel, MoviesState>(
              bloc: MoviesViewModel(moviesRepo: injectMovieRepository())
                ..getAllMovies(),
              builder: (context, state) {
                if (state is MoviesSuccess) {
                  return Column(
                    children: [
                      Container(
                        width: width,
                        height: height * 0.68,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(AppAssets.availableNowImage),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, AppRoutes.movieDetailsRouteName);
                              },
                              child: CarouselSlider(
                                options: CarouselOptions(
                                    height: 400.0,
                                    enlargeCenterPage: true,
                                    viewportFraction: 0.6),
                                //her i used the list of dummy data we will use the api to get the data
                                //and acsess the image of the movie and the rating of it
                                items: state.moviesList?.map((i) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          //this card i created it to show the image of the film and the rating of it
                                          return FilmCard(
                                            image: i.mediumCoverImage ??
                                                AppAssets.movieImage,
                                            rating: i.rating ?? 0.0,
                                          );
                                        },
                                      );
                                    }).toList() ??
                                    [],
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(AppAssets.watchNowImage),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Category",
                                  style: AppStyles.regular20White,
                                ),
                                InkWell(
                                    onTap: () {
                                      ///to do will navigate to screen of all category
                                    },
                                    child: Text(
                                      "See More→",
                                      style: AppStyles.regular16PrimaryRoboto,
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            SizedBox(
                              height: height * 0.25,
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  // Check if the movie exists and has valid data
                                  if (state.moviesList != null &&
                                      index < state.moviesList!.length &&
                                      state.moviesList![index]
                                              .mediumCoverImage !=
                                          null) {
                                    return FilmCard(
                                      isCategory:true,
                                      image: state
                                          .moviesList![index].mediumCoverImage!,
                                      rating: state.moviesList![index].rating,
                                    );
                                  } else {
                                    // Return a placeholder card if data is missing
                                    return FilmCard(
                                      image: AppAssets.movieImage,
                                      rating: 0.0,
                                    );
                                  }
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    width: width * 0.03,
                                  );
                                },
                                itemCount: state.moviesList?.length ?? 0,
                                scrollDirection: Axis.horizontal,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                } else if (state is MoviesFailure) {
                  return Center(
                    child: Text(
                      state.errorMessage,
                      style: AppStyles.regular20White,
                    ),
                  );
                } else {
                  return Center(
                      child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ));
                }
              }),
        ),
      ),
    );
  }
}
