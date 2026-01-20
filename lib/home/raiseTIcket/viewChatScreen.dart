import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ksdpl/common/base_url.dart';
import 'package:ksdpl/models/raiseTicketModel/ViewChatDetailModel.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../common/skelton.dart';
import '../../custom_widgets/CustomMessageTextField.dart';
import '../../custom_widgets/commonActionButton.dart';
import '../../common/helper.dart';
import '../../common/validation_helper.dart';
import '../../controllers/ticketControllers/viewChatController.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';

class ViewChatScreen extends StatelessWidget {
  //const ViewChatScreen({super.key});

  ViewChatController viewChatController = Get.find();


  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: Stack(
          children: [
            Form(
              key:  viewChatController.formKey ,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        // Gradient Background
                        Container(
                          height: MediaQuery.of(context).size.height * 0.9,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppColor.primaryLight, AppColor.primaryDark],
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child:Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              header(context),
                            ],
                          ),
                        ),
                        // White Container
                        Align(
                          alignment: Alignment.topCenter,  // Centers it
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                              margin:  EdgeInsets.only(top:90 ), // <-- Moves it 30px from top
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                              decoration: const BoxDecoration(
                                color: AppColor.backgroundColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(45),
                                  topRight: Radius.circular(45),
                                ),

                              ),

                              child: Column(
                                children: [
                                  ExpansionTile(
                                    childrenPadding: EdgeInsets.symmetric(horizontal: 20),
                                    title:const Text(AppText.viewChat, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                                    leading: Image.asset(AppImage.message, height: 20,),
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min, // Prevents extra spacing
                                        children: [
                                          CustomLabeledTextField(
                                            label: AppText.ticketNo,
                                            isRequired: false,
                                            isInputEnabled: false,

                                            controller: viewChatController.ticketNoController,
                                            inputType: TextInputType.name,
                                            hintText: '',
                                            validator:  ValidationHelper.validateSubject,
                                          ),

                                          SizedBox(height: 5,),

                                          CustomLabeledTextField(
                                            label: AppText.subject,
                                            isRequired: false,
                                            isInputEnabled: false,

                                            controller: viewChatController.subjectController,
                                            inputType: TextInputType.name,
                                            hintText: '',
                                            validator:  ValidationHelper.validateSubject,
                                          ),

                                          CustomLabeledTextField(
                                            label: AppText.status,
                                            isRequired: false,
                                            isInputEnabled: false,
                                            controller: viewChatController.statusController,
                                            inputType: TextInputType.name,
                                            hintText: '',
                                            validator:  ValidationHelper.validateSubject,
                                          ),

                                          CustomLabeledTextField(
                                            label: AppText.userName,
                                            isRequired: false,
                                            isInputEnabled: false,
                                            controller: viewChatController.userNameController,
                                            inputType: TextInputType.name,
                                            hintText: '',
                                            validator:  ValidationHelper.validateSubject,
                                          ),
                                          CustomLabeledTextField(
                                            label: AppText.category,
                                            isRequired: false,
                                            isInputEnabled: false,

                                            controller: viewChatController.categoryController,
                                            inputType: TextInputType.name,
                                            hintText: '',
                                            validator:  ValidationHelper.validateSubject,
                                          ),
                                          CustomLabeledTextField(
                                            label: AppText.priority,
                                            isRequired: false,
                                            isInputEnabled: false,
                                            controller: viewChatController.priorityController,
                                            inputType: TextInputType.name,
                                            hintText: '',
                                            validator:  ValidationHelper.validateSubject,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 148.0),
                                            child: CommonActionButton(
                                              text: AppText.close,
                                              icon: Icons.refresh,
                                              onPressed: () {

                                              },
                                            ),
                                          ),
                                          SizedBox(height: 20,)
                                        ],
                                      ),

                                    ],
                                  ),
                                  Obx(() {
                                    if (viewChatController.isLoadingValue.value) {
                                      return Center(child: CustomSkelton.productShimmerList(context));
                                    }
                                    final messages = viewChatController
                                        .viewChatDetailModel.value
                                        ?.data
                                        ?.message ??
                                        [];

                                    if (messages.isEmpty) {
                                      return  const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 30),
                                      child: Text(
                                        AppText.noData,
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    );
                                    }
                                    ();

                                    return ListView.builder(
                                      shrinkWrap: true, // 🔥 VERY IMPORTANT
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: messages.length,
                                      itemBuilder: (context, index) {
                                        return _messageBubble(messages[index], context);
                                      },
                                    );
                                  }),
                                  SizedBox(height: 50,),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child:Container(
                decoration: BoxDecoration(
                    color: AppColor.appBlue
                ),
                child: CustomMessageTextField(
                  controller: viewChatController.messageController,
                  onImageTap: () {
                    // open gallery / camera
                  },
                  onSendTap: () {
                    // send message
                  },
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget header(context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(8), // for ripple effect
            onTap: () {
              Get.back();
            },
            child: Container(
              width: 48,
              height: 48,
              padding: const EdgeInsets.all(12), // optional internal padding
              alignment: Alignment.center,
              child: Image.asset(
                AppImage.arrowLeft,
                height: 24,
              ),
            ),
          ),

          const Text(
            AppText.viewChat,
            style: TextStyle(
                fontSize: 20,
                color: AppColor.grey3,
                fontWeight: FontWeight.w700
            ),
          ),

          InkWell(
            onTap: (){

            },
            child: Container(

              width: 40,
              height:40,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration:  const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Center(child: Icon(Icons.filter_alt_outlined, color: Colors.transparent,),),
            ),
          )

        ],
      ),
    );
  }

  Widget _buildMessageAttachment(String imagePath) {
    final String url = '${BaseUrl.imageBaseUrl}$imagePath';

    /// PDF FILE
    if (imagePath.toLowerCase().endsWith('.pdf')) {
      return InkWell(
        onTap: () async {
          final Uri pdfUri = Uri.parse(url);

          if (!await launchUrl(
            pdfUri,
            mode: LaunchMode.externalApplication, // opens in Chrome / Google
          )) {
            throw 'Could not open PDF';
          }
        },
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.red),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.picture_as_pdf, color: Colors.red),
              SizedBox(width: 8),
              Text(AppText.view),
            ],
          ),
        ),
      );
    }

    /// IMAGE FILE
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        url,
        height: 30,
        width: 30,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const SizedBox(
            height: 160,
            child: Center(child: CircularProgressIndicator()),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.broken_image, size: 40);
        },
      ),
    );
  }

  Widget _messageBubble(Message data, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min, // 🔥 KEY
          children: [
            if ((data.messageText ?? '').isNotEmpty)
              Text(
                data.messageText!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColor.primaryColor,
                ),
              ),

            if ((data.image ?? '').isNotEmpty) ...[
              const SizedBox(height: 6),
              _buildMessageAttachment(data.image!),
            ],
          ],
        ),
      ),
    );
  }

}
