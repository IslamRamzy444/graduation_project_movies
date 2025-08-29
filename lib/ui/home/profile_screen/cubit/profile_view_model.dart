import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_movies/api/api_manager.dart';
import 'package:graduation_project_movies/ui/home/profile_screen/cubit/profile_states.dart';

class ProfileViewModel extends Cubit<ProfileStates>{
  ProfileViewModel():super(ProfileLoadingState());
  void getProfile(String credential)async{
    emit(ProfileLoadingState());
    var response=await ApiManager.getProfile(credential);
    emit(ProfileFetchingState(userProfile: response!.data!));
  }
}