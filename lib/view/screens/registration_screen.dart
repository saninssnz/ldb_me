import 'package:flutter/material.dart';
import 'package:ldb_me/view/widgets/dropdown_widget.dart';
import 'package:ldb_me/view/widgets/textfield_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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


  final List<String> specialities = ['Dermatologist', 'Cardiologist', 'Pediatrician', 'Neurologist'];
  final List<String> countries = ['Afghanistan', 'Albania', 'Algeria', 'Australia', 'Brazil'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
              buildTextField(hint: 'Full Name',controller: fullNameController),
              const SizedBox(height: 16),
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
              buildTextField(hint: 'Mobile Number',controller: mobileNoController),
              const SizedBox(height: 16),
              buildTextField(hint: 'Instagram @',controller: instagramController),
              const SizedBox(height: 16),
              buildTextField(hint: 'TikTok @',controller: tiktokController),
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
              _buildRegisterButton(),
              const SizedBox(height: 16),
              _buildLoginLink(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConsentCheckbox({
    required bool isChecked,
    required ValueChanged<bool?> onChanged,
  }) {
    return GestureDetector(
      onTap: () {
        onChanged(!isChecked);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: 8,top: 10),
            height: 24,  // Customize size
            width: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isChecked ? Colors.blue : Colors.grey[400]!,
                width: 1.0,  // Thin border
              ),
            ),
            child: Center(
              child: Container(
                height: 14,  // Size of inner circle when checked
                width: 14,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isChecked ? Colors.blue : Colors.transparent,
                ),
              ),
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
    return ElevatedButton(
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
        'Register',
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return TextButton(
      onPressed: () {

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
}