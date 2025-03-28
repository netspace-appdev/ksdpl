import 'package:flutter/material.dart';

import '../common/helper.dart';

class CustomLabeledTimePickerTextField extends StatelessWidget {
  final String label;
  final bool isRequired;
  final TextEditingController controller;
  final TextInputType inputType;
  final String hintText;
  final String? Function(String?)? validator;
  final bool isPassword;
  final bool obscureText;
  final bool isTimeField; // ✅ New parameter for time picker
  final bool enabled;
  const CustomLabeledTimePickerTextField({
    Key? key,
    required this.label,
    this.isRequired = false,
    required this.controller,
    required this.inputType,
    required this.hintText,
    this.validator,
    this.isPassword = false,
    this.obscureText = false,
    this.isTimeField = false, // Default: Not a time field
    this.enabled = true, // ✅ Default enabled
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
          readOnly: isTimeField || !enabled,  // ✅ Prevent manual input for time fields
          onTap: (isTimeField && enabled) ? () => _selectTime(context) : null, // ✅ Open Time Picker
          decoration: InputDecoration(
            fillColor: enabled?Colors.transparent:AppColor.grey4,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: AppColor.grey700),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColor.borderColor, width: 1.5),
            ),
            suffixIcon: isTimeField
                ? Icon(Icons.access_time, size: 18, color: AppColor.grey2) // ✅ Clock Icon
                : null,
          ),
        ),

        SizedBox(height: 20),
      ],
    );
  }

  /// Time Picker Function
  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      //initialEntryMode: TimePickerEntryMode.dial,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
     // controller.text = pickedTime.format(context); // ✅ Format Time

      int hour = pickedTime.hourOfPeriod ; // Convert 0 to 12 for AM
      String minute = pickedTime.minute.toString(); // Ensure 2-digit minutes
      String period = pickedTime.period == DayPeriod.am ? "AM" : "PM"; // Determine AM/PM

      String formattedTime = "$hour:$minute $period";

      controller.text = formattedTime;

    }
  }
}
