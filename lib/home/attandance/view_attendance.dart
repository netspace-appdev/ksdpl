
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ksdpl/controllers/leads/income_step_controller.dart';
import 'package:ksdpl/models/dashboard/GetAllStateModel.dart';
import 'package:ksdpl/models/dashboard/GetDistrictByStateModel.dart' as dist;
import 'package:ksdpl/models/dashboard/GetCityByDistrictIdModel.dart' as city;
import 'package:ksdpl/models/dashboard/GetAllBankModel.dart' as bank;
import 'package:ksdpl/models/dashboard/GetAllKsdplProductModel.dart' as product;
import 'package:ksdpl/models/dashboard/GetProductListByBank.dart' as productBank;
import 'package:lottie/lottie.dart';
import '../../controllers/attendance/attendance_controller.dart';
import '../../controllers/leads/add_income_model_controller.dart';
import '../../controllers/product/add_product_controller.dart';
import '../../custom_widgets/CustomTextLabel.dart';
import '../../models/leads/special_model/AddIncModel.dart';
import '../../models/product/GetAllProductCategoryModel.dart' as productCat;
import '../../common/CustomSearchBar.dart';
import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../common/storage_service.dart';
import '../../common/validation_helper.dart';
import '../../controllers/bot_nav_controller.dart';
import '../../controllers/drawer_controller.dart';
import '../../controllers/greeting_controller.dart';
import '../../controllers/lead_dd_controller.dart';
import '../../controllers/leads/addLeadController.dart';
import '../../controllers/leads/infoController.dart';
import '../../custom_widgets/CustomDropdown.dart';
import '../../custom_widgets/CustomLabelPickerTextField.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';
import '../custom_drawer.dart';


class ViewAttendanceScreen extends StatelessWidget {

  final AttendanceController attendanceController=Get.find();

  final _formKey = GlobalKey<FormState>();

  ViewAttendanceScreen({super.key});

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
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min, // Prevents extra spacing
                          children: [
                            const SizedBox(
                              height: 10,
                            ),

                            CustomLabeledPickerTextField(
                              label: AppText.fromDate,

                              controller: attendanceController.atStartDateController,
                              inputType: TextInputType.name,
                              hintText: AppText.mmddyyyy,

                              isDateField: true,
                              isFutureDisabled: true,
                              validator: ValidationHelper.validateFromDate,
                            ),

                            CustomLabeledPickerTextField(
                              label: AppText.toDate,

                              controller: attendanceController.atEndDateController,
                              inputType: TextInputType.name,
                              hintText: AppText.mmddyyyy,

                              isDateField: true,
                              isFutureDisabled: true,
                              validator: ValidationHelper.validateToDateNew,
                            ),
                            SizedBox(height: 20),

                            Obx((){
                              if(attendanceController.isLoading.value){
                                return const Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: CircularProgressIndicator(
                                      color: AppColor.primaryColor,
                                    ),
                                  ),
                                );
                              }
                              return SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.secondaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: onPressed,
                                  child: const Text(
                                    AppText.submit,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            }),

