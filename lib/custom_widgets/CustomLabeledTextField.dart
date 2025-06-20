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
  final bool isInputEnabled;
  final bool isSecret;         // New
  final int secretDigit;
  final bool isCapital;

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
    this.maxLength,
    this.isInputEnabled=true,
    this.isSecret = false,      // Default false
    this.secretDigit = 4,       // Default 4 digits visible
    this.isCapital = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// Label Row (with * if required)
        label.isEmpty?Container():
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded( // This allows the label text to wrap
                  child: Text.rich(
                    TextSpan(
                      text: label,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColor.grey2,
                      ),
                      children: isRequired
                          ? [
                        TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: AppColor.redColor,
                          ),
                        ),
                      ]
                          : [],
                    ),
                  ),
                ),
              ],
            ),


            SizedBox(height: 10),
          ],
        ),

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
          isInputEnabled: isInputEnabled,
          isSecret: isSecret,
          secretDigit: secretDigit,
          isCapital: isCapital,
        ),

        SizedBox(height: 20),
      ],
    );
  }
}
