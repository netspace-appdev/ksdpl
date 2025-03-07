import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/checkphone_controller.dart';

class CustomTextFieldListener extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onSuffixIconPressed;
  final String? Function(String?)? validator;
  final TextInputType inputType;
  const CustomTextFieldListener({
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
  State<CustomTextFieldListener> createState() => _CustomTextFieldListenerState();
}

class _CustomTextFieldListenerState extends State<CustomTextFieldListener> {
  final CheckPhoneController checkPhoneController = Get.find();
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onPhoneNumberChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onPhoneNumberChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.inputType,
      obscureText: widget.obscureText,
      validator: widget.validator,

      decoration: InputDecoration(
        labelText: widget.label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            widget.obscureText ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: widget.onSuffixIconPressed,
        )
            : null,
      ),
    );
  }

  void _onPhoneNumberChanged() {
    if (widget.controller.text.length == 10) {
      checkPhoneController.checkPhoneNumberAlreadyExistsApi(widget.controller.text);
    }
  }
}
