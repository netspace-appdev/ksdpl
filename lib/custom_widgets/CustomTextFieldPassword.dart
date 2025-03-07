import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextFieldPassword extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onSuffixIconPressed;
  final String? Function(String?)? validator;
  final TextInputType inputType;
  final RxString passwordStrength; // Observable for strength message
  final Rx<Color> passwordStrengthColor; // Observable for color
  final Function(String)? onChanged;
  const CustomTextFieldPassword({
    Key? key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.obscureText = false,
    this.onSuffixIconPressed,
    this.validator,
    required this.inputType,
    required this.passwordStrength,
    required this.passwordStrengthColor,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          keyboardType: inputType,
          obscureText: obscureText,
          validator: validator,
          onChanged: onChanged,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
            suffixIcon: isPassword
                ? IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: onSuffixIconPressed,
            )
                : null,
          ),
        ),
        const SizedBox(height: 5), // Small spacing
        Obx(() => Text(
          passwordStrength.value,
          style: TextStyle(
            color: passwordStrengthColor.value,
            fontWeight: FontWeight.bold,
          ),
        )),
      ],
    );
  }
}
