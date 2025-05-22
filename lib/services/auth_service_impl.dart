import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_service.dart';
import '../models/user.dart';

class AuthServiceImpl implements AuthService {
  @override
  Future<String?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('https://dummyjson.com/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'expiresInMins': 30,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['accessToken']; // return JWT
    }

    return null;
  }

  @override
  Future<User?> getCurrentUser(String accessToken) async {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/auth/me'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data);
    }

    return null;
  }

  @override
  Future<bool> logout() async {
    return true; // no real logout endpoint, just simulate
  }
}
