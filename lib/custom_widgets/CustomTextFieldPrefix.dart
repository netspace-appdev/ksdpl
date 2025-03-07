import 'package:flutter/material.dart';
import 'package:ksdpl/common/helper.dart';

class CustomTextFieldPrefix extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onSuffixIconPressed;
  final String? Function(String?)? validator;
  final TextInputType inputType;
  final Function(String)? onChanged;
  final String? prefixImage; // Nullable image path

  const CustomTextFieldPrefix({
    Key? key,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.obscureText = false,
    this.onSuffixIconPressed,
    this.validator,
    required this.inputType,
    this.onChanged,
    this.prefixImage, // Optional parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: AppColor.grey2),
        filled: true,
        fillColor: AppColor.grey3,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        // Conditionally add prefix icon
        prefixIcon: prefixImage != null
            ? Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(prefixImage!, width: 24, height: 24),
        )
            : null,
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: AppColor.grey1,
          ),
          onPressed: onSuffixIconPressed,
        )
            : null,
      ),
    );
  }
}
