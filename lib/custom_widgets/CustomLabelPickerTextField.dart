import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../common/helper.dart';

class CustomLabeledPickerTextField extends StatelessWidget {
  final String label;
  final bool isRequired;
  final TextEditingController controller;
  final TextInputType inputType;
  final String hintText;
  final String? Function(String?)? validator;
  final bool isPassword;
  final bool obscureText;
  final bool isDateField;
  final bool enabled;
  final bool isFutureDisabled;
  final VoidCallback? onDateSelected;
  const CustomLabeledPickerTextField({
    Key? key,
    required this.label,
    this.isRequired = false,
    required this.controller,
    required this.inputType,
    required this.hintText,
    this.validator,
    this.isPassword = false,
    this.obscureText = false,
    this.isDateField = false, // Default: Not a date field
    this.enabled = true,
    this.isFutureDisabled = false,
    this.onDateSelected

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),

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
        TextFormField(
          controller: controller,

          keyboardType: inputType,
          validator: validator,
          obscureText: obscureText,
          readOnly: isDateField || !enabled, // ✅ Prevent manual input for date fields
          onTap:  (isDateField && enabled) ? () => _selectDate(context) : null, // ✅ Open Date Picker
          decoration: InputDecoration(
            fillColor: enabled?Colors.transparent:AppColor.grey4,
            filled: true,
            hintText: hintText,
            hintStyle:TextStyle(
              color: AppColor.grey700

            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColor.borderColor, width: 1.5),
            ),
            suffixIcon: isDateField
                ? Icon(Icons.calendar_today, size: 15,color: AppColor.grey2) // ✅ Add Calendar Icon
                : null,
          ),
        ),

        SizedBox(height: 20),
      ],
    );
  }

  /// Date Picker Function
  Future<void> _selectDate(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1900),
      lastDate: isFutureDisabled ? now : DateTime(2100), // ✅ Conditional max date
    );

    if (pickedDate != null) {
      controller.text = DateFormat("yyyy-MM-dd").format(pickedDate);
      print("pick date===>${controller.text}");
      onDateSelected?.call();
    }
  }
}
