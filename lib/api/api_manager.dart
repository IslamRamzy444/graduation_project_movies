import 'dart:convert';

import 'package:graduation_project_movies/api/api_constants.dart';
import 'package:graduation_project_movies/models/MoviesListResponse.dart';
import 'package:http/http.dart' as http;

class ApiManager {
  static ApiManager? _instance;
  ApiManager._internal();
  static ApiManager getInstance() {
    _instance ??= ApiManager._internal();
    return _instance!;
  }

   Future<MoviesListResponse?> getAllMovies()async{
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
}
