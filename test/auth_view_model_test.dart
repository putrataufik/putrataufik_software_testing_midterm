import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:putrataufik_software_testing_midterm/viewmodel/auth_view_model.dart';
import 'package:putrataufik_software_testing_midterm/models/user.dart';
import 'mock_auth_service.mocks.dart';

void main() {
  late AuthViewModel viewModel;
  late MockAuthService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthService();
    viewModel = AuthViewModel(mockAuthService);
  });

  test("TC_AUTH_VM_001: Validate Empty Username", () {
    final result = viewModel.validateUsername("");
    expect(result, "Username cannot be empty.");
  });

  test("TC_AUTH_VM_002: Validate Short Password", () {
    final result = viewModel.validatePassword("123");
    expect(result, "Password must be at least 6 characters long.");
  });

  test("TC_AUTH_VM_003: Successful Login", () async {
    when(mockAuthService.login("testuser", "password123"))
        .thenAnswer((_) async => "fake-jwt-token");

    when(mockAuthService.getCurrentUser("fake-jwt-token"))
        .thenAnswer((_) async => User(
              id: 1,
              username: "testuser",
              email: "test@example.com",
              firstName: "Test",
              lastName: "User",
              gender: "female",
              image: "https://dummyjson.com/icon/emilys/128",
            ));

    final result = await viewModel.login("testuser", "password123");
    expect(result, "Login successful");
    expect(viewModel.isLoggedIn, true);
    expect(viewModel.accessToken, isNotNull);
    expect(viewModel.currentUser?.username, "testuser");
  });

  test("TC_AUTH_VM_004: Login with Invalid Credentials", () async {
    when(mockAuthService.login("invaliduser", "wrongpassword"))
        .thenAnswer((_) async => null); // null berarti gagal login

    final result = await viewModel.login("invaliduser", "wrongpassword");
    expect(result, "Invalid username or password.");
    expect(viewModel.isLoggedIn, false);
  });

  test("TC_AUTH_VM_005: Logout Functionality", () async {
    viewModel.isLoggedIn = true;

    when(mockAuthService.logout()).thenAnswer((_) async => true);

    final result = await viewModel.logout();
    expect(result, "Logout successful");
    expect(viewModel.isLoggedIn, false);
  });

  test("TC_AUTH_VM_006: Username Length Boundary", () {
    expect(viewModel.validateUsername("ab"), isNotNull);
    expect(viewModel.validateUsername("abc"), isNull);
    expect(viewModel.validateUsername("a" * 20), isNull);
    expect(viewModel.validateUsername("a" * 21), isNotNull);
  });

  test("TC_AUTH_VM_007: Password Length Boundary", () {
    expect(viewModel.validatePassword("12345"), isNotNull);
    expect(viewModel.validatePassword("123456"), isNull);
  });

  test("TC_AUTH_VM_008: Username with Special Characters", () {
    final result = viewModel.validateUsername("user!@#");
    expect(result, "Username contains invalid characters.");
  });

  test("TC_AUTH_VM_009: SQL Injection Attempt", () async {
    when(mockAuthService.login("'OR 1=1 --", "abc123"))
        .thenAnswer((_) async => null); // login gagal

    final result = await viewModel.login("'OR 1=1 --", "abc123");
    expect(result, "Invalid username or password.");
  });

  test("TC_AUTH_VM_010: Empty Username and Password", () async {
    final result = await viewModel.login("", "");
    expect(result, "Username cannot be empty.");
  });
}
