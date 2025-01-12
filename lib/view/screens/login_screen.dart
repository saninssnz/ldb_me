import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ldb_me/controller/api_controller.dart';
import 'package:ldb_me/utils/navigation_service.dart';
import 'package:ldb_me/utils/validations.dart';
import 'package:ldb_me/view/screens/dashboard_screen.dart';
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
  bool _isButtonEnabled = false;
  final ApiController apiController = Get.put(ApiController());


  @override
  void initState() {
    super.initState();
    emailController.addListener(_updateButtonState);
    passwordController.addListener(_updateButtonState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
          return SafeArea(
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
                  CustomInputField(labelText: 'Email',controller: emailController,validator: emailValidator,),
                  const SizedBox(height: 16),
                  CustomInputField(
                    isPasswordField: true,
                    labelText: "Password",
                    controller: passwordController,
                    obscurePassword: _obscurePassword,
                    onVisibilityChanged: (bool newValue) {
                      setState(() {
                        _obscurePassword = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 30),
                  apiController.isLoginLoading.value?
                  Center(
                    child: const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Color(0xFFA0C5FF),
                        )),
                  ):
                  IgnorePointer(
                    ignoring: !_isButtonEnabled,
                    child: ElevatedButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        apiController
                            .userLogin(
                            email: emailController.text,
                            password: passwordController.text)
                            .then((value) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(apiController.message.value)));
                            if (value) {
                              navigateToScreen(context, const DashboardScreen(),
                                  removeUntil: true);
                            }
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isButtonEnabled?Color(0xFFA0C5FF):Colors.lightBlue[100],
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
                  ),
                  const SizedBox(height: 24),
                  if(!apiController.isLoginLoading.value)
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
                  if(!apiController.isLoginLoading.value)
                  TextButton(
                    onPressed: () {
                      navigateToScreen(
                          context, const RegistrationScreen());
                      FocusScope.of(context).unfocus();
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
          );
        }
      ),
    );
  }
  void _updateButtonState() {
    final isEmailValid = emailValidator(emailController.text) == null;
    setState(() {
      _isButtonEnabled = isEmailValid && passwordController.text.isNotEmpty && emailController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}