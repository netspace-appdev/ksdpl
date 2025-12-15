import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class MultiPackageModelController {
  var selectedPackageMulti = Rxn<int>();
  var multiPackageStatus = Rxn<String>();
  var canBeDeleted = Rxn<bool>();
  final TextEditingController camPackageAmtMultiController = TextEditingController();
  final TextEditingController camReceivableAmtMultiController = TextEditingController();
  final TextEditingController camReceivableDateMultiController = TextEditingController();
  final TextEditingController camTransactionDetailsUtrMultiController = TextEditingController();
  final TextEditingController camRemarkMultiController = TextEditingController();
}