import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CibilGenerateController extends GetxController{

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController camReceivableDateController = TextEditingController();
  final TextEditingController camFullNameController = TextEditingController();
  final TextEditingController camCibilMobController = TextEditingController();
  final TextEditingController camTotalOverdueAmountController = TextEditingController();
  final TextEditingController utrNumberController = TextEditingController();
  final TextEditingController camTransactionDetailsController = TextEditingController();

  void callApi() {
    print("Form is valid");

  }



}