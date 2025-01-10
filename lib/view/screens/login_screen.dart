import 'package:flutter/material.dart';
import 'package:ldb_me/utils/navigation_service.dart';
import 'package:ldb_me/view/screens/registration_screen.dart';
import 'package:ldb_me/view/widgets/textfield_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'LDB ME',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'LOG IN',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 40),
              buildTextField(hint: 'Email',controller: emailController),
              const SizedBox(height: 16),
              buildPasswordField(
                controller: passwordController,
                obscurePassword: _obscurePassword,
                onVisibilityChanged: (bool newValue) {
                  setState(() {
                    _obscurePassword = newValue;
                  });
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue[100],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () {

                },
                child: Text(
                  'Forget Password?',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  navigateToScreen(
                      context, const RegistrationScreen());
                },
                child: Text(
                  'Or Create an Account',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}