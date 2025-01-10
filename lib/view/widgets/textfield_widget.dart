import 'package:flutter/material.dart';

Widget buildTextField({required String hint, required TextEditingController controller}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey[400]),
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(3),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(3),
        borderSide: BorderSide(color: Colors.grey[400]!),
      ),
    ),
  );
}

Widget buildPasswordField({
  required bool obscurePassword,
  required TextEditingController controller,
  required ValueChanged<bool> onVisibilityChanged,  // Callback to handle state change
}) {
  return TextField(
    controller: controller,
    obscureText: obscurePassword,
    decoration: InputDecoration(
      hintText: 'Password',
      hintStyle: TextStyle(color: Colors.grey[400]),
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey[400]!),
      ),
      suffixIcon: IconButton(
        icon: Icon(
          obscurePassword ? Icons.visibility_off : Icons.visibility,
          color: Colors.grey[400],
        ),
        onPressed: () {
          onVisibilityChanged(!obscurePassword);  // Call the callback with new value
        },
      ),
    ),
  );
}