
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ksdpl/controllers/leads/income_step_controller.dart';
import 'package:ksdpl/custom_widgets/SnackBarHelper.dart';
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
import '../../custom_widgets/CustomTextArea.dart';
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
import '../../models/attandance/GetAllLeaveTypeModel.dart' as leaveType;

class ManageLeaveScreen extends StatelessWidget {

  final AttendanceController attendanceController=Get.find();

  final _formKey = GlobalKey<FormState>();

  ManageLeaveScreen({super.key});

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
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    // width: MediaQuery.of(context).size.width*0.50,
                                    child: Text(
                                      AppText.leaveStatus,
                                      style: GoogleFonts.roboto(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: (){
                                  attendanceController.clearFields();
                                  showCustomBottomSheet(context);
                                },
                                child: const Row(

                                  children: [
                                    Icon(Icons.add,color: AppColor.orangeColor,size: 16,),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      AppText.reqLeave,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.orangeColor
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          leaveSection(context)
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
            AppText.manageLeaves,
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


  Widget leaveSection(BuildContext context){
    return Obx((){
      if (attendanceController.isLeavesLoading.value) {
        return  Center(child: CustomSkelton.productShimmerList(context));
      }
      if (attendanceController.getAllLeaveDetailByEmpIdModel.value == null ||
          attendanceController.getAllLeaveDetailByEmpIdModel.value!.data == null || attendanceController.getAllLeaveDetailByEmpIdModel.value!.data!.isEmpty) {
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
            itemCount: attendanceController.getAllLeaveDetailByEmpIdModel.value!.data!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {

              final data = attendanceController.getAllLeaveDetailByEmpIdModel.value!.data![index];

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
                             data.leaveTypeName.toString(),
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
                                  child: Icon(Icons.start, color: Colors.green),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Start Date",
                                          style: TextStyle(
                                              fontSize: 13, color: Colors.grey.shade600)),
                                      Text(
                                        formatOrDash2(data.startDate),

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
                                  child: Icon(Icons.pin_end, color: Colors.red),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("End Date",
                                          style: TextStyle(
                                              fontSize: 13, color: Colors.grey.shade600)),
                                      Text(
                                        formatOrDash2(data.endDate),
                                        style: TextStyle(
                                            fontSize: 15, fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 16),
                            Divider(),

                            // Branch Info
                            Row(
                              children: [
                                Icon(Icons.calendar_month, size: 18, color: Colors.indigo),
                                SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    "Day(s): ${data.totalDays.toString()}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Status: ",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Chip(
                                      label: Text(
                                        data.status.toString(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: data.status!.toLowerCase()=="pending"
                                              ? Colors.orange :
                                          data.status!.toLowerCase()=="accept"
                                              ? Colors.green:
                                          data.status!.toLowerCase()=="reject"
                                              ? Colors.red
                                              : Colors.red.shade700,
                                        ),
                                      ),
                                      backgroundColor: data.status!.toLowerCase()=="pending"
                                          ? Colors.orange.shade100:
                                      data.status!.toLowerCase()=="accept"
                                          ? Colors.green.shade100:
                                      data.status!.toLowerCase()=="reject"
                                          ? Colors.red.shade100
                                          : Colors.green.shade100,
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            Divider(),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Reason: ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColor.primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Expanded(
                                    child: Text("${data.reason}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                )
                              ],
                            )
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
                  "No Leaves Found",
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
  String formatOrDash2(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty || dateStr == 'null') {
      return '-';
    }
    return Helper.birthdayFormat(dateStr);
  }

  void onPressed(){


    if (_formKey.currentState!.validate()) {
      final fromText = attendanceController.atStartDateController.text;
      final toText = attendanceController.atEndDateController.text;

      if (fromText.isNotEmpty && toText.isNotEmpty) {

        try {
          final fromDate = DateFormat('yyyy-MM-dd').parse(fromText);
          final toDate = DateFormat('yyyy-MM-dd').parse(toText);

          if (fromDate.isAfter(toDate)) {
            // Invalid case
            attendanceController.atTotalDaysController.text = '';
            SnackbarHelper.showSnackbar(title: "Invalid Date", message: "Start date cannot be after End date");

            return;
          }

          var empId=StorageService.get(StorageService.EMPLOYEE_ID).toString();
          attendanceController.addEmployeeLeaveDetailApi(
            id: "0",
            employeeId:  empId,
            startDate:   Helper.attendanceDateFormat(attendanceController.atStartDateController.text),
            endDate:     Helper.attendanceDateFormat(attendanceController.atEndDateController.text),
            totalDays:   attendanceController.atTotalDaysController.text.trim().toString(),
            leaveType:   attendanceController.selectedLeaveType.toString(),
            reason:      attendanceController.atReasonController.text.trim().toString(),
          );

        } catch (e) {
          attendanceController.atTotalDaysController.text = '';
        }
      }

    }
  }

  void showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16,
              right: 16,
              top: 24,
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8, // optional: control sheet height
              child: Column(
                children: [
                  // Scrollable Form Fields
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            const SizedBox(height: 10),
                            CustomTextLabel(
                              label: AppText.leaveType,
                              isRequired: true,
                            ),
                            const SizedBox(height: 10),

                            Obx(() {
                              if (attendanceController.isLeavesLoading.value) {
                                return Center(child: CustomSkelton.leadShimmerList(context));
                              }

                              return CustomDropdown<leaveType.Data>(
                                items: attendanceController.leaveTypeList ?? [],
                                getId: (item) => item.id.toString(),
                                getName: (item) => item.leaveTypeName.toString(),
                                selectedValue: attendanceController.leaveTypeList.firstWhereOrNull(
                                        (item) => item.id == attendanceController.selectedLeaveType.value),
                                onChanged: (value) {
                                  attendanceController.selectedLeaveType.value = value?.id;

                                },
                                onClear: () {
                                  attendanceController.selectedLeaveType.value = 0;
                                },
                              );
                            }),

                            CustomLabeledPickerTextField(
                              label: AppText.startDate,

                              controller: attendanceController.atStartDateController,
                              inputType: TextInputType.name,
                              hintText: AppText.mmddyyyy,

                              isDateField: true,

                              validator: ValidationHelper.validateFromDate,

                              onDateSelected: () {
                                attendanceController.calculateTotalDays();
                              },
                            ),

                            CustomLabeledPickerTextField(
                              label: AppText.endDate,

                              controller: attendanceController.atEndDateController,
                              inputType: TextInputType.name,
                              hintText: AppText.mmddyyyy,

                              isDateField: true,

                              validator: ValidationHelper.validateToDateNew,
                              onDateSelected: () {
                                attendanceController.calculateTotalDays();
                              },
                            ),
                            CustomLabeledTextField(
                              label: AppText.totalDays,
                              controller: attendanceController.atTotalDaysController,
                              inputType: TextInputType.number,
                              hintText: AppText.enterBankerMobile,
                              isRequired: true,
                              isInputEnabled: false,

                            ),

                            CustomTextLabel(label: "Reason", isRequired: true,),
                            SizedBox(height: 10,),
                            CustomTextArea(
                              label: "",
                              controller:attendanceController.atReasonController,
                              maxLines: 5, // Increase lines if needed
                              validator: (value) => value!.isEmpty ? "Please enter some text" : null,


                            ),

                            const SizedBox(height: 30), // Give some space above the fixed button
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Sticky Submit Button
                  Obx(() {
                    if (attendanceController.isSendLoading.value) {
                      return const SizedBox(
                        height: 50,
                        child: Center(
                          child: CircularProgressIndicator(color: AppColor.primaryColor),
                        ),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: SizedBox(
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
                      ),
                    );
                  }),
                ],
              ),
            ),
          );
        }


    );
  }



}


