import 'package:graduation_project_movies/api/api_manager.dart';
import 'package:graduation_project_movies/models/MoviesListResponse.dart';

import '../movies_data_source_impl.dart';

class MoviesDataSourceImpl implements MoviesDataSource {
  var apiManager = ApiManager.getInstance();
  @override
  Future<MoviesListResponse?> getMovies() async{
   var response=await apiManager.getAllMovies();
   return response;
  }

}