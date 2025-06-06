import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../common/validation_helper.dart';
import '../../controllers/lead_dd_controller.dart';
import '../../controllers/product/add_product_controller.dart';
import '../../custom_widgets/CustomChipTextfield.dart';
import '../../custom_widgets/CustomDropdown.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';
import 'package:ksdpl/models/dashboard/GetAllBankModel.dart' as bank;
import 'package:ksdpl/models/dashboard/GetAllBranchBIModel.dart' as bankBrach;
import '../../custom_widgets/CustomMultiSelectDropdown.dart';
import '../../custom_widgets/CustomOptionalChipTextField.dart';
import '../../custom_widgets/CustomTextArea.dart';
import '../../custom_widgets/CustomTextLabel.dart';
import '../../models/product/GetAllCommonDocumentModel.dart' as commanDoc;

class Step4FormProduct extends StatelessWidget {
  final addProductController = Get.find<AddProductController>();
  LeadDDController leadDDController = Get.put(LeadDDController());

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Obx((){
        if( addProductController.isLoadingMainScreen.value)
          return Center(
            child: CustomSkelton.productShimmerList(context),
          );
        return Form(
          key: addProductController.stepFormKeys[3],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(
                height: 20,
              ),
              CustomTextLabel(
                label: AppText.documents,



              ),

              const SizedBox(height: 10),



              Obx(() {
                final values = addProductController.selectedCommonDoc.toList(); // List<negProfile.Data>
                final commonDocList = addProductController.commonDocList.toList();

                final isAllSelected = Set.from(values.map((e) => e.id)).containsAll(commonDocList.map((e) => e.id));
                final controlOption = commanDoc.Data(id: -1, commonDocument1: isAllSelected ? "Deselect All" : "Select All");

                final allItems = [controlOption, ...commonDocList];

                return MultiSelectDropdown<commanDoc.Data>(
                  key: ValueKey(values.map((e) => e.id).join(',')), // Stable key
                  items: allItems,
                  getId: (e) => e.id.toString(),
                  getName: (e) => e.commonDocument1 ?? 'Unknown',
                  selectedValues: values.where((e) => e.id != -1).toList(), // exclude control option from selection
                  onChanged: (selectedList) {
                    if (selectedList.any((e) => e.id == -1 && e.commonDocument1 == "Select All")) {
                      addProductController.selectedCommonDoc.assignAll(commonDocList);
                    } else if (selectedList.any((e) => e.id == -1 && e.commonDocument1 == "Deselect All")) {
                      addProductController.selectedCommonDoc.clear();
                    } else {
                      addProductController.selectedCommonDoc.assignAll(
                        selectedList.where((e) => e.id != -1),
                      );
                    }
                  },
                );
              }),


              const SizedBox(
                height: 20,
              ),

              CustomTextLabel(
                label: AppText.additionalDocuments,



              ),

              const SizedBox(height: 10),


              CustomOptionalChipTextField(
                textController: addProductController.chipText3Controller,
                initialTags: addProductController.selectedAdditionalDocs,
                hintText: AppText.negativeProfilesHint,
                onChanged: (tags) {
                  print("Updated tags: $tags");
                  addProductController.selectedAdditionalDocs = tags;
                },
              ),


              const SizedBox(height: 20),
              CustomTextLabel(
                label: AppText.productDescriptions,



              ),

              const SizedBox(height: 20),
              CustomTextArea(
                label: AppText.writeYourContent,
                controller: addProductController.prodProductDescriptionsController,
                maxLines: 5, // Increase lines if needed
                validator: (value) => value!.isEmpty ? "Please enter some text" : null,


              ),

             /* Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                  *//*  QuillToolbar.basic(
                      controller: _controller,
                      multiRowsDisplay: false,
                      showAlignmentButtons: true,
                      showFontSize: true,
                      showCodeBlock: true,
                      showColorButton: true,
                      showBackgroundColorButton: true,
                      showImageButton: true,
                      showVideoButton: false, // optional
                    ),*//*
                    SizedBox(height: 10),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: QuillEditor.basic(
                          controller: _controller,
                          // readOnly: false,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        final content = jsonEncode(_controller.document.toDelta().toJson());
                        print("🔹 Saved Content (Delta):\n$content");
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Content saved to console!")));
                      },
                      child: Text('Save Description'),
                    )
                  ],
                ),
              )*/

            ],
          ),
        );
      }),
    );
  }
  Widget _buildRadioOption(String gender) {
    return Row(
      children: [
        Radio<String>(
          value: gender,
          groupValue: addProductController.selectedGender.value,
          onChanged: (value) {
            addProductController.selectedGender.value=value;
          },
        ),
        Text(gender),
      ],
    );
  }
}
