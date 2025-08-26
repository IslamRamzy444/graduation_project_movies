import 'package:graduation_project_movies/models/MoviesListResponse.dart';

abstract class MoviesState {}
class MoviesLoading extends MoviesState {}
class MoviesSuccess extends MoviesState {
  final List<Movies>? moviesList;
  MoviesSuccess({required this.moviesList});
}
class MoviesFailure extends MoviesState {
  final String errorMessage;
  MoviesFailure({required this.errorMessage});
}
