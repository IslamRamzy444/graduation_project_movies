import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_movies/ui/home/home_screen/fake_film_card.dart';
import 'package:graduation_project_movies/ui/home/home_screen/film_card.dart';
import 'package:graduation_project_movies/ui/home/search_screen/cubit/search_states.dart';
import 'package:graduation_project_movies/ui/home/search_screen/search_screen_view_model.dart';
import 'package:graduation_project_movies/ui/widgets/custom_text_form_field.dart';
import 'package:graduation_project_movies/utils/app_assets.dart';
import 'package:graduation_project_movies/utils/app_colors.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  late SearchViewModel searchViewModel;

  @override
  void initState() {
    super.initState();
    searchViewModel = SearchViewModel();
  }

  @override
  void dispose() {
    searchController.dispose();
    searchViewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => searchViewModel,
      child: Scaffold(
        appBar: AppBar(
          title: CustomTextField(
            controller: searchController,
            prefixIcon: Image.asset(AppAssets.searchIcon),
            hintText: "Search",
            filledColor: AppColors.darkGreyColor,
            onChanged: (value) {
              searchViewModel.searchMovies(value);
            },
          ),
        ),
        body: BlocBuilder<SearchViewModel, SearchState>(
          builder: (context, state) {
            if (state is SearchInitial) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppAssets.searchIcon, width: 80, height: 80),
                    SizedBox(height: 16),
                    Text(
                      "Search for movies",
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is SearchLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.whiteColor,
                ),
              );
            } else if (state is SearchSuccess) {
              if (state.moviesList == null || state.moviesList!.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppAssets.emptyIcon, width: 80, height: 80),
                      SizedBox(height: 16),
                      Text(
                        "No movies found",
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04, vertical: height * 0.02),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: state.moviesList!.length,
                  itemBuilder: (context, index) {
                    final movie = state.moviesList![index];
                    return FilmCard(
                      image: movie.mediumCoverImage ?? AppAssets.movieImage,
                      rating: movie.rating ?? 0.0,
                    );
                  },
                ),
              );
            } else if (state is SearchFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: AppColors.whiteColor,
                      size: 80,
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Error: ${state.errorMessage}",
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        searchViewModel.searchMovies(searchController.text);
                      },
                      child: Text("Retry"),
                    ),
                  ],
                ),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
