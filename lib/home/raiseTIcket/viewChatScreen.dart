import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ksdpl/common/base_url.dart';
import 'package:ksdpl/models/raiseTicketModel/ViewChatDetailModel.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../common/skelton.dart';
import '../../controllers/FilePickerController.dart';
import '../../custom_widgets/CustomMessageTextField.dart';
import '../../custom_widgets/CustomTextField.dart';
import '../../custom_widgets/commonActionButton.dart';
import '../../common/helper.dart';
import '../../common/validation_helper.dart';
import '../../controllers/ticketControllers/viewChatController.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';

class ViewChatScreen extends StatelessWidget {
  //const ViewChatScreen({super.key});

  ViewChatController viewChatController = Get.find();
  final FilePickerController filePickerController = FilePickerController();

  // filePicker = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: Stack(
          children: [
            Form(
              key: viewChatController.formKey,
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
                              colors: [
                                AppColor.primaryLight,
                                AppColor.primaryDark
                              ],
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
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
                          alignment: Alignment.topCenter, // Centers it
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                              margin: EdgeInsets.only(top: 90),
                              // <-- Moves it 30px from top
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 30),
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
                                    childrenPadding:
                                    EdgeInsets.symmetric(horizontal: 20),
                                    title: const Text(
                                      AppText.ticketInfo,
                                      style: TextStyle(
                                          color: AppColor.blackColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    leading: Image.asset(
                                      AppImage.message,
                                      height: 20,
                                    ),
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        // Prevents extra spacing
                                        children: [
                                          CustomLabeledTextField(
                                            label: AppText.ticketNo,
                                            isRequired: false,
                                            isInputEnabled: false,
                                            controller: viewChatController
                                                .ticketNoController,
                                            inputType: TextInputType.name,
                                            hintText: '',
                                            validator: ValidationHelper
                                                .validateSubject,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          CustomLabeledTextField(
                                            label: AppText.subject,
                                            isRequired: false,
                                            isInputEnabled: false,
                                            controller: viewChatController
                                                .subjectController,
                                            inputType: TextInputType.name,
                                            hintText: '',
                                            validator: ValidationHelper
                                                .validateSubject,
                                          ),
                                          CustomLabeledTextField(
                                            label: AppText.status,
                                            isRequired: false,
                                            isInputEnabled: false,
                                            controller: viewChatController.statusController,
                                            inputType: TextInputType.name,
                                            hintText: '',
                                            validator: ValidationHelper
                                                .validateSubject,
                                          ),
                                          CustomLabeledTextField(
                                            label: AppText.userName,
                                            isRequired: false,
                                            isInputEnabled: false,
                                            controller: viewChatController
                                                .userNameController,
                                            inputType: TextInputType.name,
                                            hintText: '',
                                            validator: ValidationHelper
                                                .validateSubject,
                                          ),
                                          CustomLabeledTextField(
                                            label: AppText.category,
                                            isRequired: false,
                                            isInputEnabled: false,
                                            controller: viewChatController
                                                .categoryController,
                                            inputType: TextInputType.name,
                                            hintText: '',
                                            validator: ValidationHelper
                                                .validateSubject,
                                          ),
                                          CustomLabeledTextField(
                                            label: AppText.priority,
                                            isRequired: false,
                                            isInputEnabled: false,
                                            controller: viewChatController.priorityController,
                                            inputType: TextInputType.name,
                                            hintText: '',
                                            validator: ValidationHelper
                                                .validateSubject,
                                          ),
                                          Obx(() => Padding(
                                            padding: const EdgeInsets.all(0),
                                            child: viewChatController
                                                .isStatusUpdating.value
                                                ? const Center(
                                              child:
                                              CircularProgressIndicator(
                                                  color: AppColor.primaryColor),
                                            )
                                                : Center(
                                                  child: CommonActionButton(
                                                                                                text: viewChatController.viewChatDetailModel.value?.data?.status=="3"?
                                                                                                AppText.close: AppText.ReClose,
                                                                                                icon: Icons.refresh,
                                                                                                onPressed: () {
                                                  viewChatController.statusUpdateTicketApiRequest(
                                                    TicketNo: viewChatController.viewChatDetailModel.value?.data?.ticketNo.toString() ?? '',
                                                    status: viewChatController.viewChatDetailModel.value?.data?.status
                                                        .toString() ??
                                                        '',
                                                    PanelId: viewChatController
                                                        .viewChatDetailModel
                                                        .value
                                                        ?.data
                                                        ?.panelId
                                                        .toString() ??
                                                        '',
                                                  );
                                                                                                },
                                                                                              ),
                                                ),
                                          )),
                                          const SizedBox(
                                            height: 20,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Obx(() {
                                    if (viewChatController
                                        .isLoadingValue.value) {
                                      return Center(
                                        child: CustomSkelton.productShimmerList(
                                            context),
                                      );
                                    }

                                    final messages = viewChatController
                                        .viewChatDetailModel
                                        .value
                                        ?.data
                                        ?.message ??
                                        [];

                                    if (messages.isEmpty) {
                                      return const Padding(
                                        padding:
                                        EdgeInsets.symmetric(vertical: 30),
                                        child: Text(
                                          AppText.noData,
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      );
                                    }
                                    ();

                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                      const NeverScrollableScrollPhysics(),
                                      itemCount: messages.length,
                                      itemBuilder: (context, index) {
                                        return _messageBubble(
                                            messages[index], context);
                                      },
                                    );
                                  }),
                                  const SizedBox(
                                    height: 50,
                                  ),
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Obx(() {
                      final file = viewChatController.selectedFile.value;
                      if (file == null) return const SizedBox();

                      return SelectedAttachmentPreview(
                        file: file,
                        onRemove: () {
                          viewChatController.selectedFile.value = null;
                        },
                      );
                    }),
                    Obx(() {
                      if (viewChatController.isLoadingValue1.value) {
                        return const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        );
                      }
                      return CustomMessageTextField(
                        controller: viewChatController.messageController,
                        hasAttachment:
                        viewChatController.selectedFile.value != null,
                        onImageTap: () {
                          getFile();
                        },
                        onSendTap: () {
                          viewChatController.sendMessageApiRequest(
                              image: viewChatController.selectedFile.value,
                              ticketId: viewChatController
                                  .viewChatDetailModel.value?.data?.id
                                  .toString() ??
                                  '',
                              message: viewChatController
                                  .messageController.text
                                  .trim()
                                  .toString());

                          print(viewChatController.messageController.text);

                          // filePickerController.clear();
                        },
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget header(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
              padding: const EdgeInsets.all(12),
              // optional internal padding
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
                fontWeight: FontWeight.w700),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.filter_alt_outlined,
                  color: Colors.transparent,
                ),
              ),
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
    return InkWell(
      onTap: () {
        showDialog(
          context: Get.context!,
          barrierDismissible: true,
          builder: (_) => Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(16),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                /// 📷 Image (Centered)
                InteractiveViewer(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      url,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                /// ❌ Close button (Top Right)
                Positioned(
                  top: -40, // 🔥 move icon upward
                  right: 30,
                  child: InkWell(
                    onTap: () => Get.back(),
                    child: const CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.black54,
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          url,
          height: 80,
          width: 80,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const SizedBox(
              height: 30,
              width: 30,
              child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.broken_image, size: 30);
          },
        ),
      ),
    );
  }

  Widget _messageBubble(Message data, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Align(
        alignment: Alignment.centerRight, // or left for receiver
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if ((data.messageText ?? '').isNotEmpty)
                  Text(
                    data.messageText!,
                    softWrap: true,
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
        ),
      ),
    );
  }

  Future<void> getFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      viewChatController.selectedFile.value = File(result.files.single.path!);

      debugPrint(
        'Picked file: ${viewChatController.selectedFile.value!.path}',
      );
    }
  }
}

class SelectedAttachmentPreview extends StatelessWidget {
  final File file;
  final VoidCallback onRemove;

  const SelectedAttachmentPreview({
    super.key,
    required this.file,
    required this.onRemove,
  });

  bool get isImage {
    final ext = file.path.toLowerCase();
    return ext.endsWith('.png') ||
        ext.endsWith('.jpg') ||
        ext.endsWith('.jpeg') ||
        ext.endsWith('.webp');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          isImage
              ? ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(
              file,
              width: 48,
              height: 48,
              fit: BoxFit.cover,
            ),
          )
              : const Icon(Icons.insert_drive_file, size: 40),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              file.path.split('/').last,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          InkWell(
            onTap: onRemove,
            child: const Icon(Icons.close, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
