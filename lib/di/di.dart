 import 'package:graduation_project_movies/data/repos/Movies/data/remote/movies_data_source_impl.dart';
import 'package:graduation_project_movies/data/repos/Movies/repos/movies_repo.dart';

import '../data/repos/Movies/data/remote/impl/movies_data_source_impl.dart';
import '../data/repos/Movies/repos/movies_repo_impl.dart';

MoviesRepo injectMovieRepository() {
  return MoviesRepoImpl(moviesDataSource: injectMoviesDataSource());
}
MoviesDataSource injectMoviesDataSource() {
  return MoviesDataSourceImpl();
}