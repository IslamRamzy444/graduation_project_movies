import 'dart:convert';


import 'package:graduation_project_movies/api/end_points.dart';
import 'package:graduation_project_movies/models/login_response.dart';
//import 'api_constants.dart';
//import 'end_points.dart';
import 'package:graduation_project_movies/api/api_constants.dart';
import 'package:graduation_project_movies/api/api_end_points.dart';
import 'package:graduation_project_movies/models/user_response.dart';
import 'package:http/http.dart' as http;

class ApiManager {
  Future<LoginResponse?> login(String email, String password) async {
    Uri url = Uri.https(ApiConstants.authBaseUrl, Endpoints.loginApi);

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
      var body=response.body;
      var json=jsonDecode(body);
      return UserResponse.fromJson(json);
    }catch(e){
      throw e;
    }
  }
}

