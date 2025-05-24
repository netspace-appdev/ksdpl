
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ksdpl/controllers/product/add_product_controller.dart';
import 'package:ksdpl/controllers/product/product_detail_controller.dart';
import 'package:ksdpl/models/dashboard/GetAllStateModel.dart';
import 'package:ksdpl/models/dashboard/GetDistrictByStateModel.dart' as dist;
import 'package:ksdpl/models/dashboard/GetCityByDistrictIdModel.dart' as city;
import 'package:ksdpl/models/dashboard/GetAllBankModel.dart' as bank;
import 'package:ksdpl/models/dashboard/GetAllKsdplProductModel.dart' as product;
import 'package:ksdpl/models/dashboard/GetProductListByBank.dart' as productBank;
import 'package:ksdpl/models/GetCampaignNameModel.dart' as campaign;
import 'package:ksdpl/models/leads/GetAllKsdplBranchModel.dart' as ksdplBranch;
import 'package:lottie/lottie.dart';
import '../../../common/CustomSearchBar.dart';
import '../../../common/helper.dart';
import '../../../common/skelton.dart';
import '../../../common/validation_helper.dart';
import '../../../controllers/drawer_controller.dart';
import '../../../controllers/greeting_controller.dart';
import '../../../controllers/lead_dd_controller.dart';
import '../../../controllers/leads/addLeadController.dart';
import '../../../controllers/leads/infoController.dart';
import '../../../custom_widgets/CustomDropdown.dart';
import '../../../custom_widgets/CustomLabelPickerTextField.dart';
import '../../../custom_widgets/CustomLabeledTextField.dart';
import '../../common/storage_service.dart';
import '../../controllers/leads/leadlist_controller.dart';
import '../../controllers/open_poll_filter_controller.dart';
import '../../controllers/product/view_product_controller.dart';
import '../../custom_widgets/CustomBigDialogBox.dart';
import '../../custom_widgets/CustomDialogBox.dart';
import '../../custom_widgets/CustomTextFieldPrefix.dart';
import '../custom_drawer.dart';



class ViewProductScreen extends StatelessWidget {





