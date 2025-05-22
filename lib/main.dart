import 'package:flutter/material.dart';
import 'view/login_screen.dart';
import 'services/auth_service_impl.dart';
import 'viewmodel/auth_view_model.dart';

void main() {
  // Inisialisasi service dan ViewModel
  final authService = AuthServiceImpl();
  final authViewModel = AuthViewModel(authService);

  runApp(MyApp(viewModel: authViewModel));
}

class MyApp extends StatelessWidget {
  final AuthViewModel viewModel;

  const MyApp({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MVVM Auth',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(viewModel: viewModel),
    );
  }
}
