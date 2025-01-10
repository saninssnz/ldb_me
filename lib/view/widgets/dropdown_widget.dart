import 'package:flutter/material.dart';

Widget buildDropdownField({
  required String hint,
  required String? value,
  required List<String> items,
  required ValueChanged<String?> onChanged,
}) {
  return DropdownButtonFormField<String>(
    value: value,
    decoration: InputDecoration(
      labelText: hint,
      labelStyle: TextStyle(color: Colors.black),
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
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),
    items: items.map((String item) {
      return DropdownMenuItem<String>(
        value: item,
        child: Text(item),
      );
    }).toList(),
    onChanged: onChanged,
    isExpanded: true,
    icon: Icon(Icons.arrow_drop_down),
    style: TextStyle(
      color: Colors.black87,
      fontSize: 16,
    ),
  );
}