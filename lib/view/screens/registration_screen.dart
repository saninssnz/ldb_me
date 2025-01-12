import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ldb_me/controller/api_controller.dart';
import 'package:ldb_me/utils/navigation_service.dart';
import 'package:ldb_me/utils/validations.dart';
import 'package:ldb_me/view/screens/dashboard_screen.dart';
import 'package:ldb_me/view/screens/login_screen.dart';
import 'package:ldb_me/view/widgets/dropdown_widget.dart';
import 'package:ldb_me/view/widgets/textfield_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final ApiController apiController = Get.put(ApiController());

  bool _obscurePassword = true;
  String? selectedSpeciality;
  String? selectedCountry;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController tiktokController = TextEditingController();
  bool _consentChecked = false;
  bool _isButtonEnabled = false;

  final List<String> specialities = [
    'Dermatologist',
    'Cardiologist',
    'Pediatrician',
    'Neurologist'
  ];
  final List<String> countries = [
    'Afghanistan',
    'Albania',
    'Algeria',
    'Australia',
    'Brazil'
  ];

  @override
  void initState() {
    super.initState();
    emailController.addListener(_updateButtonState);
    passwordController.addListener(_updateButtonState);
    fullNameController.addListener(_updateButtonState);
    mobileNoController.addListener(_updateButtonState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'LDB ME',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3E2723),
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'REGISTRATION',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 40),
                  CustomInputField(
                      labelText: 'Full Name *', controller: fullNameController),
                  const SizedBox(height: 16),
                  CustomInputField(
                      labelText: 'Email *',
                      controller: emailController,
                      validator: emailValidator),
                  const SizedBox(height: 16),
                  CustomInputField(
                    isPasswordField: true,
                    labelText: "Password *",
                    controller: passwordController,
                    obscurePassword: _obscurePassword,
                    onVisibilityChanged: (bool newValue) {
                      setState(() {
                        _obscurePassword = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  buildDropdownField(
                    hint: 'Select Speciality *',
                    value: selectedSpeciality,
                    items: specialities,
                    onChanged: (value) {
                      setState(() => selectedSpeciality = value);
                    },
                  ),
                  const SizedBox(height: 16),
                  buildDropdownField(
                    hint: 'Select Country *',
                    value: selectedCountry,
                    items: countries,
                    onChanged: (value) {
                      setState(() => selectedCountry = value);
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomInputField(
                      labelText: 'Mobile Number *', controller: mobileNoController),
                  const SizedBox(height: 16),
                  CustomInputField(
                      labelText: 'Instagram @', controller: instagramController),
                  const SizedBox(height: 16),
                  CustomInputField(
                      labelText: 'TikTok @', controller: tiktokController),
                  const SizedBox(height: 24),
                  _buildConsentCheckbox(
                    isChecked: _consentChecked,
                    onChanged: (value) {
                      setState(() {
                        _consentChecked = value ?? false;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  apiController.isLoginLoading.value?
                  Center(
                    child: const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Color(0xFFA0C5FF),
                        )),
                  ):
                  _buildRegisterButton(),
                  const SizedBox(height: 16),
                  if(!apiController.isLoginLoading.value)
                  _buildLoginLink(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  Widget _buildConsentCheckbox({
    required bool isChecked,
    required ValueChanged<bool?> onChanged,
  }) {
    return GestureDetector(
      onTap: () {
        onChanged(!isChecked); // Toggle the checked state
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: 8, top: 10),
            height: 24,
            width: 24,
            decoration: BoxDecoration(
              color: isChecked ? Colors.blue : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: isChecked ? Colors.blue : Colors.grey[400]!,
                width: 1.0, // Thin border
              ),
            ),
            child: Center(
              child: isChecked
                  ? Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.white,
                    )
                  : SizedBox.shrink(),
            ),
          ),
          Expanded(
            child: Text(
              "By ticking this box, you give your consent to L'Oréal to process the provided data for the following purposes: Fulfilling L'Oréal requirements to report and record the identity of the attendees in its activities and events Use for compliance purposes and reporting according to L'Oréal and country-specific compliance regulations and code of conduct",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterButton() {
    return IgnorePointer(
      ignoring: !_isButtonEnabled ||
          selectedSpeciality == null ||
          selectedCountry == null ||
          !_consentChecked,
      child: ElevatedButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
          apiController
              .registerUser(
                  userName: fullNameController.text,
                  country: selectedCountry,
                  email: emailController.text,
                  instagram: instagramController.text,
                  mobile: mobileNoController.text,
                  password: passwordController.text,
                  speciality: selectedSpeciality,
                  tiktok: tiktokController.text)
              .then((value) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(apiController.message.value)));
              if (value) {
                navigateToScreen(context, const LoginScreen(),
                    removeUntil: true);
              }
            }
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _isButtonEnabled &&
                  selectedSpeciality != null &&
                  selectedCountry != null &&
                  _consentChecked
              ? Color(0xFFA0C5FF)
              : Colors.lightBlue[100],
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Register',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(
        'Or Login to an Account',
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 14,
        ),
      ),
    );
  }

  void _updateButtonState() {
    final isEmailValid = emailValidator(emailController.text) == null;
    setState(() {
      _isButtonEnabled = isEmailValid &&
          passwordController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          fullNameController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
