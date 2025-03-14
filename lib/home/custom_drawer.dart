import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ksdpl/common/helper.dart';
import 'package:shimmer/shimmer.dart';

import '../common/customListTIle.dart';
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

        padding: EdgeInsets.zero,
        children: [

          DrawerHeader(

            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColor.primaryDark, AppColor.primaryLight],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              image: DecorationImage(
                image: AssetImage(AppImage.backDrawer),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 15, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

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
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text(
                           email,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white70,
                          ),
                         ),
                         Padding(
                           padding:  EdgeInsets.only(right: 12.0),
                           child: Image.asset(AppImage.editImage, height: 18, width: 18,),
                         )
                       ],
                     ),
                  ],
                ),
              ),
            ),
          ),
          // Navigation Items
         Padding(
           padding: const EdgeInsets.only(left: 17.0),
           child: Column(
             children: [
               CustomListTile(
                 title:  AppText.home,
                 imagePath:AppImage.home2,
                 onTap: () {
                   Navigator.pop(context);
                   // Add your navigation logic here
                 },

               ),


               /*ExpansionTile(
                 childrenPadding: EdgeInsets.symmetric(horizontal: 20),
                 title: Text(AppText.myProfile),
                 leading: Image.asset(AppImage.manInBlack, height: 20,),
                 children: [
                   ListTile(

                     leading:  Icon(Icons.home,color: Theme.of(context).brightness == Brightness.dark?Colors.white54:AppColor.black54),
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
                 ],
               ),*/

               CustomListTile(
                 title:  AppText.myProfile,
                 imagePath:AppImage.manInBlack,
                 onTap: () {
                   Navigator.pop(context);
                   // Add your navigation logic here
                 },

               ),


               CustomListTile(
                 title:  AppText.leads,
                 imagePath:AppImage.manInBlack,
                 onTap: () {

                   Get.toNamed("/leadListMain");
                 },

               ),

               // Logout Button
               CustomListTile(
                 title:  AppText.logout,
                 imagePath:AppImage.powerIcon,
                 onTap: () {
                   StorageService.clear();
                   Get.offNamed("/login");
                 },

               ),
              
             ],
           ),
         )
        ],
      ),
    );
  }

  loadData(){
    firstName=StorageService.get(StorageService.FIRST_NAME).toString();
    email=StorageService.get(StorageService.EMAIL).toString();
  }
}
