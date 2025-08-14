import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomLabeledTextField2 extends StatelessWidget {
  final String label;
  final bool isRequired;
  final TextEditingController controller;
  final String hintText;
  final TextInputType inputType;
  final bool isTextArea;
  final ValueChanged<String>? onChanged; // <-- ADD THIS

  const CustomLabeledTextField2({
    Key? key,
    required this.label,
    required this.isRequired,
    required this.controller,
    required this.hintText,
    required this.inputType,
    this.isTextArea = false,
    this.onChanged, // <-- ADD THIS
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
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          onChanged: onChanged, // <-- CALL IT HERE
        ),
      ],
    );
  }
}
