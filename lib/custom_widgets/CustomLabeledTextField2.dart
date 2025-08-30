import 'package:flutter/material.dart';

import '../common/helper.dart';

class CustomLabeledTextField2 extends StatelessWidget {
  final String label;
  final bool isRequired;
  final TextEditingController controller;
  final String hintText;
  final TextInputType inputType;
  final bool isTextArea;
  final ValueChanged<String>? onChanged;
  final int? maxLength;
  final FormFieldValidator<String>? validator; // <-- Added validator
  final bool isInputEnabled;
  const CustomLabeledTextField2({
    Key? key,
    required this.label,
    required this.isRequired,
    required this.controller,
    required this.hintText,
    required this.inputType,
    this.isTextArea = false,
    this.onChanged,
    this.maxLength,
    this.validator,
    this.isInputEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.grey2,
              fontSize: 16,
            ),
            children: isRequired
                ? [
              const TextSpan(
                text: ' *',
                style: TextStyle(
                  color: Colors.red, // red star
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]
                : [],
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          style: TextStyle(color: isInputEnabled ? Colors.black : Colors.grey),
          enabled: isInputEnabled,
          controller: controller,
          keyboardType: inputType,
          maxLines: isTextArea ? 3 : 1,
          maxLength: maxLength,
          decoration: InputDecoration(
            fillColor: isInputEnabled ? AppColor.grey3 : Colors.grey[300],
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          onChanged: onChanged,
          validator: validator, // <-- hooked up validator
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
