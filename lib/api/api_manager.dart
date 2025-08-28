import 'dart:convert';


import 'package:graduation_project_movies/api/api_constants.dart';
import 'package:http/http.dart' as http;

import '../models/movies_list_repsonse.dart';
import 'package:graduation_project_movies/models/login_response.dart';
//import 'api_constants.dart';
//import 'end_points.dart';
import 'package:graduation_project_movies/api/api_end_points.dart';
import 'package:graduation_project_movies/models/user_response.dart';

class ApiManager {
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
      String credential, String email, int avatarId) async {
    try {
      Uri url = Uri.https(ApiConstants.authBaseUrl, ApiEndPoints.profileApi);
      var response = await http.patch(url,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $credential"
          },
          body: jsonEncode({"email": email, "avaterId": avatarId}));
      var body=response.body;
      var json=jsonDecode(body);
      return UserResponse.fromJson(json);
    }catch(e){
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

  static Future<UserResponse?> resetPassword(
      String credential, String oldPassword, String newPassword) async {
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
}