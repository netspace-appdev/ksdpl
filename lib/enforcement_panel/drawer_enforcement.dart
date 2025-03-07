import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ksdpl/common/helper.dart';
import 'package:shimmer/shimmer.dart';

import '../common/storage_service.dart';

class DrawerEnforcement extends StatefulWidget {
  const DrawerEnforcement({Key? key}) : super(key: key);

  @override
  State<DrawerEnforcement> createState() => _DrawerEnforcementState();
}

class _DrawerEnforcementState extends State<DrawerEnforcement> {
  String firstName="user";
  String email="user@email.com";
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        padding: EdgeInsets.zero,
        children: [
          // Drawer Header with Profile
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColor.primaryColor,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   ClipOval(
                     child: Helper.CustomCNImage(
                         "",
                         80,
                         80),
                   ),
                  const SizedBox(height: 10),
                   Text(
                     firstName,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                   Text(
                     email,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Navigation Items
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text(AppText.home),
            onTap: () {
              Get.offAllNamed("/bottomNavbar");
            },
          ),

          ExpansionTile(
            childrenPadding: EdgeInsets.symmetric(horizontal: 20),
              title: Text(AppText.manageEnforcement),
            leading: const Icon(Icons.shopping_bag),
            children: [
               ListTile(

                leading:  Icon(Icons.upload,color: Theme.of(context).brightness == Brightness.dark?Colors.white54:AppColor.black54),
                title:  Text(AppText.uploadCommonTask, style: TextStyle(color:Theme.of(context).brightness == Brightness.dark?Colors.white54: AppColor.black54),),
                onTap: () {
                  Get.toNamed("/uploadCommonTask");
                },
              ),

            ],
          ),


          // Logout Button
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              // Add logout logic
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close dialog
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          StorageService.clear();
                          Get.offNamed("/login");
                        },
                        child: const Text('Logout'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  loadData(){
    firstName=StorageService.get(StorageService.FIRST_NAME).toString();
    email=StorageService.get(StorageService.EMAIL).toString();
  }
}