  ViewProductController viewProductController = Get.put(ViewProductController());


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        drawer:   CustomDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  // Gradient Background
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColor.primaryLight, AppColor.primaryDark],
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15),
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
                    child: Container(
                      margin:  EdgeInsets.only(
                          top:90 // MediaQuery.of(context).size.height * 0.22
                      ), // <-- Moves it 30px from top
                      width: double.infinity,
                      //height: MediaQuery.of(context).size.height,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      decoration: const BoxDecoration(
                        color: AppColor.backgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45),
                          topRight: Radius.circular(45),
                        ),

                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min, // Prevents extra spacing
                        children: [
                          const SizedBox(height: 20),
                          productSection(context)
                        ],
                      ),
                    ),
                  ),


                ],
              ),
            ],
          ),
        ),

      ),
    );
  }
  Widget header(context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: (){
                Get.back();
              },
              child: Image.asset(AppImage.arrowLeft,height: 24,)),

          const Text(
            AppText.showProducts,
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
              decoration:  BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),

            ),
          )



        ],
      ),
    );
  }

  Widget _noDataCard(BuildContext context) {
    return Center(
      child: Container(
        height: 160,
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
          color: AppColor.appWhite,
          borderRadius: BorderRadius.circular(10),
          //   border: Border.all(color: AppColor.grey4, width: 1),

        ),
        child:  Center(

          child: Column(
            children: [
              Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Lottie.asset(
                      AppImage.moneyStack,
                      repeat: false
                  )),
              Text(
                  "No Products Found",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.grey1,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget productSection(BuildContext context){
    return Obx((){
      if (viewProductController.isLoading.value) {
        return  Center(child: CustomSkelton.productShimmerList(context));
      }
      if (viewProductController.getAllProductListModel.value == null ||
          viewProductController.getAllProductListModel.value!.data == null || viewProductController.getAllProductListModel.value!.data!.isEmpty) {
        return  Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration:  BoxDecoration(
            border: Border.all(color: AppColor.grey200),
            color: AppColor.appWhite,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),

          ),
          child:  Column(

            children: [
              /// Header with profile and menu icon
              _noDataCard(context)

            ],
          ),
        );
      }

      return  Column(
        children: [
/*
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Products...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (value) {
                viewProductController.searchQuery.value = value;
              },
            ),
          ),

          SizedBox(height: 20,),*/

          ListView.builder(
            itemCount:viewProductController.filteredProducts.length,//viewProductController.getAllProductListModel.value!.data!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              // final product = viewProductController.getAllProductListModel.value!.data![index];
              final product =  viewProductController.filteredProducts[index];



             /* return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration:  BoxDecoration(
                  border: Border.all(color: AppColor.grey200),
                  color: AppColor.appWhite,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),

                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    /// Header with profile and menu icon
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        Helper.capitalizeEachWord( product.product.toString()),

                        // lead.name.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: AppColor.primaryColor
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    /// Lead details
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          _buildDetailRow("Bank Name", product.bankName.toString()),
                          _buildDetailRow("Min. CIBIL", product.minCIBIL.toString()),
                          _buildDetailRow("Product Categorry", product.productCategoryName.toString()),
                          // _buildDetailRow("Uploaded by", lead.uploadedBy.toString()),
                          // _buildDetailRow("City", "Sagwada"),
                        ],
                      ),
                    ),

                    SizedBox(height: 10),

                    /// Bottom Row Buttons (Assigned, Follow Up, Call Back, Employment)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTextButton("Edit", context, Colors.purple, Icons.edit, product.id.toString()),


                        _buildTextButton("Details", context, Colors.pink, Icons.insert_drive_file,product.id.toString()),
                      ],
                    ),
                  ],
                ),
              );*/

              return buildCard(
                Helper.capitalizeEachWord(product.product.toString()), // title
                [
                  _buildDetailRow("Bank Name", product.bankName.toString()),
                  _buildDetailRow("Min. CIBIL", product.minCIBIL.toString()),
                  _buildDetailRow("Product Category", product.productCategoryName.toString()),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTextButton("Edit", context, Colors.purple, Icons.edit, product.id.toString()),
                      _buildTextButton("Details", context, Colors.pink, Icons.insert_drive_file, product.id.toString()),
                    ],
                  ),
                ],
              );

            },
          ),

          if (viewProductController.hasMore.value && viewProductController.filteredProducts.length > 1)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: () {
                  viewProductController.getAllProductListApi(
                      isLoadMore: true
                  );
                },
                child:
                viewProductController.isMainListMoreLoading.value //isDashboardLeadListMoreLoading
                    ? Container(
                    width: 15,
                    height: 15,
                    child: Center(child: CircularProgressIndicator(color: AppColor.primaryColor, strokeWidth: 2,)))
                    : Text("Load More"),
              ),
            ),
        ],
      );
    });
  }

  Widget _buildDetailRow(String label, String value) {
    //   String assigned = value.toString();
//    List<String> assignedParts = assigned.split('T');


    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(
            width: 85,

            child: Text(
              "$label",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColor.primaryLight,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              label=="Assigned" ||  label=="Uploaded on"?": ${ Helper.formatDate(value)}":  ":  ${value=="null"?"":value}",

              style: TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard(String title, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        border: Border.all(color: AppColor.grey4, width: 1),


      ),
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
              color: AppColor.primaryColor, // Blue background
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),

            ),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Content section
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildTextButton(String label, BuildContext context, Color color, IconData icon, String id) {
    return GestureDetector(
      onTap: () {
        if (label == "Details") {
          ProductDetailsController productDetailsController = Get.put(ProductDetailsController());
          productDetailsController.getProductListByIdApi(id: id);
          Get.toNamed("/productDetailScreen");

        }else  if (label == "Edit") {
         AddProductController addProductController = Get.put(AddProductController());


         addProductController.getProductListByIdApi(id: id);
         addProductController.getDocumentListByProductIdApi(productId: id);
         addProductController.getAllProductCategoryApi();
         addProductController.clearForm();
         addProductController.currentStep.value=0;
          Get.toNamed("/editProductScreen");

        }else{

        }
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            width: MediaQuery.of(context).size.width*0.40,

            decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColor.grey700)

            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: AppColor.grey700, size: 20),
                SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColor.blackColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }







/*  void showFilterDialog({
    required BuildContext context,
    required leadId,
  }) {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomBigDialogBox(
          titleBackgroundColor: AppColor.secondaryColor,

          title: "Filter",
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(
                height: 10,
              ),

              const Text(
                AppText.state,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.grey2,
                ),
              ),

              SizedBox(height: 10),


              Obx((){
                if (leadDDController.isStateLoading.value) {
                  return  Center(child:CustomSkelton.leadShimmerList(context));
                }

                return CustomDropdown<Data>(
                  items: leadDDController.getAllStateModel.value?.data ?? [],
                  getId: (item) => item.id.toString(),  // Adjust based on your model structure
                  getName: (item) => item.stateName.toString(),
                  selectedValue: leadDDController.getAllStateModel.value?.data?.firstWhereOrNull(
                        (item) => item.id.toString() == leadDDController.selectedState.value,
                  ),
                  onChanged: (value) {
                    leadDDController.selectedState.value =  value?.id?.toString();
                    leadDDController.getDistrictByStateIdApi(stateId: leadDDController.selectedState.value);
                  },
                );
              }),

              const SizedBox(height: 20),

              const Text(
                AppText.district,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.grey2,
                ),
              ),

              const SizedBox(height: 10),


              Obx((){
                if (leadDDController.isDistrictLoading.value) {
                  return  Center(child:CustomSkelton.leadShimmerList(context));
                }


                return CustomDropdown<dist.Data>(
                  items: leadDDController.getDistrictByStateModel.value?.data ?? [],
                  getId: (item) => item.id.toString(),  // Adjust based on your model structure
                  getName: (item) => item.districtName.toString(),
                  selectedValue: leadDDController.getDistrictByStateModel.value?.data?.firstWhereOrNull(
                        (item) => item.id.toString() == leadDDController.selectedDistrict.value,
                  ),
                  onChanged: (value) {
                    leadDDController.selectedDistrict.value =  value?.id?.toString();
                    leadDDController.getCityByDistrictIdApi(districtId: leadDDController.selectedDistrict.value);
                  },
                );
              }),

              const SizedBox(height: 20),


              const Text(
                AppText.city,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.grey2,
                ),
              ),

              const SizedBox(height: 10),


              Obx((){
                if (leadDDController.isCityLoading.value) {
                  return  Center(child:CustomSkelton.leadShimmerList(context));
                }


                return CustomDropdown<city.Data>(
                  items: leadDDController.getCityByDistrictIdModel.value?.data ?? [],
                  getId: (item) => item.id.toString(),  // Adjust based on your model structure
                  getName: (item) => item.cityName.toString(),
                  selectedValue: leadDDController.getCityByDistrictIdModel.value?.data?.firstWhereOrNull(
                        (item) => item.id.toString() == leadDDController.selectedCity.value,
                  ),
                  onChanged: (value) {
                    leadDDController.selectedCity.value =  value?.id?.toString();
                  },
                );
              }),


              const SizedBox(height: 20),


              const Text(
                AppText.ksdplBr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.grey2,
                ),
              ),

              const SizedBox(height: 10),
              Obx((){
                if (leadDDController.isKSDPLBrLoading.value) {
                  return  Center(child:CustomSkelton.leadShimmerList(context));
                }


                return CustomDropdown<ksdplBranch.Data>(
                  items: leadDDController.getAllKsdplBranchModel.value?.data ?? [],
                  getId: (item) => item.id.toString(),  // Adjust based on your model structure
                  getName: (item) => item.branchName.toString(),
                  selectedValue: leadDDController.getAllKsdplBranchModel.value?.data?.firstWhereOrNull(
                        (item) => item.id.toString() == leadDDController.selectedKsdplBr.value,
                  ),
                  onChanged: (value) {
                    leadDDController.selectedKsdplBr.value =  value?.id?.toString();
                  },
                );
              }),

              const SizedBox(height: 20),


            ],
          ),

          onSubmit: onPressed,
        );
      },
    );
  }

  void showOpenPollDialog({
    required BuildContext context,
    required String leadId,
  }) {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                width: double.infinity, // Makes it full width
                padding: EdgeInsets.zero,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 🔵 Title in Blue Strip
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          color:AppColor.primaryColor, // Title background color
                          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                          gradient: LinearGradient(
                            colors: [AppColor.primaryLight, AppColor.primaryDark],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: const Text(
                          "Open Poll",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Colors.white, // Title text color
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      // 📝 Content (Radio Buttons)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child:  Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Enter percent for leads",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.grey1, // Title text color
                                ),

                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextFieldPrefix(
                              inputType:  TextInputType.number,
                              controller: leadListController.openPollPercentController,
                              hintText: "like 2.0 %",
                              validator: validatePercentage,
                              isPassword: false,
                              obscureText: false,
                            ),
                          ],
                        ),
                      ),

                      // 🟠 Buttons (Close & Submit)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context); // Close dialog
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColor.grey1,
                                side: BorderSide(color: AppColor.grey2),
                              ),
                              child: Text("Close", style: TextStyle(color: AppColor.grey2)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  leadListController.leadMoveToCommonTaskApi(
                                      leadId: leadId,
                                      percentage: leadListController.openPollPercentController.text.trim().toString()
                                  );
                                  Navigator.pop(context);
                                }

                                // Close dialog after submission
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.orangeColor,
                              ),
                              child: Text("Submit", style: TextStyle(color: AppColor.appWhite)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  String? validatePercentage(String? value) {
    if (value == null || value.isEmpty) {
      return AppText.percentageRequired;
    }
    return null;
  }*/


}


