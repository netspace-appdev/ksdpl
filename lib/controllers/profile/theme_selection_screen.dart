/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lender_mrb/controllers/profile/them_controller.dart';


class ThemeSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Scaffold(
      appBar: AppBar(title: Text('Select Theme')),
      body: Column(
        children: [
          ListTile(
            title: Text("Light Theme"),
            leading: Obx(() => Radio(
              value: ThemeMode.light,
              groupValue: themeController.themeMode.value,
              onChanged: (value) => themeController.changeTheme(ThemeMode.light),
            )),
            onTap: () => themeController.changeTheme(ThemeMode.light),
          ),
          ListTile(
            title: Text("Dark Theme"),
            leading: Obx(() => Radio(
              value: ThemeMode.dark,
              groupValue: themeController.themeMode.value,
              onChanged: (value) => themeController.changeTheme(ThemeMode.dark),
            )),
            onTap: () => themeController.changeTheme(ThemeMode.dark),
          ),
          ListTile(
            title: Text("System Default"),
            leading: Obx(() => Radio(
              value: ThemeMode.system,
              groupValue: themeController.themeMode.value,
              onChanged: (value) => themeController.changeTheme(ThemeMode.system),
            )),
            onTap: () => themeController.changeTheme(ThemeMode.system),
          ),
        ],
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksdpl/controllers/profile/change_password_controller.dart';
import 'package:ksdpl/controllers/profile/them_controller.dart';
import '../../common/helper.dart';



class ThemeSelectionScreen extends StatelessWidget {



  final ChangePasswordController changePasswordController =Get.put(ChangePasswordController());

  //No use start


  // no use end
  final ThemeController themeController = Get.find();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(


          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back,  color:AppColor.secondaryColor),
            ),
          ),
          title: Text(AppText.changeTheme, style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: AppColor.appWhite,
          ),),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.center,
                  colors: <Color>[AppColor.primaryColor, AppColor.primaryColor]),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  title: Text("Light Theme"),
                  leading: Obx(() => Radio(
                    value: ThemeMode.light,
                    groupValue: themeController.themeMode.value,
                    onChanged: (value) => themeController.changeTheme(ThemeMode.light),
                  )),
                  onTap: () => themeController.changeTheme(ThemeMode.light),
                ),
                ListTile(
                  title: Text("Dark Theme"),
                  leading: Obx(() => Radio(
                    value: ThemeMode.dark,
                    groupValue: themeController.themeMode.value,
                    onChanged: (value) => themeController.changeTheme(ThemeMode.dark),
                  )),
                  onTap: () => themeController.changeTheme(ThemeMode.dark),
                ),
                ListTile(
                  title: Text("System Default"),
                  leading: Obx(() => Radio(
                    value: ThemeMode.system,
                    groupValue: themeController.themeMode.value,
                    onChanged: (value) => themeController.changeTheme(ThemeMode.system),
                  )),
                  onTap: () => themeController.changeTheme(ThemeMode.system),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }





}
