import 'package:flutter/material.dart';

import 'helper.dart';




class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search, color: AppColor.lightGrey,),
        hintText: AppText.search,
        hintStyle: TextStyle(color: AppColor.lightGrey),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
        filled: true
      ),
      onChanged: (value) {
        // Add search functionality here
        print('Searching for: $value');
      },
    );
  }
}


