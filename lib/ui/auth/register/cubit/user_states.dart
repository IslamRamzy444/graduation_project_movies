abstract class UserStates {}
class UserLoadingState extends UserStates{}
class UserErrorState extends UserStates{
  String errorMessage;
  UserErrorState({required this.errorMessage});
}
class UserSuccessState extends UserStates{
  String successMessage;
  UserSuccessState({required this.successMessage});
}