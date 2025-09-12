import 'package:bloc/bloc.dart';
import 'package:graduation_project_movies/api/api_manager.dart';
import 'package:graduation_project_movies/ui/home/search_screen/cubit/search_states.dart';

class SearchViewModel extends Cubit<SearchState> {
  SearchViewModel() : super(SearchInitial());

  void searchMovies(String query) async {
    if (query.trim().isEmpty) {
      emit(SearchInitial());
      return;
    }

    try {
      emit(SearchLoading());
      var response = await ApiManager.searchMovies(query);
      if (response?.status == 'error') {
        emit(SearchFailure(errorMessage: response?.message ?? 'Search failed'));
      } else if (response?.status == 'ok') {
        emit(SearchSuccess(moviesList: response?.data?.movies));
      }
    } catch (e) {
      emit(SearchFailure(errorMessage: e.toString()));
    }
  }

  void clearSearch() {
    emit(SearchInitial());
  }
}
