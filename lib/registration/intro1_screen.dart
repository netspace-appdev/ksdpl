/*


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:ksdpl/common/helper.dart';

import 'package:flutter/material.dart';

import '../common/storage_service.dart';

class Intro1Screen extends StatefulWidget {
  @override
  State<Intro1Screen> createState() => _Intro1ScreenState();
}

class _Intro1ScreenState extends State<Intro1Screen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the Home Screen after 3 seconds
    Timer(const Duration(seconds: 3), () {
      onLoad();

    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(

        body: Stack(
          children: [
            // Intro image at the bottom
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                AppImage.intro1, // Replace with your image path
                fit: BoxFit.fitWidth,
                width: double.infinity, // Ensures it takes full width
              ),
            ),
            // Logo positioned 40px above the intro image
            Positioned(
              top: MediaQuery.of(context).size.height * 0.10, // Adjust this for fine-tuning
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset(
                  AppImage.logo1, // Replace with your image path
                  height: 55,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  onLoad(){
    var userId=StorageService.get(StorageService.USER_ID);
    if(userId!=null){
      Get.offAllNamed("/bottomNavbar");
    }else{
      Get.offAllNamed("/login");
    }

  }
}
*/
