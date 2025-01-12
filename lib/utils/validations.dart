bool isValidEmail(String value) {
  String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  RegExp regex = RegExp(pattern);
  bool isValid = !regex.hasMatch(value);
  return isValid;
}

bool isValidMobile(String value) {
  String pattern = r'^\+\d{1,4}\d{10}$';
  RegExp regex = RegExp(pattern);
  return regex.hasMatch(value); // Removed the ! operator
}
