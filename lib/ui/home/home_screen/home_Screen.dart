import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_movies/ui/home/home_screen/category_item.dart';
import 'package:graduation_project_movies/ui/home/home_screen/cubit/movies_states.dart';
import 'package:graduation_project_movies/ui/home/home_screen/cubit/movies_view_model.dart';
import 'package:graduation_project_movies/ui/home/home_screen/film_card.dart';
import 'package:graduation_project_movies/utils/app_assets.dart';
import 'package:graduation_project_movies/utils/app_colors.dart';
import 'package:graduation_project_movies/utils/app_routes.dart';
import 'package:graduation_project_movies/utils/app_styles.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late final MoviesViewModel _moviesViewModel;

  @override
  void initState() {
    super.initState();
    _moviesViewModel = MoviesViewModel()..getAllMovies();
  }

  @override
  void dispose() {
    _moviesViewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    
    return Scaffold(
      body: BlocBuilder<MoviesViewModel, MoviesState>(
        bloc: _moviesViewModel,
        builder: (context, state) {
          if (state is MoviesSuccess) {
            final movies = state.moviesList ?? [];
            final bgIndex = _currentIndex < movies.length ? _currentIndex : 0;
            final ImageProvider bgImage = movies.isNotEmpty
                ? NetworkImage(movies[bgIndex].mediumCoverImage!)
                : AssetImage(AppAssets.movieImage);
            return Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: bgImage,
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5),
                          BlendMode.dstOut,
                        ),
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          width: width,
                          height: height * 0.68,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(AppAssets.availableNowImage),
                              CarouselSlider(
                                options: CarouselOptions(
                                    height: 400.0,
                                    enlargeCenterPage: true,
                                    viewportFraction: 0.6,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _currentIndex = index;
                                      });
                                    }),
                                items: state.moviesList?.map((i) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(context, AppRoutes.movieDetailsScreenRouteName,arguments: i);
                                        },
                                        child: FilmCard(
                                          image: i.mediumCoverImage!,
                                          rating: i.rating,
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                              Expanded(
                                  child: Image.asset(AppAssets.watchNowImage)),
                            ],
                          ),
                        ),
                        CategoryItem(
                          
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          } else if (state is MoviesFailure) {
            return SafeArea(
                child: Center(
              child: Text(
                state.errorMessage,
                style: AppStyles.regular20White,
              ),
            ));
          } else {
            return SafeArea(
                child: Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            ));
          }
        },
      ),
    );
  }
}
