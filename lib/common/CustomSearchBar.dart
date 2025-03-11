import 'package:flutter/material.dart';
import 'package:ksdpl/common/helper.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String hintText;

  const CustomSearchBar({
    Key? key,
    required this.controller,
    this.onChanged,
    this.hintText = "Search...",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,

        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 12),
          hintText: hintText,
          border: InputBorder.none,
           prefixIcon: Icon(Icons.search,color: Colors.grey[600]),
         // prefixIcon: Image.asset(AppImage.searchIcon2,height: 25,),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
            icon: Icon(Icons.clear, color: Colors.grey[600]),
            onPressed: () => controller.clear(),
          )
              : null,
        ),
      ),
    );
  }
}
