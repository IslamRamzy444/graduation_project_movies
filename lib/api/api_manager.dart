import 'dart:convert';

import 'package:graduation_project_movies/api/api_constants.dart';
import 'package:http/http.dart' as http;

import '../models/movies_list_repsonse.dart';

class ApiManager {

 static Future<MoviesListResponse?> getAllMovies()async{
    Uri url = Uri.https(
      ApiConstants.baseUrl,
      ApiConstants.moviesListEndPoint,
      {
        "limit": "10",
        "minimum_rating": "7",
        "sort_by": "like_count",
        "order_by": "desc",
        "quality": "1080p"
      },
    );
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return MoviesListResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }
 static Future<MoviesListResponse?> getMoviesByCategory(String genre)async{
    Uri url = Uri.https(
      ApiConstants.baseUrl,
      ApiConstants.moviesListEndPoint,
      {
        "limit": "10",
        "minimum_rating": "7",
        "sort_by": "like_count",
        "order_by": "desc",
        "quality": "1080p",
        "genre": genre,
      },
    );
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return MoviesListResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

}