import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_movies/api/api_manager.dart';
import 'package:graduation_project_movies/ui/auth/register/cubit/user_states.dart';

class RegisterViewModel extends Cubit<UserStates>{
  RegisterViewModel():super(UserLoadingState());
  void registerWithApi(String name,String email,String password,String confirmPassword,String phone,int avatarId)async{
    emit(UserLoadingState());
    try{
      var response=await ApiManager.registerWithApi(name, email, password, confirmPassword, phone, avatarId);
      if(response?.statusCode==400 || response?.data==null){
        emit(UserErrorState(errorMessage: response!.message!));
      }else if(response?.data!=null){
        emit(UserSuccessState(successMessage: response!.message!));
      }
    }catch(e){
      emit(UserErrorState(errorMessage: e.toString()));
    }
  }
}