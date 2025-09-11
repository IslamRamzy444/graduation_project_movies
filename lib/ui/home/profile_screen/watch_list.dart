import 'package:flutter/material.dart';

import '../../../utils/app_assets.dart';
import '../../../utils/app_routes.dart';
import 'movie_card.dart';

class WatchList extends StatelessWidget {
  final List favoriteList;
  final String token;
  final Function refreshProfile;

  const WatchList({
    Key? key,
    required this.favoriteList,
    required this.token,
    required this.refreshProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (favoriteList.isEmpty) {
      return Center(child: Image.asset(AppAssets.emptyIcon));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.7,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: favoriteList.length,
      itemBuilder: (context, index) {
        final movie = favoriteList[index];
        return GestureDetector(
          onTap: () async {
            final updated = await Navigator.of(context).pushNamed(
              AppRoutes.movieDetailsScreenRouteName,
              arguments: movie.movieId,
            );
            if (updated == true) {
              refreshProfile();
            }
          },
          child: MovieCard(
            backgroundImageUrl: movie.imageURL ?? AppAssets.watchNowImage,
            rating: movie.rating ?? 0.0,
          ),
        );
      },
    );
  }
}
