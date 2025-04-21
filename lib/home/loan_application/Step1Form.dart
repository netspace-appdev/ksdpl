import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/leads/loan_appl_controller.dart';
class Step1Form extends StatelessWidget {
  final loanApplicationController = Get.find<LoanApplicationController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Full Name"),
          TextFormField(
            controller: loanApplicationController.fullNameController,
            decoration: InputDecoration(
              hintText: 'Enter your full name',
            ),
          ),
          SizedBox(height: 10),
          Text("Father's Name"),
          TextFormField(
            controller: loanApplicationController.fatherNameController,
            decoration: InputDecoration(
              hintText: "Enter father's name",
            ),
          ),
          // add more fields as needed...
        ],
      ),
    );
  }
}
