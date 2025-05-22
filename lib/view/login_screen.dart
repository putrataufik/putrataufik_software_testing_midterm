import 'package:flutter/material.dart';
import '../viewmodel/auth_view_model.dart';

class LoginScreen extends StatefulWidget {
  final AuthViewModel viewModel;

  const LoginScreen({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  String _message = '';
  bool _isLoading = false;

  void _performLogin() async {
    setState(() {
      _isLoading = true;
      _message = '';
    });

    final username = _usernameController.text;
    final password = _passwordController.text;

    final result = await widget.viewModel.login(username, password);

    setState(() {
      _isLoading = false;
      _message = result;
    });
  }

  void _performLogout() async {
    setState(() {
      _isLoading = true;
      _message = '';
    });

    final result = await widget.viewModel.logout();

    setState(() {
      _isLoading = false;
      _message = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = widget.viewModel.isLoggedIn;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login MVVM App'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: isLoggedIn ? _buildLogoutUI() : _buildLoginForm(),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Welcome Back!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    widget.viewModel.validateUsername(value ?? ''),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    widget.viewModel.validatePassword(value ?? ''),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            _performLogin();
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Login',
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 16),
              if (_message.isNotEmpty)
                Text(_message, style: const TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutUI() {
    final user = widget.viewModel.currentUser;

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 64),
            const SizedBox(height: 16),
            Text(
              user != null
                  ? 'Welcome, ${user.firstName} ${user.lastName}!'
                  : 'Logged in!',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _performLogout,
                icon: const Icon(Icons.logout),
                label: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (_message.isNotEmpty)
              Text(_message, style: const TextStyle(color: Colors.green)),
          ],
        ),
      ),
    );
  }
}
