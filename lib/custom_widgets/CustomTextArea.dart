import 'package:flutter/material.dart';

class CustomTextArea extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final int maxLines;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  const CustomTextArea({
    Key? key,
    required this.label,
    required this.controller,
    this.maxLines = 5, // Default to 5 lines
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      onChanged: onChanged,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        labelText: label,
        alignLabelWithHint: true, // Align label to the top-left for multiline
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }
}
