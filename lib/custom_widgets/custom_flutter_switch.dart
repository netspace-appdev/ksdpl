import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../common/helper.dart';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class CustomFlutterSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onToggle;

  const CustomFlutterSwitch({
    Key? key,
    required this.value,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      width: 60.0,
      height: 30.0,
      toggleSize: 30.0,
      borderRadius: 20.0,
      padding: 5.0,
      activeColor: AppColor.primaryColor,
      inactiveColor: Colors.grey,
      activeIcon: Icon(Icons.check, color: Colors.black),
      inactiveIcon: Icon(Icons.close, color: Colors.black),
      value: value,
      onToggle: onToggle,
    );
  }
}

