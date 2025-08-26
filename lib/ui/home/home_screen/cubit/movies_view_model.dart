import 'package:bloc/bloc.dart';
import 'package:graduation_project_movies/data/repos/Movies/repos/movies_repo.dart';
import 'package:graduation_project_movies/ui/home/home_screen/cubit/movies_states.dart';

class MoviesViewModel extends Cubit<MoviesState> {
  MoviesRepo moviesRepo;
  MoviesViewModel({required this.moviesRepo}) : super(MoviesLoading());

  void getAllMovies() async{
    try{
      emit(MoviesLoading());
      var response = await moviesRepo.getMovies();
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
