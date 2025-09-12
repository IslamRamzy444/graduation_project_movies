import 'dart:convert';

import 'package:graduation_project_movies/api/api_constants.dart';
//import 'api_constants.dart';
//import 'end_points.dart';
import 'package:graduation_project_movies/api/api_end_points.dart';
import 'package:graduation_project_movies/models/get_all_favorite_movie.dart';
import 'package:graduation_project_movies/models/login_response.dart';
import 'package:graduation_project_movies/models/movie_details_response.dart';
import 'package:graduation_project_movies/models/movie_suggestion_response.dart';
import 'package:graduation_project_movies/models/user_response.dart';
import 'package:http/http.dart' as http;

import '../models/add_to_favorite_response.dart';
import '../models/is_favorite_response.dart';
import '../models/movies_list_repsonse.dart';
import '../models/remove_favorite_response.dart';

class ApiManager {
  static Future<MovieSuggestionResponse?> getMovieSuggestion(
      {required int movieId}) async {
    Uri url =
        Uri.https(ApiConstants.baseUrl, ApiConstants.movieSuggestionEndPoint, {
      "movie_id": movieId.toString(),
    });
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var responseBody = response.body;
        var json = jsonDecode(responseBody);
        return MovieSuggestionResponse.fromJson(json);
      } else {
        throw Exception(
            "Failed to load movie suggestions: ${response.statusCode}");
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<MovieDetailsResponse?> getMovieDetails({required int movieId}) async{
    Uri url = Uri.https(
      ApiConstants.baseUrl,
      ApiConstants.movieDetailsEndPoint,
      {
        "movie_id" : movieId.toString(),
        "with_images" : "true",
        "with_cast" : "true"
      }
    );
    try{
      var response = await http.get(url);
      if(response.statusCode == 200){
        var responseBody = response.body;
        var json = jsonDecode(responseBody);
        return MovieDetailsResponse.fromJson(json);
      }else{
        throw Exception("Failed to load movie details: ${response.statusCode}");
      }
    } catch (e){
      rethrow;
    }
  }
  static Future<MoviesListResponse?> getAllMovies() async {
    Uri url = Uri.https(
      ApiConstants.baseUrl,
      ApiConstants.moviesListEndPoint,
      {
        "limit": "30",
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

  static Future<MoviesListResponse?> getMoviesByCategory(String genre) async {
    Uri url = Uri.https(
      ApiConstants.baseUrl,
      ApiConstants.moviesListEndPoint,
      {
        "limit": "20",
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

  static Future<MoviesListResponse?> searchMovies(String query) async {
    Uri url = Uri.https(
      ApiConstants.baseUrl,
      ApiConstants.moviesListEndPoint,
      {
        "query_term": query,
        "limit": "20",
        "minimum_rating": "2",
        "sort_by": "relevance",
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

  Future<LoginResponse?> login(String email, String password) async {
    Uri url = Uri.https(ApiConstants.authBaseUrl, ApiEndPoints.loginApi);

    try {
      var headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

      var body = jsonEncode({
        "email": email,
        "password": password,
      });

      var response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return LoginResponse.fromJson(json);
      } else {
        print("Login failed: ${response.statusCode} → ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error in login: $e");
      return null;
    }
  }
  static Future<UserResponse?> registerWithApi(String name,String email,String password,String confirmPassword,String phone,int avatarId)async{
    try{
      Uri url=Uri.https(ApiConstants.authBaseUrl,ApiEndPoints.resgisterAuthEndPoint);
      var response=await http.post(
      url,
      headers: {
        "Content-Type": "application/json"
      },
      body:jsonEncode({
        "name":name,
        "email":email,
        "password":password,
        "confirmPassword":confirmPassword,
        "phone":phone,
        "avaterId":avatarId
      }
      ));
      var body = response.body;
      var json = jsonDecode(body);
      return UserResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<UserResponse?> getProfile(String credential) async {
    try {
      Uri url = Uri.https(ApiConstants.authBaseUrl, ApiEndPoints.profileApi);
      var response = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $credential"
      });
      var json = jsonDecode(response.body);
      return UserResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<UserResponse?> updateProfileData(
      String credential,
      String? email,
      String? name,
      String? phone,
      int? avatarId
      ) async {
    try {
      Uri url = Uri.https(ApiConstants.authBaseUrl, ApiEndPoints.profileApi);

      // Create request body with only non-null values
      Map<String, dynamic> requestBody = {};

      if (email != null && email.isNotEmpty) {
        requestBody["email"] = email;
      }
      if (name != null && name.isNotEmpty) {
        requestBody["name"] = name;
      }
      if (phone != null && phone.isNotEmpty) {
        requestBody["phone"] = phone;
      }
      if (avatarId != null) {
        requestBody["avaterId"] = avatarId;
      }

      var response = await http.patch(
          url,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $credential"
          },
          body: jsonEncode(requestBody)
      );

      var body = response.body;
      var json = jsonDecode(body);
      return UserResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<UserResponse?> deleteUser(String credential) async {
    try {
      Uri url = Uri.https(ApiConstants.authBaseUrl, ApiEndPoints.profileApi);
      var response = await http.delete(url, headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $credential"
      });
      var json = jsonDecode(response.body);
      return UserResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<UserResponse?> resetPassword(String credential, String oldPassword, String newPassword) async {
    try {
      Uri url =
          Uri.https(ApiConstants.authBaseUrl, ApiEndPoints.resetPasswordApi);
      var response = await http.patch(url,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $credential"
          },
          body: jsonEncode(
              {"oldPassword": oldPassword, "newPassword": newPassword}));
      var json = jsonDecode(response.body);
      return UserResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<AddToFavoriteResponse?> addMovieToFavorites({
    required String token,
    required int movieId,
    required String name,
    required double rating,
    required String imageURL,
    required int year,
  }) async {
    try {
      Uri url =
          Uri.https(ApiConstants.authBaseUrl, ApiEndPoints.addFavoriteApi);

      var headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      var body = jsonEncode({
        "movieId": movieId,
        "name": name,
        "rating": rating,
        "imageURL": imageURL,
        "year": year,
      });

      var response = await http.post(url, headers: headers, body: body);

      print("Status: ${response.statusCode}");
      print("Body: ${response.body}");

      if (response.statusCode == 200) {
        return AddToFavoriteResponse.fromJson(jsonDecode(response.body));
      } else {
        print("Failed to add favorite: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error in addMovieToFavorites: $e");
      return null;
    }
  }

  static Future<IsFavoriteResponse?> checkIfMovieIsFavorite({
    required String token,
    required int movieId,
  }) async {
    try {
      Uri url = Uri.https(
        ApiConstants.authBaseUrl,
        "${ApiEndPoints.addFavoriteApi}/$movieId",
      );

      var headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      var response = await http.get(url, headers: headers);

      print("Status: ${response.statusCode}");
      print("Body: ${response.body}");

      if (response.statusCode == 200) {
        return IsFavoriteResponse.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  static Future<RemoveFavoriteResponse> removeMovieFromFavorites({
    required String token,
    required int movieId,
  }) async {
    final url = Uri.parse(
        "https://${ApiConstants.authBaseUrl}/${ApiEndPoints.removeFavoriteApi}/$movieId");

    final response = await http.delete(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return RemoveFavoriteResponse.fromJson(jsonResponse);
    } else {
      throw Exception("Failed to remove favorite: ${response.body}");
    }
  }

  static Future<GetAllFavoriteMovie?> getFavorites({
    required String token,
  }) async {
    final url = Uri.parse(
        "https://${ApiConstants.authBaseUrl}/${ApiEndPoints.getAllFavoriteApi}");

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return GetAllFavoriteMovie.fromJson(jsonResponse);
    } else {
      throw Exception("Failed to fetch favorites: ${response.body}");
    }
  }
}