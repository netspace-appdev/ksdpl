import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ksdpl/common/helper.dart';
import 'package:shimmer/shimmer.dart';

import '../common/storage_service.dart';
import '../custom_widgets/RoundedInitialContainer.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
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
                  RoundedInitialContainer(firstName: firstName,),
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
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.pop(context);
              // Add your navigation logic here
            },
          ),

          ExpansionTile(
            childrenPadding: EdgeInsets.symmetric(horizontal: 20),
              title: Text(AppText.manageProfile),
            leading: const Icon(Icons.person),
            children: [
               ListTile(

                leading:  Icon(Icons.edit,color: Theme.of(context).brightness == Brightness.dark?Colors.white54:AppColor.black54),
                title:  Text("Edit profile", style: TextStyle(color:Theme.of(context).brightness == Brightness.dark?Colors.white54: AppColor.black54),),
                onTap: () {
                //  Get.toNamed("/editProfile");
                },
              ),
              ListTile(
                leading:  Icon(Icons.lock,color:Theme.of(context).brightness == Brightness.dark?Colors.white54: AppColor.black54),
                title:  Text(AppText.changePassword,style: TextStyle(color:Theme.of(context).brightness == Brightness.dark?Colors.white54: AppColor.black54),),
                onTap: () {
                //  Get.toNamed("/changePassword");
                },
              ),
            /*  ListTile(
                leading:  Icon(Icons.contrast,color:Theme.of(context).brightness == Brightness.dark?Colors.white54: AppColor.black54),
                title:  Text(AppText.changeTheme,style: TextStyle(color:Theme.of(context).brightness == Brightness.dark?Colors.white54: AppColor.black54),),
                onTap: () {
                  Get.toNamed("/themeSelection");
                },
              ),*/
            ],
          ),


          ExpansionTile(
            childrenPadding: EdgeInsets.symmetric(horizontal: 20),
            title: Text(AppText.leads),
            leading: const Icon(Icons.people),
            children: [
              ListTile(

                leading:  Icon(Icons.format_list_bulleted_outlined,color: Theme.of(context).brightness == Brightness.dark?Colors.white54:AppColor.black54),
                title:  Text(AppText.leadList, style: TextStyle(color:Theme.of(context).brightness == Brightness.dark?Colors.white54: AppColor.black54),),
                onTap: () {
               //   Get.toNamed("/leadListScreen");
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
