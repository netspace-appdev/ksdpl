import 'package:flutter/material.dart';

import '../common/helper.dart';

class CustomMaskedIdTextWidget extends StatelessWidget {
  final String? value; // nullable
  final TextStyle? textStyle;
  final String label;

  const CustomMaskedIdTextWidget({
    Key? key,
    required this.label,
    this.value,
    this.textStyle,
  }) : super(key: key);

  String _maskValue(String input) {
    if (input.length <= 4) return input;

    final maskedLength = input.length - 4;
    return '*' * maskedLength + input.substring(input.length - 4);
  }

  @override
  Widget build(BuildContext context) {
    final bool isInvalid =
        value == null || value!.isEmpty || value == '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:  TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: AppColor.primaryColor
          ),
        ),
        const SizedBox(height: 4),
        Text(
          isInvalid ? ' ' : _maskValue(value!),
          style: textStyle ??
              const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
        ),
      ],
    );
  }
}
