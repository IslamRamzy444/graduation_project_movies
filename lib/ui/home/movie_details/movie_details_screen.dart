import 'package:flutter/material.dart';
import 'package:graduation_project_movies/models/movie_suggestion_response.dart';
import 'package:graduation_project_movies/ui/home/movie_details/widgets/cast_section.dart';
import 'package:graduation_project_movies/ui/home/movie_details/widgets/movie_info_card.dart';
import 'package:graduation_project_movies/ui/home/movie_details/widgets/screen_shot_card.dart';
import 'package:graduation_project_movies/ui/home/movie_details/widgets/suggestion_card.dart';
import 'package:graduation_project_movies/ui/home/movie_details/widgets/watch_now_poster.dart';
import 'package:graduation_project_movies/ui/widgets/custom_Elevated_button.dart';
import 'package:graduation_project_movies/utils/app_colors.dart';
import 'package:graduation_project_movies/utils/app_routes.dart';
import 'package:graduation_project_movies/utils/app_styles.dart';

import '../../../api/api_manager.dart';
import '../../../models/movie_details_response.dart';
import '../../../utils/alert_dialog.dart';

class MovieDetailsScreen extends StatefulWidget {
  MovieDetailsScreen({super.key});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late int movieId;
  MovieDetailsResponse? movieDetails;
  MovieSuggestionResponse? movieSuggestionResponse;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      movieId = ModalRoute.of(context)!.settings.arguments as int;
      _loadMovieDetails();
      _loadSuggestionMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    // Show error state
    if (errorMessage != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Movie Details"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              SizedBox(height: 16),
              Text(
                "Error loading movie details",
                style: AppStyles.bold20WhiteRoboto,
              ),
              SizedBox(height: 8),
              Text(errorMessage!),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    errorMessage = null;
                  });
                  _loadMovieDetails();
                  _loadSuggestionMovies();
                },
                child: Text("Retry"),
              ),
            ],
          ),
        ),
      );
    }

    // Check for null movie data
    final movie = movieDetails?.data?.movie;
    final movieSuggestionsList = movieSuggestionResponse?.data?.movies;
    final String screenShot1 = movie?.mediumScreenshotImage1 ?? '';
    final String screenShot2 = movie?.mediumScreenshotImage2 ?? '';
    final String screenShot3 = movie?.mediumScreenshotImage3 ?? '';
    if (movie == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Movie Details",
            style: AppStyles.regular16PrimaryRoboto,
          ),
        ),
        body: Center(
          child: Text(
            "No movie data available",
            style: AppStyles.regular16PrimaryRoboto,
          ),
        ),
      );
    }

    print(
        "this is the movie title ${movie.title}\n this is the movie description ${movie.descriptionFull}\n this is cast ${movie.cast}");

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              WatchNowPoster(
                image: movie.largeCoverImage ?? '',
                title: movie.title ?? 'Unknown Title',
                year: movie.year?.toString() ?? 'Unknown Year',
                addFav: () {},
                navBack: () {
                  Navigator.pop(context);
                },
                play: () {
                  _watchMovie(movie.url);
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: CustomElevatedButton(
                  buttonText: "Watch",
                  buttonTextStyle: AppStyles.bold20WhiteRoboto,
                  borderColor: AppColors.redColor,
                  buttonColor: AppColors.redColor,
                  onPressed: () {
                    _watchMovie(movie.url);
                  },
                ),
              ),
              SizedBox(height: 0.01 * height),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MovieInfoCard(
                        iconData: Icons.favorite,
                        info: movie.likeCount?.toString() ?? "0"),
                    MovieInfoCard(
                        iconData: Icons.access_time_filled,
                        info: "${movie.runtime ?? 0} min"),
                    MovieInfoCard(
                        iconData: Icons.star,
                        info: movie.rating?.toStringAsFixed(1) ?? "N/A")
                  ],
                ),
              ),
              // Add more movie details section
              Padding(
                padding: EdgeInsets.all(width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (movieSuggestionsList != null &&
                        movieSuggestionsList.isNotEmpty) ...[
                      Text(
                        ' Similar',
                        style: AppStyles.bold24WhiteRoboto,
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacementNamed(
                                  AppRoutes.movieDetailsScreenRouteName,
                                  arguments: movieSuggestionsList[index].id);
                            },
                            child: SuggestionCard(
                              backgroundImageUrl:
                                  movieSuggestionsList[index].mediumCoverImage!,
                              rating: movieSuggestionsList[index].rating!,
                            ),
                          );
                        },
                        itemCount: movieSuggestionsList.length,
                      ),
                      SizedBox(height: 0.02 * height),
                      Text(
                        "Screen Shots",
                        style: AppStyles.bold24WhiteRoboto,
                      ),
                      SizedBox(
                        height: 0.02 * height,
                      ),
                      ScreenShotCard(imageUrl: screenShot1),
                      SizedBox(
                        height: 0.01 * height,
                      ),
                      ScreenShotCard(imageUrl: screenShot2),
                      SizedBox(
                        height: 0.01 * height,
                      ),
                      ScreenShotCard(imageUrl: screenShot3)
                    ],
                    if (movie.descriptionFull != null &&
                        movie.descriptionFull!.isNotEmpty) ...[
                      Text(
                        "Summary",
                        style: AppStyles.bold20WhiteRoboto,
                      ),
                      SizedBox(height: 8),
                      Text(
                        movie.descriptionFull!,
                        style: TextStyle(fontSize: 14, color: Colors.grey[300]),
                      ),
                      SizedBox(height: 16),
                    ],
                    if (movie.cast != null) CastSection(castList: movie.cast!),
                    const SizedBox(height: 16),
                    if (movie.genres != null && movie.genres!.isNotEmpty) ...[
                      Text(
                        "Genres",
                        style: AppStyles.bold20WhiteRoboto,
                      ),
                      SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: movie.genres!
                            .map((genre) => Chip(
                                  label: Text(
                                    genre,
                                    style: AppStyles.regular16WhiteRoboto,
                                  ),
                                  backgroundColor: AppColors.darkGreyColor,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: AppColors.transparentColor),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ))
                            .toList(),
                      ),
                      SizedBox(height: 16),
                    ],
                    // if (movie.cast != null && movie.cast!.isNotEmpty) ...[
                    //   Text(
                    //     "Cast",
                    //     style: AppStyles.bold20WhiteRoboto,
                    //   ),
                    //   SizedBox(height: 8),
                    //   //this is picture for cast
                    //   SizedBox(
                    //     height: 120,
                    //     child: ListView.builder(
                    //       scrollDirection: Axis.horizontal,
                    //       itemCount: movie.cast!.length,
                    //       itemBuilder: (context, index) {
                    //         final castMember = movie.cast![index];
                    //         return Container(
                    //           width: 80,
                    //           margin: EdgeInsets.only(right: 12),
                    //           child: Column(
                    //             children: [
                    //               CircleAvatar(
                    //                 radius: 30,
                    //                 backgroundImage:
                    //                     castMember.urlSmallImage != null
                    //                         ? NetworkImage(
                    //                             castMember.urlSmallImage!)
                    //                         : null,
                    //                 child: castMember.urlSmallImage == null
                    //                     ? Icon(Icons.person)
                    //                     : null,
                    //               ),
                    //               SizedBox(height: 8),
                    //               Text(
                    //                 castMember.name ?? 'Unknown',
                    //                 style: TextStyle(fontSize: 12),
                    //                 textAlign: TextAlign.center,
                    //                 maxLines: 2,
                    //                 overflow: TextOverflow.ellipsis,
                    //               ),
                    //             ],
                    //           ),
                    //         );
                    //       },
                    //     ),
                    //   ),
                    // ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _watchMovie(String? movieUrl) {
    if (movieUrl != null && movieUrl.isNotEmpty) {
      Navigator.pushNamed(context, AppRoutes.watchMovieScreenRouteName,
          arguments: movieUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Movie URL not available"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _loadMovieDetails() async {
    try {
      // Show loading dialog
      DialogUtils.showLoading(
          context: context, loadingText: "Loading movie details...");

      movieDetails = await ApiManager.getMovieDetails(movieId: movieId);

      // Hide loading dialog
      DialogUtils.hideLoading(context: context);

      setState(() {
        errorMessage = null;
      });
    } catch (e) {
      print("Error loading movie details: $e");

      // Hide loading dialog
      DialogUtils.hideLoading(context: context);

      setState(() {
        errorMessage = e.toString();
      });
    }
  }

  Future<void> _loadSuggestionMovies() async {
    try {
      // Show loading dialog
      movieSuggestionResponse =
          await ApiManager.getMovieSuggestion(movieId: movieId);

      setState(() {
        errorMessage = null;
      });
    } catch (e) {
      print("Error loading suggestion movies: $e");

      // Hide loading dialog
      DialogUtils.hideLoading(context: context);

      setState(() {
        errorMessage = e.toString();
      });
    }
  }
}
