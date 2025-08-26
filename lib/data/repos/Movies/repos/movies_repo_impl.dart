import 'package:graduation_project_movies/data/repos/Movies/data/remote/movies_data_source_impl.dart';
import 'package:graduation_project_movies/data/repos/Movies/repos/movies_repo.dart';
import 'package:graduation_project_movies/models/MoviesListResponse.dart';

class MoviesRepoImpl implements MoviesRepo{
   MoviesDataSource moviesDataSource;
   MoviesRepoImpl({required this.moviesDataSource});
  @override
  Future<MoviesListResponse?> getMovies() {
    var response=moviesDataSource.getMovies();
    return response;
  }

}