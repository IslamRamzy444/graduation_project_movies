import 'package:graduation_project_movies/models/user_response.dart';

abstract class UserStates {}
class UserLoadingState extends UserStates{}
class UserErrorState extends UserStates{
  String errorMessage;
  UserErrorState({required this.errorMessage});
}
class UserSuccessState extends UserStates{
  String successMessage;
  Data userData;

  UserSuccessState({required this.successMessage, required this.userData});
}