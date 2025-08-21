import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ksdpl/controllers/vacancyListController/vacancyListController.dart';

import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../controllers/product/add_product_controller.dart';
import '../../controllers/product/product_detail_controller.dart';
import '../custom_drawer.dart';

class vacancyListScreen extends StatelessWidget {
 // const vacancyListScreen({super.key});



  Vacancylistcontroller productDetailsController = Get.put(Vacancylistcontroller());
  //AddProductController addProductController = Get.find();


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
            AppText.vacancyList,
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

  Widget productSection(BuildContext context) {
    return Obx(() {
      if (productDetailsController.isLoadingMainScreen.value || productDetailsController.isLoadingMainScreen.value) {
        return Center(child: CustomSkelton.productShimmerList(context));
      }

      final data = productDetailsController.getDocumentProductIdModel.value?.data?.first;
      print('object${data?.jobTitle.toString()}');
      if (data == null || data == "") {
        return /// Header with profile and menu icon
          Align(
              alignment: Alignment.center,
              child: Text(
                  "No data found",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColor.grey700
                  )));
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildCard("Info", [
            DetailRow(label: AppText.jobTitle, value: data.jobTitle?.toString()??''),
            DetailRow(label: AppText.employeeRole, value: data.employeeRole?.toString()??''),
            DetailRow(label: AppText.workLocation, value: data.workLocation?.toString()??''),
            DetailRow(label: AppText.salaryRange, value: '${data.salaryRangeMax?.toString()??''} - ${data?.salaryRangeMin?.toString()??''}'),
            DetailRow(label: AppText.workExperience, value: '${data.experienceRequired?.toString()??''}'),
            DetailRow(label: AppText.skillRequired, value: '${data.skillsRequired?.toString()??''}'),
            DetailRow(label: AppText.dateposted, value: '${data.datePosted?.toString()??''}'),
            DetailRow(label: AppText.noOfVacancies, value: '${data.numberOfVacancies?.toString()??''}'),
            DetailRow(label: AppText.jobLevel, value: '${data.jobLevel?.toString()??''}'),
            DetailRow(label: AppText.hiringManager, value: '${data.hiringManager?.toString()??''}'),
            DetailRow(label: AppText.qualificationRequired, value: '${data.qualificationsRequired?.toString()??''}'),
            DetailRow(label: AppText.jobDescription, value: '${data.jobDescription?.toString()??''}'),
          ],
              Icons.info_outline

          ),
          //
          // buildCard("Bank & Contact Info", [
          //   DetailRow(label: AppText.bankNostar, value: data.jobTitle.toString()),
          //   DetailRow(label: AppText.bankerName, value: data.jobTitle.toString()),
          //   DetailRow(label: AppText.bankerMobile, value: data.jobTitle.toString()),
          //   DetailRow(label: AppText.bankerWhatsapp, value: data.jobTitle.toString()),
          //   DetailRow(label: AppText.bankerEmail, value: data.jobTitle.toString()),
          //   DetailRow(label: AppText.superiorName, value: data.jobTitle.toString()),
          //   DetailRow(label: AppText.superiorMobile, value: data.jobTitle.toString()),
          //   DetailRow(label: AppText.superiorEmail, value: data.jobTitle.toString()),
          //   DetailRow(label: AppText.superiorWhatsapp, value: data.jobTitle.toString()),
          // ],
          //     Icons.phone
          // ),
          //
          // buildCard("Collateral & Profile Restrictions", [
          //   DetailRow(label: AppText.selectCollateralSecurityCategory, value: data.jobTitle.toString()), //Collateral is Prime now
          //   DetailRow(label: AppText.collateralSecurityExcluded, value: data.jobTitle.toString()),
          //   // DetailRow(label: AppText.profileExcluded, value: data.profileExcluded.toString()),
          //   DetailRow(label: AppText.negativeProfiles, value: data.jobTitle.toString()),
          //   DetailRow(label: AppText.negativeAreas, value: data.jobTitle.toString()),
          //   DetailRow(label: AppText.geoLimit, value: data.jobTitle.toString()),
          // ],
          //     Icons.security
          // ),
          //
          // buildCard("Eligibility Criteria", [
          //   DetailRow(label: AppText.selectIncomeType, value: data.jobTitle.toString()),
          //   DetailRow(label:  AppText.ageLimitEarningApplicants, value: data.jobTitle.toString()),
          //   DetailRow(label: AppText.ageLimitNonEarningCoApplicant, value: data.jobTitle.toString()),
          //   DetailRow(label: AppText.minAgeEarningApplicants, value: data.jobTitle.toString()),
          //   DetailRow(label: AppText.minAgeNonEarningApplicants, value: data.jobTitle.toString()),
          //   DetailRow(label: AppText.minIncomeCriteria, value: data.jobTitle.toString()),
          //   DetailRow(label: AppText.minLoanAmount, value: data.jobTitle.toString()),
          //   DetailRow(label: AppText.maxLoanAmount, value: data.jobTitle.toString()),
          //   DetailRow(label: AppText.minRoi, value: data.jobTitle.toString()),
          //   DetailRow(label:  AppText.maxRoi, value: data.jobTitle.toString()),
          //   DetailRow(label: AppText.minTenor, value: data.jobTitle.toString()),
          //   DetailRow(label:  AppText.maxTenor, value: data.jobTitle.toString()),
          //   DetailRow(label: AppText.ageAtMaturity, value: data.jobTitle.toString()),
          // ],
          //     Icons.rule
          // ),
          //
          // buildCard("Financial Limits", [
          //   DetailRow(label: AppText.minPropertyValue, value: data.jobTitle.toString()),
          //   DetailRow(label:  AppText.maxIir, value: data.jobTitle.toString()),
          //   DetailRow(label: AppText.maxFoir, value: data.jobTitle.toString()),
          //   DetailRow(label: AppText.maxLtv, value: data.jobTitle.toString()),
          // ],
          //     Icons.radar
          // ),
          //
          // buildCard("Charges & Fees", [
          //   DetailRow(label: AppText.processingFee, value: data.jobTitle.toString()),
          //   DetailRow(label: AppText.processingCharges, value: data.jobTitle.toString()),
          //   DetailRow(label:  AppText.legalFee, value: data.jobTitle.toString()),
          //   DetailRow(label: AppText.technicalFee, value: data.jobTitle.toString()),
          //   DetailRow(label:  AppText.adminFee, value: data.jobTitle.toString()),
          //   DetailRow(label: AppText.foreclosureCharges, value: data.jobTitle.toString()),
          //   DetailRow(label: AppText.otherCharges, value: data.jobTitle.toString()),
          //   DetailRow(label: AppText.stampDuty, value: data.jobTitle.toString()),
          //   DetailRow(label: AppText.tsrYears, value: data.jobTitle.toString()),
          //   DetailRow(label: AppText.tsrCharges, value: data.jobTitle.toString()),
          //   DetailRow(label: AppText.valuationCharges, value: data.jobTitle.toString()),
          //   DetailRow(label: AppText.fromAmtRange, value: data.jobTitle.toString()),
          //   DetailRow(label: AppText.toAmtRange, value: data.jobTitle.toString()),
          //   DetailRow(label: AppText.totalOverdueCases2, value: data.jobTitle.toString()),
          //   DetailRow(label: AppText.totalOverdueAmount, value: data.jobTitle.toString()),
          //   DetailRow(label: AppText.totalEnquiries2, value: data.jobTitle.toString()),
          // ],
          //     Icons.attach_money
          // ),
          //
          // buildCard("Administrative Info", [
          //   DetailRow(label: AppText.noOfDocuments, value: data.jobTitle.toString()),
          //   DetailRow(label: AppText.ksdplProduct, value: data.jobTitle.toString()),
          //   DetailRow(label: AppText.eligibleProfitPercent, value: data.jobTitle.toString()),
          //   DetailRow(label: AppText.maxTat, value: data.jobTitle.toString()),
          // ],
          //     Icons.admin_panel_settings_sharp
          // ),

            //  Icons.list_alt_rounded
       //   ),

          SizedBox(height: 20),
        ],
      );

    });
  }


  Widget buildCard(String title, List<Widget> children, IconData icon) {
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
            child: Row(
              children: [
                Icon(icon, color: Colors.white,),
                SizedBox(width: 5,),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
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




}


//details

// Helper Widget for Status Chips
class StatusChip extends StatelessWidget {
  final String label;
  final Color color;

  StatusChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(label, style: TextStyle(color: AppColor.appWhite, fontSize: 12)),
    );
  }
}

// Helper Widget for Detail Rows
/*class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Container(

            width: 120,
            child: Text("$label",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColor.primaryColor)),
          ),
          Text(":", style: TextStyle(fontSize: 14),),
          Expanded(
              child: value=="null" || value==AppText.customdash?
              Row(


                children: [
                  Icon(Icons.horizontal_rule, size: 15,),
                ],):
              Text(" "+value, style: TextStyle(fontSize: 14), maxLines: 2)),
        ],
      ),
    );
  }
}*/

class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 14, color: AppColor.primaryColor
            ),
          ),
          const SizedBox(height: 4),
          value=="null" || value==AppText.customdash?
          Row(


            children: [
              Icon(Icons.horizontal_rule, size: 15,),
            ],):
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}


// Helper Widget for Icon Buttons
class IconButtonWidget extends StatelessWidget {
  final IconData icon;
  final Color color;

  IconButtonWidget({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: Container(
        height: 27,
        width: 27,
        // color: color.withOpacity(0.2),
        decoration: BoxDecoration(

        ),
        child: Center(child: Icon(icon, color: color,size: 16,)),
      ),
    );
  }
}
