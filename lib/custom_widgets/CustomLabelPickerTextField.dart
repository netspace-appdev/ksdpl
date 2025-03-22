import 'package:flutter/material.dart';

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
  final bool isDateField; // ✅ New parameter to check if it's a date field

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
          readOnly: isDateField, // ✅ Prevent manual input for date fields
          onTap: isDateField ? () => _selectDate(context) : null, // ✅ Open Date Picker
          decoration: InputDecoration(
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
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      controller.text = "${pickedDate.month}-${pickedDate.day}-${pickedDate.year}"; // ✅ Format Date
    }
  }
}
