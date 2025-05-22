import '../models/user.dart';

abstract class AuthService {
  Future<String?> login(String username, String password);
  Future<User?> getCurrentUser(String accessToken);
  Future<bool> logout();
}
