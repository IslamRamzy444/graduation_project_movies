import 'package:graduation_project_movies/models/user_response.dart';

import '../../../../models/get_all_favorite_movie.dart';

abstract class ProfileStates {}

class ProfileLoadingState extends ProfileStates {}

class ProfileEmptyState extends ProfileStates {}

class ProfileFetchingState extends ProfileStates {
  final Data userProfile;
  final List<FavoriteMovie> favorites;

  ProfileFetchingState({
    required this.userProfile,
    required this.favorites,
  });
}

class ProfileErrorState extends ProfileStates {
  final String error;

  ProfileErrorState(this.error);
}
