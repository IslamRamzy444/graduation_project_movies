import 'dart:convert';

import 'package:graduation_project_movies/api/api_constants.dart';
import 'package:graduation_project_movies/api/api_end_points.dart';
import 'package:graduation_project_movies/models/user_response.dart';
import 'package:http/http.dart' as http;

class ApiManager {
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
      var body=response.body;
      var json=jsonDecode(body);
      return UserResponse.fromJson(json);
    }catch(e){
      throw e;
    }
  }
}