import 'package:bloc/bloc.dart';
import '../../../../api/api_manager.dart';
import 'browse_states.dart';

class BrowseCubit extends Cubit<BrowseState> {
  BrowseCubit() : super(BrowseInitial());

  void fetchMoviesByCategory(String genre, {int page = 1}) async {

    if (page == 1) {
      emit(BrowseLoading(selectedGenre: genre));
    } else {

      if (state is BrowseSuccess) {
        final currentState = state as BrowseSuccess;
        emit(currentState.copyWith(isLoadingMore: true));
      }
    }

    try {
      final response = await ApiManager.getMoviesByCategory(genre, page: page);

      if (response?.status == "ok") {
        final newMovies = response!.data!.movies ?? [];

        if (page == 1) {

          emit(BrowseSuccess(
            movies: newMovies,
            genre: genre,
            page: 1,
            hasMore: newMovies.length >= 20,
            isLoadingMore: false,
          ));
        } else if (state is BrowseSuccess) {

          final currentState = state as BrowseSuccess;
          final updatedMovies = [...currentState.movies, ...newMovies];

          emit(BrowseSuccess(
            movies: updatedMovies,
            genre: genre,
            page: page,
            hasMore: newMovies.length >= 20,
            isLoadingMore: false,
          ));
        }
      } else {
        emit(BrowseFailure(response?.message ?? "Unknown error", selectedGenre: genre));
      }
    } catch (e) {
      emit(BrowseFailure(e.toString(), selectedGenre: genre));
    }
  }

  void loadMore() {
    if (state is BrowseSuccess) {
      final currentState = state as BrowseSuccess;


      if (currentState.hasMore && !currentState.isLoadingMore) {
        fetchMoviesByCategory(currentState.genre, page: currentState.page + 1);
      }
    }
  }
}