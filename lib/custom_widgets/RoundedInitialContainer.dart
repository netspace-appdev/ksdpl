import 'package:flutter/material.dart';
import 'package:ksdpl/common/helper.dart';

class RoundedInitialContainer extends StatelessWidget {
  final String firstName;

  const RoundedInitialContainer({Key? key, required this.firstName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70, // Adjust size as needed
      height: 70,
      decoration: BoxDecoration(
        color: Colors.yellow,
        shape: BoxShape.circle,
        border: Border.all(color: AppColor.appWhite, width: 2),
      ),
      alignment: Alignment.center,
      child: Text(
        firstName.isNotEmpty ? firstName[0].toUpperCase() : "U",
        style: TextStyle(
          color: AppColor.primaryColor,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}