import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final bool isPasswordField;
  final ValueChanged<bool>? onVisibilityChanged;
  final bool obscurePassword;
  final String? Function(String?)? validator;

  const CustomInputField({
    required this.labelText,
    required this.controller,
    this.isPasswordField = false,
    this.onVisibilityChanged,
    this.obscurePassword = true,
    this.validator,
    super.key,
  });

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late FocusNode _focusNode;
  late bool _obscurePassword;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
    _obscurePassword = widget.obscurePassword;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void validateInput() {
    if (widget.validator != null) {
      setState(() {
        _errorText = widget.validator!(widget.controller.text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: widget.controller,
          obscureText: widget.isPasswordField ? _obscurePassword : false,
          focusNode: _focusNode,
          decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: TextStyle(
              color: _focusNode.hasFocus ? Colors.black : Colors.grey[400],
            ),
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
            errorText: _errorText,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: BorderSide(color: Colors.red),
            ),
            suffixIcon: widget.isPasswordField
                ? IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey[400],
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
                if (widget.onVisibilityChanged != null) {
                  widget.onVisibilityChanged!(_obscurePassword);
                }
              },
            )
                : null,
          ),
          onChanged: (value) {
            validateInput();
          },
          onTap: () {
            setState(() {});
          },
        ),
      ],
    );
  }
}
