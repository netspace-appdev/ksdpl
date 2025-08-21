import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../controllers/insuranceLeadsController/insuranceLeadController.dart';
import '../../controllers/lead_dd_controller.dart';
import '../../controllers/product/add_product_controller.dart';
import '../../custom_widgets/CustomBigDialogBox.dart';
import '../camnote/cam_note_single.dart';
import '../custom_drawer.dart';

class InsuranceLeadScreen extends StatelessWidget {


  InsuranceLeadController insuranceLeadController = Get.put(InsuranceLeadController());
  final LeadDDController leadDDController =Get.find();
  final  AddProductController addProductController = Get.find();

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

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppText.products,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              InkWell(
                                onTap: (){

                                //  viewProductController.clearFilter();

                                },
                                child: Text(
                                  "Clear Filter",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColor.secondaryColor),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),
                         // productSection(context),

                          const SizedBox(height: 20),
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
            AppText.viewProducts,
            style: TextStyle(
                fontSize: 20,
                color: AppColor.grey3,
                fontWeight: FontWeight.w700
            ),
          ),

          InkWell(
            onTap: (){
            //  viewProductController.clearForm();
             // showFilterDialogForProduct(context: context);
            },
            child: Container(

              width: 40,
              height:40,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration:  BoxDecoration(
                color: AppColor.appWhite.withOpacity(0.15),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Center(child: Icon(Icons.filter_alt_outlined, color: AppColor.appWhite,),),
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

/*  Widget productSection(BuildContext context){
    return Obx((){
      if (viewProductController.isMainListMoreLoading.value) {
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


          ListView.builder(
            itemCount:viewProductController.filteredProducts.length,//viewProductController.getAllProductListModel.value!.data!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              // final product = viewProductController.getAllProductListModel.value!.data![index];
              final product =  viewProductController.filteredProducts[index];

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

          AddProductController addProductController = Get.put(AddProductController());
          addProductController.getDocumentListByProductIdApi(productId:id );
          Get.toNamed("/productDetailScreen");

        }else  if (label == "Edit") {
          AddProductController addProductController = Get.put(AddProductController());


          addProductController.getProductListByIdApi(id: id);
          addProductController.getDocumentListByProductIdApi(productId: id);
          addProductController.getAllProductCategoryApi();
          addProductController.clearForm();
          addProductController.currentStep.value=0;
          addProductController.isFirstSave.value=1;
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
  }*/

}

