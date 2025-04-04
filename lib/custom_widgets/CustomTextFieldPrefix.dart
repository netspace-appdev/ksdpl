import 'package:flutter/material.dart';
import 'package:ksdpl/common/helper.dart';

class CustomTextFieldPrefix extends StatelessWidget {
  final String? hintText;
  final TextEditingController controller;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onSuffixIconPressed;
  final String? Function(String?)? validator;
  final TextInputType inputType;
  final Function(String)? onChanged;
  final String? prefixImage; // Nullable image path
  final String? label;
  final bool isTextArea;
  final int? maxLength;

  const CustomTextFieldPrefix({
    Key? key,
    this.hintText,
    required this.controller,
    this.isPassword = false,
    this.obscureText = false,
    this.onSuffixIconPressed,
    this.validator,
    required this.inputType,
    this.onChanged,
    this.prefixImage, // Optional parameter
    this.label,
    this.isTextArea = false,
    this.maxLength
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      maxLines: isTextArea ? null : 1, // Allow multiple lines if isTextArea is true
      minLines: isTextArea ? 3 : 1, // Minimum 5 lines for text area
      maxLength: maxLength,

      decoration: InputDecoration(
        hintText: hintText!=null?hintText:null,
        hintStyle: TextStyle(color: AppColor.grey2),
        filled: true,
        fillColor: AppColor.grey3,
        label: label != null?
        Text(label!):null,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:  const BorderSide(color: Colors.red, width: 1.5),
        ),
        enabledBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:  const BorderSide(color: AppColor.borderColor, width: 1.5),
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
