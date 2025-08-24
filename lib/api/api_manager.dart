import 'dart:convert';

import 'package:graduation_project_movies/models/login_response.dart';
import 'package:http/http.dart' as http;

import 'api_constants.dart';
import 'end_points.dart';

class ApiManager {
  Future<LoginResponse?> login(String email, String password) async {
    Uri url = Uri.https(ApiConstants.baseUrl, Endpoints.loginApi);

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
}
