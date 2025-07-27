import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../controllers/addEmployeeExpenseDetailsController/addEmployeeExpenseDetailsController.dart';
import '../../controllers/cibilgenerate_controller/cibilRecordListController.dart';
import '../../controllers/lead_dd_controller.dart';
import '../../controllers/viewExpenseController/viewExpenseController.dart';
import '../addEmployeeExpenseDetails/editEmployeeExpenseDetail.dart';

class CibilRecordListScreen extends StatelessWidget {

  CibilRecordListController cibilRecordListController = Get.put(CibilRecordListController());
  final LeadDDController leadDDController =Get.find();
//  final  AddProductController addProductController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
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

                          //   const SizedBox(height: 20),const SizedBox(height: 20),
                          productSection(context),

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
            AppText.cibilRecord,
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
              child: Center(child: Icon(Icons.filter_alt_outlined, color: Colors.transparent,),),
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
      if (cibilRecordListController.isLoading.value) {
        return  Center(child: CustomSkelton.productShimmerList(context));
      }
      if (cibilRecordListController.expenseList.value == null ||
          cibilRecordListController.getCustomerCibilDetailModel.value?.data == null || cibilRecordListController.getCustomerCibilDetailModel.value!.data!.isEmpty) {
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
            itemCount:cibilRecordListController.CibilDetailList.length,//cibilRecordListController.getAllProductListModel.value!.data!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              // final product = cibilRecordListController.getAllProductListModel.value!.data![index];
              final product =  cibilRecordListController.CibilDetailList[index];

              return buildCard(
                Helper.capitalizeEachWord('Date :- ${ cibilRecordListController.formatDate(product.receiveDate.toString())}'), // title
                [
                  // _buildDetailRow("Documents", product.documents.toString(),"0"),
                  _buildDetailRow("Name", product.name.toString(),"1"),
                  _buildDetailRow("Mobile No", product.mobile.toString(),"1"),
                  _buildDetailRow("Amount", product.amount.toString(),"1"),
                  _buildDetailRow("UTR", product.utr.toString(),"1"),

                  const SizedBox(height: 10),

                  _buildTextButton("Download Docs", context, Colors.pink, Icons.insert_drive_file,
                      product.filePath.toString()),
                ],
              );

            },
          ),


        ],
      );
    });
  }

  Widget _buildDetailRow(String label, String value, String check) {
    //   String assigned = value.toString();
//    List<String> assignedParts = assigned.split('T');


    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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
              //  maxLines: 3,
              style: TextStyle(color: check == "0"?Colors.deepPurple:AppColor.black1,
                decoration: check == "0"
                    ? TextDecoration.underline
                    : TextDecoration.none,
              ),

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

  Widget _buildTextButton(String label, BuildContext context, Color color, IconData icon,  String url) {
    return GestureDetector(
      onTap: () {
        if (label == "Download Docs") {
         cibilRecordListController.launchInBrowser(url);
          print('addemployeeidurl${url}');

        }else  if (label == "Edit") {
         // print('addemployeeid${id}');
          AddEmployeeExpenseDetailsController addEmployeeExpenseDetailsController = Get.put(AddEmployeeExpenseDetailsController());

         // addEmployeeExpenseDetailsController.getEmployeeExpenseByIDRequest(ExpenseId: id);
        //  Get.to(EditEmployeeExpenseDetail());

        }else{

        }
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            width: MediaQuery.of(context).size.width*0.90,

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

}
