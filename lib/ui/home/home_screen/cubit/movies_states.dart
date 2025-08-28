import '../../../../models/movies_list_repsonse.dart';

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
