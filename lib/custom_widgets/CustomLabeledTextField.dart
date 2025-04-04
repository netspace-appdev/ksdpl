import 'package:flutter/material.dart';

import '../common/helper.dart';
import 'CustomTextFieldPrefix.dart';
class CustomLabeledTextField extends StatelessWidget {
  final String label;
  final bool isRequired;
  final TextEditingController controller;
  final TextInputType inputType;
  final String hintText;
  final String? Function(String?)? validator;
  final bool isPassword;
  final bool obscureText;
  final bool isTextArea;
  final int? maxLength;

  const CustomLabeledTextField({
    Key? key,
    required this.label,
    this.isRequired = false,
    required this.controller,
    required this.inputType,
    required this.hintText,
    this.validator,
    this.isPassword = false,
    this.obscureText = false,
    this.isTextArea = false,
    this.maxLength
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// Label Row (with * if required)
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColor.grey2,
              ),
            ),
            if (isRequired)
              Text(
                " *",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.redColor,
                ),
              ),
          ],
        ),

        SizedBox(height: 10),

        /// Custom TextField
        CustomTextFieldPrefix(
          inputType: inputType,
          controller: controller,
          validator: validator,
          isPassword: isPassword,
          obscureText: obscureText,
          hintText: hintText,
          isTextArea: isTextArea,
          maxLength: maxLength,
        ),

        SizedBox(height: 20),
      ],
    );
  }
}
