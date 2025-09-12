import '../../../../models/movies_list_repsonse.dart';

abstract class BrowseState {}

class BrowseInitial extends BrowseState {}

class BrowseLoading extends BrowseState {
  final String? selectedGenre;

  BrowseLoading({this.selectedGenre});
}

class BrowseSuccess extends BrowseState {
  final List<Movies> movies;
  final String genre;
  final int page;
  final bool hasMore;
  final bool isLoadingMore;

  BrowseSuccess({
    required this.movies,
    required this.genre,
    required this.page,
    this.hasMore = true,
    this.isLoadingMore = false,
  });

  BrowseSuccess copyWith({
    List<Movies>? movies,
    String? genre,
    int? page,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return BrowseSuccess(
      movies: movies ?? this.movies,
      genre: genre ?? this.genre,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class BrowseFailure extends BrowseState {
  final String errorMessage;
  final String? selectedGenre;

  BrowseFailure(this.errorMessage, {this.selectedGenre});
}