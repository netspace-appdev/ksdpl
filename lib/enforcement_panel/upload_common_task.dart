
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ksdpl/controllers/enforcement_panel/upload_common_task_controller.dart';

import '../../common/helper.dart';




class UploadCommonTask extends StatelessWidget {



  // no use end
  UploadCommonTaskController uploadCommonTaskController=Get.put(UploadCommonTaskController());
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
          title: Text("Upload Common Task", style: Theme.of(context).textTheme.titleMedium!.copyWith(
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
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Text(AppText.uctList, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),

                      const SizedBox(height: 10),

                      const SizedBox(height: 10),
                      Obx((){
                        return Center(
                          child: Card(
                            elevation: 4,
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,

                                children: [
                                  Icon(
                                    Icons.insert_drive_file,
                                    color: Colors.blue,
                                    size: 64,
                                  ),
                                  SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(AppText.uploadExcel, style: TextStyle(color: AppColor.blackColor, fontWeight: FontWeight.bold, fontSize: 20 ),),
                                      Text("*", style: TextStyle(color: AppColor.redColor, fontWeight: FontWeight.bold, fontSize: 20 ),),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    AppText.chooseExcel,
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 16),
                                  if (uploadCommonTaskController.selectedFile.value != null) ...[
                                    SizedBox(height: 16),
                                    Text(
                                      AppText.selectedFile,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      uploadCommonTaskController.selectedFile.value!.path.split('/').last,
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),
                                  ]
                                  else ...[
                                    SizedBox(height: 16),
                                    Text(
                                      AppText.noFileChosen,
                                      style: TextStyle(fontWeight: FontWeight.bold, ),
                                    ),
                                    SizedBox(height: 4),

                                  ],
                                  SizedBox(height: 16),
                                  ElevatedButton.icon(
                                    onPressed:(){
                                      uploadCommonTaskController.pickExcelFile();
                                    },
                                    icon: Icon(Icons.file_upload),
                                    label: Text(AppText.chooseFile),
                                    style: ElevatedButton.styleFrom(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Clear Button
                          OutlinedButton.icon(
                            onPressed: (){
                              uploadCommonTaskController.clearFile();
                            },
                            icon: Icon(Icons.change_circle_rounded, color: Colors.white),
                            label: Text('Clear',style: TextStyle(color: AppColor.appWhite),),
                            style: OutlinedButton.styleFrom(
                             // side: BorderSide(color: Colors.red),
                              backgroundColor: AppColor.primaryColor,
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          // Submit Button
                          ElevatedButton.icon(
                            onPressed: (){

                            },
                            icon: Icon(Icons.check_circle, color: Colors.white),
                            label: Text('Submit',style: TextStyle(color: AppColor.appWhite),),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primaryColor,
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(AppText.preview, style: TextStyle(color: AppColor.blackColor, fontWeight: FontWeight.bold, fontSize: 20 ),),





                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
