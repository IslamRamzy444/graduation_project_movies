import 'package:bloc/bloc.dart';
import 'package:graduation_project_movies/api/api_manager.dart';
import 'package:graduation_project_movies/ui/home/home_screen/cubit/movies_states.dart';

class MoviesViewModel extends Cubit<MoviesState> {
  MoviesViewModel() : super(MoviesLoading());

  void getAllMovies() async{
    try{
      emit(MoviesLoading());
      var response = await ApiManager.getAllMovies();
      if(response?.status=='error'){
        emit(MoviesFailure(errorMessage: response?.message ?? ''));
      }else if(response?.status=='ok') {
        emit(MoviesSuccess(moviesList: response?.data?.movies));
      }
    }catch(e){
      emit(MoviesFailure(errorMessage: e.toString()));
    }
  }
}
