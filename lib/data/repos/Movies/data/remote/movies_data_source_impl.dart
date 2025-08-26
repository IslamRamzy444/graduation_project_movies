import 'package:graduation_project_movies/models/MoviesListResponse.dart';

abstract class MoviesDataSource {
  Future<MoviesListResponse?>getMovies();
}