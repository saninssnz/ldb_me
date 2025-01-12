String? emailValidator(String? value) {
  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  if (value == null || value.isEmpty) {
    return null;
  } else if (!emailRegex.hasMatch(value)) {
    return 'Enter a valid email address';
  }
  return null;
}

bool isValidMobile(String value) {
  String pattern = r'^\+\d{1,4}\d{10}$';
  RegExp regex = RegExp(pattern);
  return regex.hasMatch(value); // Removed the ! operator
}
