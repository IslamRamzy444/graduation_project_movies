import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_movies/api/api_manager.dart';
import 'package:graduation_project_movies/ui/home/profile_screen/cubit/profile_states.dart';

class ProfileViewModel extends Cubit<ProfileStates> {
  ProfileViewModel() : super(ProfileLoadingState());

  void getProfile(String token) async {
    try {
      emit(ProfileLoadingState());

      final profileResponse = await ApiManager.getProfile(token);
      if (profileResponse == null || profileResponse.data == null) {
        emit(ProfileEmptyState());
        return;
      }

      final favoritesResponse = await ApiManager.getFavorites(token: token);

      emit(ProfileFetchingState(
        userProfile: profileResponse.data!,
        favorites: favoritesResponse?.data ?? [],
      ));
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }
}
