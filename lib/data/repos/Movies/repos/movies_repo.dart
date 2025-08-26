
import 'package:graduation_project_movies/models/MoviesListResponse.dart';

abstract class MoviesRepo {
  Future<MoviesListResponse?>getMovies();
}