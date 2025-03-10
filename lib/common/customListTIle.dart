import 'package:flutter/material.dart';
import 'package:ksdpl/common/helper.dart';


class CustomListTile extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback onTap;
  final bool showTrailing;

  const CustomListTile({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.onTap,
    this.showTrailing = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(imagePath, height: 20),
      title: Text(title, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
      trailing: showTrailing ? Image.asset(AppImage.forwardIcon, height: 14,) : null,
      onTap: onTap,
    );
  }
}
