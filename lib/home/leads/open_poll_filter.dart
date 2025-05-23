
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
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
import '../../custom_widgets/CustomBigDialogBox.dart';
import '../../custom_widgets/CustomDialogBox.dart';
import '../../custom_widgets/CustomTextFieldPrefix.dart';
import '../custom_drawer.dart';



class OpenPollFilter extends StatelessWidget {

  LeadDDController leadDDController = Get.put(LeadDDController());

  final _formKey = GlobalKey<FormState>();
  final Addleadcontroller addleadcontroller =Get.put(Addleadcontroller());
  LeadListController leadListController = Get.find();
  OpenPollFilterController openPollFilterController = Get.put(OpenPollFilterController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        key:_scaffoldKey,
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



                            const SizedBox(height: 20),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppText.openPollLeads,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                InkWell(
                                  onTap: (){

                                    openPollFilterController.clearFilter();

                                  },
                                  child: Text(
                                    "Clear Filter",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColor.secondaryColor),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            leadSection(context)
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


         /* InkWell(
              onTap: (){
                Get.back();
              },
              child: Image.asset(AppImage.arrowLeft,height: 24,)),*/
          InkWell(
              onTap: (){
                _scaffoldKey.currentState?.openDrawer();
              },
              child: SvgPicture.asset(AppImage.drawerIcon)),


          const Text(
            AppText.openPollFilter,
            style: TextStyle(
                fontSize: 20,
                color: AppColor.grey3,
                fontWeight: FontWeight.w700


            ),
          ),

          InkWell(
            onTap: (){
               leadDDController.selectedState.value="0";
               leadDDController.selectedDistrict.value="0";
               leadDDController.selectedCity.value="0";
               leadDDController.selectedKsdplBr.value="0";
              showFilterDialog(context: context,leadId: "0");
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
              child: Center(child: Image.asset(AppImage.filterIcon, height: 17,)),
            ),
          )



        ],
      ),
    );
  }

  Widget _buildRadioOption(String gender) {
    return Row(
      children: [
        Radio<String>(
          value: gender,
          groupValue: addleadcontroller.selectedGender.value,
          onChanged: (value) {
            addleadcontroller.selectedGender.value=value;
          },
        ),
        Text(gender),
      ],
    );
  }

  void onPressed(){


    if (_formKey.currentState!.validate()) {


      openPollFilterController.pollFilterSubmit();
    }
    Get.back();
  }

  Widget leadSection(BuildContext context){
    return Obx((){
      if (openPollFilterController.isLoading.value) {
        return  Center(child: CustomSkelton.productShimmerList(context));
      }
      if (openPollFilterController.getCommonLeadListFModel.value == null ||
          openPollFilterController.getCommonLeadListFModel.value!.data == null || openPollFilterController.getCommonLeadListFModel.value!.data!.isEmpty) {
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
          child: Column(

            children: [
              /// Header with profile and menu icon
              _noDataCard(context)

            ],
          ),
        );
      }

      return  ListView.builder(
        itemCount: openPollFilterController.getCommonLeadListFModel.value!.data!.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final lead = openPollFilterController.getCommonLeadListFModel.value!.data![index];



          return Container(
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

              children: [
                /// Header with profile and menu icon
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,

                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.primaryColor,
                              border: Border.all(color: AppColor.secondaryColor),
                            ),
                            child: Center(
                              child: Text(
                                lead.name==null?"N": lead.name!.isNotEmpty ?  lead.name![0].toUpperCase() : "U", // Initial Letter
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Helper.capitalizeEachWord(lead.name.toString()),

                                // lead.name.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
                      //Icon(Icons.more_vert, color: AppColor.grey1,), // Three dots menu icon
                    ],
                  ),
                ),
                SizedBox(height: 10),

                /// Lead details
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      _buildDetailRow("Email", lead.email.toString()),
                      _buildDetailRow("Assigned", lead.assignedEmployeeDate.toString()),
                      _buildDetailRow("Uploaded on", lead.uploadedDate.toString()),
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
                    _buildTextButton("Pick Lead", context, Colors.purple, Icons.shopping_bag_outlined, lead.id.toString()),


                    _buildTextButton("Details", context, Colors.pink, Icons.insert_drive_file,lead.id.toString()),
                  ],
                ),
              ],
            ),
          );

        },
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
              label=="Assigned" ||  label=="Uploaded on"?": ${ Helper.formatDate(value)}":  ": ${value}",

              style: TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper widget for icon buttons
  Widget _buildIconButton({
    required String icon,
    required Color color,
    required String phoneNumber,
    required String label,
  }) {
    return IconButton(
      onPressed: () {
        if(label=="call"){
          leadListController.makePhoneCall(phoneNumber);
        }
        if(label=="whatsapp"){
          leadListController.openWhatsApp(phoneNumber: phoneNumber, message: AppText.whatsappMsg);
        }
        if(label=="message"){
          leadListController.sendSMS(phoneNumber: phoneNumber, message: AppText.whatsappMsg);
        }

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
                      AppImage.noTreasure,
                      repeat: false
                  )),
              Text(
                  "No Leads Found",
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

  Widget _buildTextButton(String label, BuildContext context, Color color, IconData icon, String leadId) {
    return GestureDetector(
      onTap: () {
        if (label == "Pick Lead") {
          // showOpenPollDialog(context: context,leadId: leadId);
          showDialog(
            context: context,
            builder: (context) {
              return CustomDialogBox(
                title: "Are you sure?",

                onYes: () {
                  var eId=StorageService.get(StorageService.EMPLOYEE_ID).toString();
                  openPollFilterController.pickupLeadFromCommonTasksApi(
                      employeeId: eId,
                      leadId: leadId
                  ).then((_){
                    openPollFilterController. getCommonLeadListByFilterApi(
                      stateId: leadDDController.selectedState.value??"0",
                      distId: leadDDController.selectedDistrict.value??"0",
                      cityId:  leadDDController.selectedCity.value??"0",
                      KsdplBranchId: leadDDController.selectedKsdplBr.value??"0",
                    );
                  });


                },
                onNo: () {

                },
              );
            },
          );

        }else if (label == "Details") {
          //Get.toNamed("/leadDetailsMain", arguments: {"leadId":leadId.toString()});
          Get.toNamed("/leadDetailsTab", arguments: {"leadId":leadId.toString()});
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







  void showFilterDialog({
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
  }


}