                            const SizedBox(height: 20),
                            attendanceSection(context)
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
    );
  }
  Widget header(context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          // addleadcontroller.fromWhere.value=="drawer" ||addleadcontroller.fromWhere.value=="leadList" ||  addleadcontroller.fromWhere.value=="interested"?
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
          /*     InkWell(
              onTap: (){
                _scaffoldKey.currentState?.openDrawer();
              },
              child: SvgPicture.asset(AppImage.drawerIcon)),*/

          const Text(
            AppText.attendance,
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

            ),
          )



        ],
      ),
    );
  }


  Widget attendanceSection(BuildContext context){
    return Obx((){
      if (attendanceController.isAttendanceLoading.value) {
        return  Center(child: CustomSkelton.productShimmerList(context));
      }
      if (attendanceController.getAttendanceListEmpId.value == null ||
          attendanceController.getAttendanceListEmpId.value!.data == null || attendanceController.getAttendanceListEmpId.value!.data!.isEmpty) {
        return  Container(
          height: MediaQuery.of(context).size.height*0.50,
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
            itemCount: attendanceController.getAttendanceListEmpId.value!.data!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {

              final data = attendanceController.getAttendanceListEmpId.value!.data![index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Color strip header
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.today, color: AppColor.appWhite),
                            SizedBox(width: 8),
                            Text(
                              Helper.birthdayFormat(data.attendanceDate.toString())?? '-',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColor.appWhite,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            // Punch In
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade100,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.login, color: Colors.green),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Punch In",
                                          style: TextStyle(
                                              fontSize: 13, color: Colors.grey.shade600)),
                                      Text(
                                        formatOrDash(data.checkInTime),

                                        style: TextStyle(
                                            fontSize: 15, fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 12),

                            // Punch Out
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade100,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.logout, color: Colors.red),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Punch Out",
                                          style: TextStyle(
                                              fontSize: 13, color: Colors.grey.shade600)),
                                      Text(
                                        formatOrDash(data.checkOutTime),
                                        style: TextStyle(
                                            fontSize: 15, fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 16),
                          //  Divider(),

                           /* // Branch Info
                            Row(
                              children: [
                                Icon(Icons.location_on, size: 18, color: Colors.indigo),
                                SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    data.branchName ?? '-',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Chip(
                                  label: Text(
                                    (data.checkOutTime == null || data.checkOutTime == '-')
                                        ? 'In Progress'
                                        : 'Completed',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: (data.checkOutTime == null || data.checkOutTime == '-')
                                          ? Colors.orange
                                          : Colors.green.shade700,
                                    ),
                                  ),
                                  backgroundColor: (data.checkOutTime == null || data.checkOutTime == '-')
                                      ? Colors.orange.shade100
                                      : Colors.green.shade100,
                                ),
                              ],
                            ),*/
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );

            },
          ),
          /*if (leadListController.filteredHasMore.value)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: () {
                  leadListController.getFilteredLeadsApi(

                      employeeId: leadListController.eId.value.toString(),
                      leadStage:leadDDController.selectedStage.value??"0",
                      stateId: leadDDController.selectedState.value??"0",
                      distId: leadDDController.selectedDistrict.value??"0",
                      cityId:leadDDController.selectedCity.value??"0",
                      campaign: leadDDController.selectedCampaign.value??"",
                      fromDate: leadListController.fromDateController.value.text.isEmpty?"":Helper.convertToIso8601(leadListController.fromDateController.value.text),
                      toDate: leadListController.toDateController.value.text.isEmpty?"":Helper.convertToIso8601(leadListController.toDateController.value.text),
                      branch: leadDDController.selectedKsdplBr.value??"0",
                      uniqueLeadNumber: searchLeadController.uniqueLeadNumberController.text,
                      leadMobileNumber: searchLeadController.leadMobileNumberController.text,
                      leadName: searchLeadController.leadNameController.text,
                      isLoadMore: true
                  );
                },
                child: leadListController.isFilteredLoading.value
                    ? Container(
                    width: 15,
                    height: 15,
                    child: Center(child: CircularProgressIndicator(color: AppColor.primaryColor, strokeWidth: 2,)))
                    : Text("Load More"),
              ),
            ),*/
        ],
      );
    });
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
                      AppImage.searchLotie,
                      repeat: false
                  )),
              Text(
                  "No Attendance Found",
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

  /// Helper widget for icon buttons
  Widget _buildIconButton({
    required String icon,
    required Color color,
    required String phoneNumber,
    required String label,
    required String leadId,
    required String currentLeadStage,
    required BuildContext context,
  }) {
    return IconButton(
      onPressed: () {

      },

      icon: Container(

        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration:  BoxDecoration(
          border: Border.all(color: AppColor.grey200),
          color: AppColor.appWhite,
          borderRadius: BorderRadius.all(
            Radius.circular(2),
          ),

        ),
        child: Center(
          // child: Icon(icon, color: color),
          child: Image.asset(icon, height: 12,),
        ),
      ),
    );
  }

  String formatOrDash(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty || dateStr == 'null') {
      return '-';
    }
    return Helper.convertDateTime(dateStr);
  }

  void onPressed(){
    print("onpressed===>");

    if (_formKey.currentState!.validate()) {
      var empId=StorageService.get(StorageService.EMPLOYEE_ID).toString();
       attendanceController.getAttendanceListOfEmployeesByEmployeeIdApi(
         employeeId: empId,
         fromDate: Helper.attendanceDateFormat(attendanceController.atFromDateController.text),
         toDate: Helper.attendanceDateFormat(attendanceController.atFromDateController.text),
       );

      }
    }
}


