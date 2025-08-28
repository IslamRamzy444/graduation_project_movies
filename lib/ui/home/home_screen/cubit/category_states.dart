import '../../../../models/movies_list_repsonse.dart';

abstract class CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesSuccess extends CategoriesState {
  List<Movies>? categoriesList;

  CategoriesSuccess({required this.categoriesList});
}

class CategoriesFailure extends CategoriesState {
  final String errorMessage;

  CategoriesFailure({required this.errorMessage});
}
