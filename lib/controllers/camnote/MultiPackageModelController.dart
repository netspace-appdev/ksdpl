import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class MultiPackageModelController {
  var selectedPackageMulti = Rxn<int>();
  final TextEditingController camPackageAmtMultiController = TextEditingController();
  final TextEditingController camReceivableAmtMultiController = TextEditingController();
  final TextEditingController camReceivableDateMultiController = TextEditingController();
  final TextEditingController camTransactionDetailsUtrMultiController = TextEditingController();
  final TextEditingController camRemarkMultiController = TextEditingController();
}