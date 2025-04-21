import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/leads/loan_appl_controller.dart';
class Step2Form extends StatelessWidget {
  final loanApplicationController = Get.find<LoanApplicationController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Qualification"),
          TextFormField(
            controller: loanApplicationController.qualiController,
            decoration: InputDecoration(
              hintText: 'Enter your full name',
            ),
          ),
          SizedBox(height: 10),
          Text("Marital"),
          TextFormField(
            controller: loanApplicationController.maritalController,
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
