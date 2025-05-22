import '../services/auth_service.dart';
import '../models/user.dart';

class AuthViewModel {
  final AuthService _authService;
  bool isLoggedIn = false;
  String? accessToken;
  User? currentUser;

  AuthViewModel(this._authService);

  String? validateUsername(String username) {
    if (username.isEmpty) return "Username cannot be empty.";
    if (RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(username)) {
      return "Username contains invalid characters.";
    }
    if (username.length < 3 || username.length > 20) {
      return "Username length must be between 3 and 20 characters.";
    }
    return null;
  }

  String? validatePassword(String password) {
    if (password.isEmpty) return "Password cannot be empty.";
    if (password.length < 6)
      return "Password must be at least 6 characters long.";
    return null;
  }

  Future<String> login(String username, String password) async {
    final usernameError = validateUsername(username);
    final passwordError = validatePassword(password);
    if (usernameError != null || passwordError != null) {
      return usernameError ?? passwordError!;
    }

    final token = await _authService.login(username, password);
    if (token != null) {
      accessToken = token;
      currentUser = await _authService.getCurrentUser(token);
      isLoggedIn = true;
      return "Login successful";
    } else {
      return "Invalid username or password.";
    }
  }

  Future<String> logout() async {
    final success = await _authService.logout();
    if (success) {
      accessToken = null;
      currentUser = null;
      isLoggedIn = false;
      return "Logout successful";
    }
    return "Logout failed";
  }
}
