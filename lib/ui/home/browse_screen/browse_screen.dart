import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_movies/ui/home/home_screen/film_card.dart';
import 'package:graduation_project_movies/utils/app_assets.dart';
import 'package:graduation_project_movies/utils/app_colors.dart';
import '../../../utils/app_routes.dart';
import 'cubit/browse_cubit.dart';
import 'cubit/browse_states.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  int selectedIndex = 0;

  final List<String> categories = [
    "Action", "Adventure", "Animation", "Biography", "Comedy", "Crime",
    "Documentary", "Drama", "Family", "Fantasy", "Film-Noir", "Game-Show",
    "History", "Horror", "Music", "Musical", "Mystery", "News", "Reality-TV",
    "Romance", "Sci-Fi", "Sport", "Talk-Show", "Thriller", "War", "Western",
  ];

  late ScrollController _scrollController;
  late BrowseCubit _browseCubit;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _browseCubit = BrowseCubit();

    // Add scroll listener with better threshold detection
    _scrollController.addListener(_onScroll);

    // Load initial data
    _browseCubit.fetchMoviesByCategory(categories[0]);
  }

  void _onScroll() {
    // Check if we're near the bottom of the scroll
    if (_scrollController.hasClients) {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;

      // Trigger load more when 80% scrolled
      if (currentScroll >= maxScroll * 0.8) {
        _browseCubit.loadMore();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _browseCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return BlocProvider.value(
      value: _browseCubit,
      child: BlocBuilder<BrowseCubit, BrowseState>(
        builder: (context, state) {
          if (state is BrowseSuccess) {
            selectedIndex = categories.indexOf(state.genre);
          }

          return Scaffold(
            appBar: AppBar(
              title: SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final isSelected = index == selectedIndex;
                    return GestureDetector(
                      onTap: () {
                        // Reset scroll position when changing category
                        if (_scrollController.hasClients) {
                          _scrollController.animateTo(
                            0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        }
                        _browseCubit.fetchMoviesByCategory(categories[index]);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.04, vertical: height * 0.01),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryColor
                              : AppColors.blackColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.primaryColor),
                        ),
                        child: Text(
                          categories[index],
                          style: TextStyle(
                            color: isSelected
                                ? AppColors.blackColor
                                : AppColors.primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04, vertical: height * 0.02),
              child: Builder(
                builder: (context) {
                  if (state is BrowseLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    );
                  } else if (state is BrowseFailure) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.errorMessage,
                            style: TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              _browseCubit.fetchMoviesByCategory(categories[0]);
                            },
                            child: const Text("Retry"),
                          ),
                        ],
                      ),
                    );
                  } else if (state is BrowseSuccess) {
                    return Column(
                      children: [
                        Expanded(
                          child: GridView.builder(
                            controller: _scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.7,
                            ),
                            itemCount: state.movies.length + (state.hasMore ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == state.movies.length) {
                                // Show loading indicator at the end
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }

                              final movie = state.movies[index];
                              return InkWell(
                                onTap: (){
                                  //navigate to movie details screen
                                  Navigator.pushNamed(context, AppRoutes.movieDetailsScreenRouteName, arguments: movie.id);
                                },
                                child: FilmCard(
                                  image: movie.mediumCoverImage ?? AppAssets.movieImage,
                                  rating: movie.rating ?? 0,
                                ),
                              );
                            },
                          ),
                        ),
                        // Bottom loading indicator
                        if (state.isLoadingMore)
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}