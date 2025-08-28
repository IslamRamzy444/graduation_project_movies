import 'package:bloc/bloc.dart';
import 'package:graduation_project_movies/ui/home/home_screen/cubit/category_states.dart';

import '../../../../api/api_manager.dart';

class CategoriesViewModel extends Cubit<CategoriesState> {
  CategoriesViewModel() : super(CategoriesLoading());
  String currentGenre = "Action"; // Add current genre variable
  List<String> genres = [
    "Action",
    "Adventure",
    "Animation",
    "Biography",
    "Comedy",
    "Crime",
    "Documentary",
    "Drama",
    "Family",
    "Fantasy",
    "Film-Noir",
    "Game-Show",
    "History",
    "Horror",
    "Music",
    "Musical",
    "Mystery",
    "News",
    "Reality-TV",
    "Romance",
    "Sci-Fi",
    "Sport",
    "Talk-Show",
    "Thriller",
    "War",
    "Western",
  ];

  int currentIndex = 0;

  String getNextGenre() {
    String genre = genres[currentIndex];
    currentIndex = (currentIndex + 1) % genres.length; // loop back after last
    return genre;
  }

  void getAllCategories() async {
    try {
      emit(CategoriesLoading());
      currentGenre = getNextGenre(); // Set the current genre
      var response = await ApiManager.getMoviesByCategory(currentGenre);
      if (response?.status == 'error') {
        emit(CategoriesFailure(errorMessage: response?.message ?? ''));
      } else if (response?.status == 'ok') {
        emit(CategoriesSuccess(categoriesList: response?.data!.movies));
      }
    } catch (e) {
      emit(CategoriesFailure(errorMessage: e.toString()));
    }
  }
}
