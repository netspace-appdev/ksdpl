import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../controllers/seniorController.dart';
import '../../controllers/vacancyListController/vacancyListController.dart';
import '../custom_drawer.dart';

class SeniorlistScreen extends StatelessWidget {
 // const SeniorlistScreen({super.key});
  SeniorScreenController seniorScreenController = Get.put(SeniorScreenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        drawer: const CustomDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  // Gradient Background
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.5,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColor.primaryLight, AppColor.primaryDark],
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15),
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
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: 90 // MediaQuery.of(context).size.height * 0.22
                      ),
                      // <-- Moves it 30px from top
                      width: double.infinity,
                      //height: MediaQuery.of(context).size.height,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      decoration: const BoxDecoration(
                        color: AppColor.backgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45),
                          topRight: Radius.circular(45),
                        ),

                      ),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        // Prevents extra spacing
                        children: [


                          // SizedBox(height: 20),
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

  Widget header(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: () {
                Get.back();
              },
              child: Image.asset(AppImage.arrowLeft, height: 24,)),

          const Text(
            AppText.manageSenorList,
            style: TextStyle(
                fontSize: 20,
                color: AppColor.grey3,
                fontWeight: FontWeight.w700
            ),
          ),

          InkWell(
            onTap: () {

            },
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

            ),
          )
        ],
      ),
    );
  }

  Widget productSection(BuildContext context) {
    return Obx(() {
      /*  if (productDetailsController.isLoadingMainScreen.value || productDetailsController.isLoadingMainScreen.value) {
        return Center(child: CustomSkelton.productShimmerList(context));
      }

      final data = productDetailsController.getDocumentProductIdModel.value?.data?.first;
      print('object${data?.jobTitle.toString()}');
      if (data == null || data == "") {
        return /// Header with profile and menu icon
          const Align(
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
          SizedBox(height: 20),
        ],
      );
      */

      ///
      /// New code
      if (seniorScreenController.isLoadingMainScreen.value) {
        return Center(child: CustomSkelton.productShimmerList(context));
      }

      final data =  seniorScreenController.getSeniorListModel.value;

      if (data == null || data.data == null || data.data!.isEmpty) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.50,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.grey200),
            color: AppColor.appWhite,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: const Center(
            child: Text(
              "No data found",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColor.grey700,
              ),
            ),
          ),
        );
      }

      final dataList = data.data!;

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          final data1 = dataList[index];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildCard("${index + 1}", [
                DetailRow(label:  AppText.employeeName, value: data1.employeeName?.toString()??''),
                DetailRow(label: AppText.emailNoStar, value: data1.email?.toString()??''),
                DetailRow(label: AppText.contactNo2, value: data1.phoneNumber?.toString()??''),
                DetailRow(label: AppText.whatsappNoNoStar, value: '${data1.whatsappNumber?.toString()??''}'),
                DetailRow(label: AppText.jobRoll, value: '${data1.jobRole?.toString()??''}'),
                DetailRow(label: AppText.channelName, value: '${data1.channelName?.toString()??''}'),
                DetailRow(label: AppText.state, value: '${data1.stateName?.toString()??''}'),
                DetailRow(label: AppText.city, value: '${data1.cityName?.toString()??''}'),
                DetailRow(label: AppText.district, value: '${data1.districtName?.toString()??''}'),
                DetailRow(label: AppText.postalcode, value: '${data1.postalCode?.toString()??''}'),
              ],
                  Icons.info_outline

              ),
              SizedBox(height: 20),
            ],
          );
        },
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
          const Row(
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


