import 'package:flutter/material.dart';
import 'package:ksdpl/common/helper.dart';

class CustomLoadingOverlay extends StatelessWidget {
  final Color backgroundColor;
  final Color loaderColor;

  const CustomLoadingOverlay({
    super.key,
    this.backgroundColor = Colors.black26,
    this.loaderColor = AppColor.secondaryColor, // fallback if AppColor is missing
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child:  Center(
        child: SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(color: loaderColor,),
        ),
      ),
    );
  }
}
