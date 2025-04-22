import 'package:flutter/material.dart';

import '../common/helper.dart';

class CustomTextLabel extends StatelessWidget {
  final String label;
  final bool isRequired;

  const CustomTextLabel({
    super.key,
    required this.label,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColor.grey2,
          ),
        ),
        if (isRequired)
          const Text(
            ' *',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColor.redColor,
            ),
          ),
      ],
    );
  }
}
