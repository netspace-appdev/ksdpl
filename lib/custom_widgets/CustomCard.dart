import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final Color borderColor;
  final double borderRadius;
  final double borderWidth;
  final Color backgroundColor;
  final double elevation;

  const CustomCard({
    Key? key,
    required this.child,
    this.borderColor = Colors.grey,
    this.borderRadius = 10.0,
    this.borderWidth = 1.0,
    this.backgroundColor = Colors.white,
    this.elevation = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: BorderSide(
          color: borderColor,
          width: borderWidth,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}
