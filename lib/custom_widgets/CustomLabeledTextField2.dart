import 'package:flutter/material.dart';

class CustomLabeledTextField2 extends StatelessWidget {
  final String label;
  final bool isRequired;
  final TextEditingController controller;
  final String hintText;
  final TextInputType inputType;
  final bool isTextArea;
  final ValueChanged<String>? onChanged;
  final int? maxLength; // <-- make it nullable

  const CustomLabeledTextField2({
    Key? key,
    required this.label,
    required this.isRequired,
    required this.controller,
    required this.hintText,
    required this.inputType,
    this.isTextArea = false,
    this.onChanged,
    this.maxLength, // <-- optional parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label${isRequired ? ' *' : ''}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          keyboardType: inputType,
          maxLines: isTextArea ? 3 : 1,
          maxLength: maxLength, // <-- set max length here
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
