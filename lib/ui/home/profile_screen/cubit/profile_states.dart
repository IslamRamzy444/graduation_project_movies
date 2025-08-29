import 'package:graduation_project_movies/models/user_response.dart';

abstract class ProfileStates {}
class ProfileLoadingState extends ProfileStates{}
class ProfileFetchingState extends ProfileStates{
  Data userProfile;
  ProfileFetchingState({required this.userProfile});
}