import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class CustomTextFieldFreezed extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onSuffixIconPressed;
  final String? Function(String?)? validator;
  final TextInputType inputType;
  const CustomTextFieldFreezed({
    Key? key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.obscureText = false,
    this.onSuffixIconPressed,
    this.validator,
    required this.inputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.black54),
      controller: controller,
      keyboardType: inputType,
      obscureText: obscureText,
      validator: validator,
      enabled: false,
      decoration: InputDecoration(
        labelText: label,
      // labelStyle: TextStyle(color: Colors.white),

       border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        filled: true, // Enables background color
        fillColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[800] // Darker grey for dark mode
            : Colors.grey[300], // Light grey for light mode

        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: onSuffixIconPressed,
        )
            : null,
      ),
    );
  }
}