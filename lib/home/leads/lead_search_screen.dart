
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ksdpl/models/dashboard/GetAllStateModel.dart' as state;
import 'package:ksdpl/models/dashboard/GetDistrictByStateModel.dart' as dist;
import 'package:ksdpl/models/dashboard/GetCityByDistrictIdModel.dart' as city;
import 'package:ksdpl/models/dashboard/GetAllBankModel.dart' as bank;
import 'package:ksdpl/models/dashboard/GetAllKsdplProductModel.dart' as product;
import 'package:ksdpl/models/dashboard/GetProductListByBank.dart' as productBank;
import 'package:ksdpl/models/GetCampaignNameModel.dart' as campaign;
import 'package:ksdpl/models/leads/GetAllKsdplBranchModel.dart' as ksdplBranch;
import 'package:ksdpl/models/leads/GetAllLeadStageModel.dart' as stage;
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
import '../../controllers/camnote/camnote_controller.dart';
import '../../controllers/leads/leadlist_controller.dart';
import '../../controllers/leads/seachLeadController.dart';
import '../../controllers/leads/seachLeadController.dart';
import '../../controllers/leads/seachLeadController.dart';
import '../../controllers/open_poll_filter_controller.dart';
import '../../controllers/product/add_product_controller.dart';
import '../../controllers/product/view_product_controller.dart';
import '../../custom_widgets/CustomBigDialogBox.dart';
import '../../custom_widgets/CustomDialogBox.dart';
import '../../custom_widgets/CustomLabeledTimePicker.dart';
import '../../custom_widgets/CustomTextFieldPrefix.dart';
import '../../services/call_service.dart';
import '../custom_drawer.dart';



class LeadSearchScreen extends StatelessWidget {

  LeadDDController leadDDController = Get.put(LeadDDController());

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final Addleadcontroller addleadcontroller =Get.put(Addleadcontroller());
  LeadListController leadListController =Get.put(LeadListController());
  SearchLeadController searchLeadController=Get.put(SearchLeadController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Addleadcontroller addLeadController = Get.put(Addleadcontroller());

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

                            ExpansionTile(
                              initiallyExpanded: true,

                              childrenPadding: EdgeInsets.symmetric(horizontal: 20),
                              title:const Text("Filter", style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                              leading: Icon(Icons.filter_alt_outlined),

                              children: [

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),

                                    CustomLabeledTextField(
                                      label: AppText.leadName,
                                      isRequired: false,
                                      controller: searchLeadController.leadNameController ,
                                      inputType: TextInputType.name,
                                      hintText: AppText.enterLeadName,

                                    ),

                                    CustomLabeledTextField(
                                      label: AppText.uniqueLeadNumber,
                                      isRequired: false,
                                      controller: searchLeadController.uniqueLeadNumberController ,
                                      inputType: TextInputType.name,
                                      hintText: AppText.enterUniqueLeadNumber,

                                    ),

                                    CustomLabeledTextField(
                                      label: AppText.leadMobileNUmber,
                                      isRequired: false,
                                      controller: searchLeadController.leadMobileNumberController ,
                                      inputType: TextInputType.name,
                                      hintText: AppText.enterLeadMobileNUmber,

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
                                      if (leadDDController.isLoading.value) {
                                        return  Center(child:CustomSkelton.productShimmerList(context));
                                      }

                                      return CustomDropdown<state.Data>(
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
                                      if (leadDDController.isLoading.value) {
                                        return  Center(child:CustomSkelton.productShimmerList(context));
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
                                      if (leadDDController.isLoading.value) {
                                        return  Center(child:CustomSkelton.productShimmerList(context));
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
                                      if (leadDDController.isLoading.value) {
                                        return  Center(child:CustomSkelton.productShimmerList(context));
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

                                    const Text(
                                      AppText.campaign,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.grey2,
                                      ),
                                    ),

                                    const SizedBox(height: 10),
                                     Obx((){
                                      if (leadDDController.isLoading.value) {
                                        return  Center(child:CustomSkelton.productShimmerList(context));
                                      }


                                      return CustomDropdown<String>(
                                        items: leadDDController.getCampaignNameModel.value!.data!,
                                        getId: (item) => item,  // Adjust based on your model structure
                                        getName: (item) => item,
                                        selectedValue: leadDDController.selectedCampaign.value,
                                        onChanged: (value) {
                                          leadDDController.selectedCampaign.value =  value;
                                        },
                                      );
                                    }),

                                    const SizedBox(height: 20),

                                    const Text(
                                      AppText.leadStage,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.grey2,
                                      ),
                                    ),

                                    const SizedBox(height: 10),
                                    Obx((){
                                      if (leadDDController.isLeadStageLoading.value) {
                                        return  Center(child:CustomSkelton.leadShimmerList(context));
                                      }


                                      return CustomDropdown<stage.Data>(
                                        items: leadDDController.getAllLeadStageModel.value!.data!.where((lead) => lead.id != 1).toList(),
                                        getId: (item) =>item.id.toString(),  // Adjust based on your model structure
                                        getName: (item) => item.stageName.toString(),
                                        selectedValue: leadDDController.getAllLeadStageModel.value?.data?.firstWhereOrNull(
                                              (item) => item.id.toString() == leadDDController.selectedStage.value,
                                        ),
                                        onChanged: (value) {
                                          leadDDController.selectedStage.value =  value?.id?.toString();
                                        },
                                      );
                                    }),

                                    const SizedBox(height: 10),

                                    const SizedBox(height: 10),

                                    CustomLabeledPickerTextField(
                                      label: AppText.fromDate,
                                      isRequired: false,
                                      controller: leadListController.fromDateController,
                                      inputType: TextInputType.name,
                                      hintText: "YYYY-MM-DD",
                                      validator: ValidationHelper.validateFromDate,
                                      isDateField: true,
                                    ),

                                    CustomLabeledPickerTextField(
                                      label: AppText.toDate,
                                      isRequired: false,
                                      controller: leadListController.toDateController,
                                      inputType: TextInputType.name,
                                      hintText: AppText.mmddyyyy,
                                      validator: ValidationHelper.validateFromDate,
                                      isDateField: true,
                                    ),

                                    Obx((){
                                      if(addleadcontroller.isLoading.value){
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
                                    const SizedBox(
                                      height: 10,
                                    ),

                                  ],
                                ),

                              ],
                            ),



                            const SizedBox(height: 20),

                            Row(
                              children: [
                                Text(
                                  AppText.searchedLeads,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                               Obx(()=> Text(
                                 leadListController.filteredGetAllLeadsModel.value == null ||
                                     leadListController.filteredGetAllLeadsModel.value!.data == null || leadListController.filteredGetAllLeadsModel.value!.data!.isEmpty?"(0)":

                                 " (${ leadListController.filteredLeadListLength.value.toString()})",
                                 style: TextStyle(
                                   fontSize: 20,
                                   // fontWeight: FontWeight.bold,
                                 ),
                               )),
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
            AppText.searchLeads,
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
    var dt=leadDDController.selectedStage.value??"0";
    leadListController.selectedPrevStage.value=dt;

    var temp=leadDDController.selectedStage.value??"0";
    // leadListController.leadCode.value=temp;
    leadListController.filteredleadCode.value=temp;

    leadListController.getFilteredLeadsApi(
      employeeId: leadListController.eId.value.toString(),
      leadStage:temp,
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
                      AppImage.searchLotie,
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

  Widget leadSection(BuildContext context){
    return Obx((){
      if (leadListController.isFilteredLoading.value) {
        return  Center(child: CustomSkelton.productShimmerList(context));
      }
      if (leadListController.filteredGetAllLeadsModel.value == null ||
          leadListController.filteredGetAllLeadsModel.value!.data == null || leadListController.filteredGetAllLeadsModel.value!.data!.isEmpty) {
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
            itemCount: leadListController.filteredGetAllLeadsModel.value!.data!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {

              final lead = leadListController.filteredGetAllLeadsModel.value!.data![index];

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
                                    lead.name==null?"N":lead.name!.isNotEmpty ?  lead.name![0].toUpperCase() : "U", // Initial Letter
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.39,
                                    child: Text(
                                      Helper.capitalizeEachWord(lead.name.toString()),

                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,

                                      // lead.name.toString(),
                                      style: GoogleFonts.merriweather(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 10,
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                        decoration:  BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: AppColor.grey200),
                                          color: AppColor.grey1,
                                        ),
                                      ),
                                      Text(
                                        lead.mobileNumber.toString(),
                                        style: TextStyle(
                                          color: AppColor.grey700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),

                          if(leadListController.filteredleadCode.value=="4" ||leadListController.filteredleadCode.value=="6" )
                            _buildTextButton(
                              label:AppText.openPoll,
                              context: context,
                              color: Colors.purple,
                              icon:  Icons.lock_open,
                              leadId: lead.id.toString(),
                              label_code: "open_poll",
                              uln: lead.uniqueLeadNumber.toString(),
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
                          //_buildDetailRow("Uploaded on", lead.uploadedDate.toString()),
                          _buildDetailRow("Campaign",/*"Summer Sale"*/ lead.campaign??"  -  "),
                          _buildDetailRow("Status", lead.stageName.toString()??""),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),

                    /// Action Buttons (Call, Chat, Mail, WhatsApp, Status)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          _buildIconButton(icon: AppImage.call1, color: AppColor.orangeColor, phoneNumber: lead.mobileNumber.toString(), label: "call", leadId: lead.id.toString(), currentLeadStage:  lead.leadStage.toString(),context: context),
                          _buildIconButton(icon: AppImage.whatsapp, color: AppColor.orangeColor, phoneNumber: lead.mobileNumber.toString(), label: "whatsapp", leadId: lead.id.toString(), currentLeadStage:  lead.leadStage.toString(), context: context),
                          _buildIconButton(icon: AppImage.message1, color: AppColor.orangeColor, phoneNumber: lead.mobileNumber.toString(), label: "message", leadId: lead.id.toString(), currentLeadStage:  lead.leadStage.toString(),context: context),
                          //_buildIconButton(icon: AppImage.chat1, color: AppColor.orangeColor, phoneNumber: lead.mobileNumber.toString(), label: "chat" ),
                          InkWell(
                            onTap: () {
                              //Get.toNamed("/leadDetailsMain", arguments: {"leadId":lead.id.toString()});
                              Get.toNamed("/leadDetailsTab", arguments: {"leadId":lead.id.toString()});

                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16), // Adjust padding as needed
                              decoration: BoxDecoration(
                                color: AppColor.orangeColor, // Button background color
                                borderRadius: BorderRadius.circular(2), // Rounded corners
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.file_copy,size: 10,color: AppColor.appWhite,),
                                  SizedBox(width: 5,),
                                  Text(
                                    AppText.details,
                                    style: TextStyle(color: AppColor.appWhite),
                                  )
                                ],
                              ),
                            ),
                          )

                        ],
                      ),
                    ),
                    SizedBox(height: 10),


                    SizedBox(height: 10),



                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [


                          _buildTextButton(
                            label:AppText.changeLeadStatus,
                            context: context,
                            color: Colors.purple,
                            icon:  Icons.add_circle_outline_outlined,
                            leadId: lead.id.toString(),
                            label_code: "change_lead_st",
                            currentLeadStage: lead.leadStage.toString(),
                            uln: lead.uniqueLeadNumber.toString(),
                          ),

                          /*_buildTextButton(
                            label:AppText.addFollowUp,
                            context: context,
                            color: Colors.purple,
                            icon:  Icons.call,
                            leadId: lead.id.toString(),
                            label_code: "add_feedback",
                            currentLeadStage: lead.leadStage.toString(),
                            uln: lead.uniqueLeadNumber.toString(),
                          ),*/


                      ],
                    ),


                    SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        if(lead.leadStage.toString()=="4" )
                          _buildTextButton(
                              label:AppText.fillLeadForm,
                              context: context,
                              color: Colors.purple,
                              icon:  Icons.person_outline_outlined,
                              leadId: lead.id.toString(),
                              label_code: "add_lead_form",
                              currentLeadStage: lead.leadStage.toString(),
                              uln: lead.uniqueLeadNumber.toString()
                          ),
                        if(lead.leadStage.toString()=="4" || lead.leadStage.toString()=="6" ||lead.leadStage.toString()=="0" ||
                            lead.leadStage.toString()=="5" || lead.leadStage.toString()=="7"
                        )...[
                          _buildTextButton(
                              label:AppText.addFollowUp,
                              context: context,
                              color: Colors.purple,
                              icon:  Icons.call,
                              leadId: lead.id.toString(),
                              label_code: "add_feedback",
                              currentLeadStage: lead.leadStage.toString(),
                              uln: lead.uniqueLeadNumber.toString()
                          ),

                        ],
                      ],
                    ),

                  ],
                ),
              );

            },
          ),
          if (leadListController.filteredHasMore.value)
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
            ),
        ],
      );
    });
  }

  Widget _buildTextButton({
    required String label,
    required BuildContext context,
    required Color color,
    required IconData icon,
    required String leadId,
    required String label_code,
    String? currentLeadStage,
    required String uln,
  }) {

    return InkWell(
      onTap: () {
        if (label == "Open Poll") {
          leadListController.openPollPercentController.clear();
          showOpenPollDialog2(context: context,leadId: leadId);
        }else if (label_code == "add_lead_form") {

          addLeadController.fromWhere.value="interested";
          addLeadController.getLeadId.value=leadId;
          addLeadController.getLeadDetailByIdApi(leadId: leadId);

          AddProductController addProductController = Get.put(AddProductController());
          addProductController.getAllProductCategoryApi();

          ViewProductController viewProductController=Get.put(ViewProductController());
          viewProductController.getAllProductListApi();
          addLeadController.clearControllers();

          CamNoteController camNoteController=Get.put(CamNoteController());
          camNoteController.getAllPackageMasterApi();
          camNoteController.currentStep.value=0;

          Get.toNamed("/camNoteGroupScreen",);

        }else if (label_code == "add_feedback") {

          leadListController.callFeedbackController.clear();
          leadListController.leadFeedbackController.clear();
          leadListController.followDateController.clear();
          leadListController.followTimeController.clear();
          showFollowupDialog(
              context: context,
              leadId: leadId,
              currentLeadStage: currentLeadStage.toString(),
              callDuration: "00:00",
              callStartTime:  "00:00",
              callEndTime: "00:00",
              callStatus: "0"
          );

        }else if (label_code == "interested" || label_code =="not_interested" || label_code == "doable" || label_code =="not_doable" || label_code == "cc") {
          showDialog(
            context: context,
            builder: (context) {
              return CustomDialogBox(
                title: "Are you sure?",

                onYes: () {


                },
                onNo: () {

                },
              );
            },
          );
        }else if (label_code == "change_lead_st"){

          showFilterDialog(
            context: context,
            leadId: leadId,
            leadStageId: currentLeadStage
          );
        } else{

        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            width:(label_code=="add_feedback" ) ?
            MediaQuery.of(context).size.width*0.40: label_code=="open_poll"?
            MediaQuery.of(context).size.width*0.25 :MediaQuery.of(context).size.width*0.40,

            decoration: BoxDecoration(
              //color: color,
                color: label_code=="add_feedback"?AppColor.primaryColor:Colors.transparent,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColor.grey700)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: label_code=="add_feedback"?AppColor.appWhite:AppColor.grey700, size: 16),
                SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(fontSize: label_code=="open_poll"? 10:11, fontWeight: FontWeight.w600, color: label_code=="add_feedback"?AppColor.appWhite: AppColor.grey700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {

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
          label=="Campaign"?
          value=="  -  "|| value==""?
          Text(
            ":  -  ",

            style: TextStyle(color: Colors.black87),
          ):
          Container(
            color: AppColor.lightPrimary2,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            child: Text(
              "${value}",

              style: TextStyle(color: AppColor.primaryColor),
            ),
          ):
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
    required String leadId,
    required String currentLeadStage,
    required BuildContext context,
  }) {
    return IconButton(
      onPressed: () {

        if(label=="call"){

          leadListController.isFBDetailsShow.value=false;
          leadListController.followDateController.text="";
          leadListController.followTimeController.text="";
          leadDDController.selectedStage.value=currentLeadStage;

          CallService callService = CallService();
          callService.makePhoneCall(
            phoneNumber:phoneNumber,//phoneNumber,//phoneNumber,//"+919399299880",//phoneNumber
            leadId: leadId,
            currentLeadStage: currentLeadStage,//newLeadStage,
            context: context,
            showFeedbackDialog:showCallFeedbackDialog,
          );


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

  void showOpenPollDialog2({
    required BuildContext context,
    required leadId,
  }) {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomBigDialogBox(
          titleBackgroundColor: AppColor.secondaryColor,

          title: "Open Poll",
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10,
                ),


                // 📝 Content (Radio Buttons)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
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
                        hintText: "Enter open poll percentage",
                        validator: validatePercentage,
                        isPassword: false,
                        obscureText: false,
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
          onSubmit: () {
            if (_formKey.currentState!.validate()) {
              leadListController.leadMoveToCommonTaskApi(
                  leadId: leadId,
                  percentage: leadListController.openPollPercentController.text.trim().toString()
              );
              Navigator.pop(context);
            }
          },
        );
      },
    );
  }
///new

  void showCallFeedbackDialog({
    required BuildContext context,
    required leadId,
    required currentLeadStage,
    required callDuration,
    required callStartTime,
    required callEndTime,
    required callStatus,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        //LeadListController leadListController =Get.find();
        return CustomBigDialogBox(
          titleBackgroundColor: AppColor.secondaryColor,
          title: AppText.addFAndF,
          content: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(Get.context!).size.height * 0.7, // Prevents overflow
            ),
            child: SingleChildScrollView(
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///Call and lead FB

                    const SizedBox(height: 20),

                    if(callStatus=="0" && (currentLeadStage=="13" || currentLeadStage=="4" || currentLeadStage=="5" || currentLeadStage=="6" || currentLeadStage=="7"))
                      CustomLabeledPickerTextField(
                        label: AppText.leadStage,
                        isRequired: false,
                        controller: leadListController.couldNotController,
                        inputType:TextInputType.name,
                        hintText: "",
                        enabled: false,
                      ),


                    ///Status change
                    if(callStatus=="1")
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            AppText.leadStage,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColor.grey2,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Obx((){
                            if (leadDDController.isLeadStageLoading.value) {
                              return  Center(child:CustomSkelton.leadShimmerList(context));
                            }

                            int leadCode = int.parse(leadListController.filteredleadCode.value); // Assuming this is reactive or available

                            // Allowed stage IDs based on leadCode
                            List<int> allowedStageIds = [];

                            if (leadCode == 2) {
                              allowedStageIds = [4, 5];
                            }else if (leadCode == 3) {
                              allowedStageIds = [4, 5,];
                            } else if (leadCode == 4) {
                              allowedStageIds = [6, 7,];
                            }else if (leadCode == 5) {
                              allowedStageIds = [4, 5,];
                            }else if (leadCode == 6) {
                              allowedStageIds = [6, 7];
                            }else if (leadCode == 7) {
                              allowedStageIds = [6, 7];
                            }else if (leadCode == 13) {
                              allowedStageIds = [4, 5,];
                            } else {
                              allowedStageIds = [4,5]; // Default to all or handle as needed
                            }

                            List<stage.Data> filteredStages = leadDDController
                                .getAllLeadStageModel.value!.data!
                                .where((lead) =>
                            lead.id != 1 && allowedStageIds.contains(lead.id))
                                .toList();

                            return CustomDropdown<stage.Data>(
                              items: filteredStages,
                              getId: (item) =>item.id.toString(),  // Adjust based on your model structure
                              getName: (item) => item.stageName.toString(),
                              selectedValue: filteredStages.firstWhereOrNull(
                                    (item) => item.id.toString() == leadDDController.selectedStage.value,

                              ),
                              onChanged: (value) {
                                leadDDController.selectedStage.value =  value?.id?.toString();

                                if( leadDDController.selectedStage.value!=null){
                                  if (int.parse(leadDDController.selectedStage.value!) == 3) {
                                    leadDDController.selectedStageActive.value = 1;

                                  } else if (int.parse(leadDDController.selectedStage.value!) == 4) {
                                    leadDDController.selectedStageActive.value = 1;
                                    leadListController.isFBDetailsShow.value=true;

                                  } else if (int.parse(leadDDController.selectedStage.value!) == 5) {
                                    leadDDController.selectedStageActive.value = 0;
                                    leadListController.isFBDetailsShow.value=false;
                                  }  else if (int.parse(leadDDController.selectedStage.value!) == 6) {
                                    leadDDController.selectedStageActive.value = 1;
                                    leadListController.isFBDetailsShow.value=true;
                                  } else if (int.parse(leadDDController.selectedStage.value!) == 7) {
                                    leadDDController.selectedStageActive.value = 0;
                                    leadListController.isFBDetailsShow.value=false;
                                  }else if (int.parse(leadDDController.selectedStage.value!) == 13) {
                                    leadDDController.selectedStageActive.value = 0;
                                  }else {

                                  }


                                }


                              },
                            );
                          }),
                          const SizedBox(height: 20),
                          Obx(()=> Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (leadListController.isFBDetailsShow.value==true) ...[
                                SizedBox(height: 15),
                                CustomLabeledTextField(
                                  label: AppText.callFeedback,
                                  isRequired: false,
                                  controller: leadListController.callFeedbackController,
                                  inputType: TextInputType.name,
                                  hintText: AppText.enterCallFeedback,
                                  isTextArea: true,
                                ),
                                SizedBox(height: 15),
                                CustomLabeledTextField(
                                  label: AppText.leadFeedback,
                                  isRequired: false,
                                  controller: leadListController.leadFeedbackController,
                                  inputType: TextInputType.name,
                                  hintText: AppText.enterLeadFeedback,
                                  isTextArea: true,
                                ),
                                const SizedBox(height: 20),
                              ]
                            ],
                          ))
                        ],
                      ),


                    /// rest is cal reminder
                    Obx(()=>Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if(leadListController.isFBDetailsShow.value==true || callStatus=="0")...[
                          Text(
                            "Need to set a reminder? select the checkbox",
                            style:  GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.black54,
                              //fontWeight: FontWeight.w700


                            ),
                          ),
                          Row(
                            children: [
                              Obx(()=>Checkbox(
                                activeColor: AppColor.secondaryColor,
                                value: leadListController.isCallReminder.value,
                                onChanged: (bool? value) {

                                  leadListController.isCallReminder.value = value ?? false;

                                },
                              )),
                              Text(
                                AppText.callReminder,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Obx(()=> CustomLabeledPickerTextField(
                            label: AppText.selectDate,
                            isRequired: false,
                            controller: leadListController.followDateController,
                            inputType: TextInputType.name,
                            hintText: "MM/DD/YYYY",
                            isDateField: true,
                            enabled: leadListController.isCallReminder.value,
                          )),
                          Obx(()=>CustomLabeledTimePickerTextField(
                            label: AppText.selectTime,
                            isRequired: false,
                            controller: leadListController.followTimeController,
                            inputType: TextInputType.datetime,
                            hintText: "HH:MM AM/PM",
                            isTimeField: true,
                            enabled: leadListController.isCallReminder.value,
                          )),
                        ]
                      ],
                    ))
                  ],
                ),
              ),
            ),
          ),
          onSubmit: () {
            var id=leadListController.workOnLeadModel!.data!.id.toString();
            if(callStatus=="1"){
              callDuration=leadListController.workOnLeadModel!.data!.callDuration.toString();
              callStartTime=leadListController.workOnLeadModel!.data!.callStartTime.toString();
              callEndTime=leadListController.workOnLeadModel!.data!.callEndTime.toString();

            }


            leadListController.callFeedbackSubmit(
                leadId: leadId,
                currentLeadStage: currentLeadStage,
                callStatus: callStatus,
                callDuration: callDuration,
                callStartTime: callStartTime,
                callEndTime: callEndTime,
                id: id,
                fromWhere: "call",
                selectedStage: leadDDController.selectedStage.value

            );
            Get.back();

          },
        );
      },
    );
  }




  void showFollowupDialog({
    required BuildContext context,
    required leadId,
    required currentLeadStage,
    required callDuration,
    required callStartTime,
    required callEndTime,
    required callStatus,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        leadListController.isCallReminder.value =true;
        return CustomBigDialogBox(
          titleBackgroundColor: AppColor.secondaryColor,
          title: AppText.addFollowUp,
          content: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.7, // Prevents overflow
            ),
            child: SingleChildScrollView(
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    CustomLabeledTextField(
                      label: AppText.followupNote,
                      isRequired: false,
                      controller: leadListController.callFeedbackController,
                      inputType: TextInputType.name,
                      hintText: AppText.enterCallFeedback,
                      isTextArea: true,
                    ),

                    Obx(()=> CustomLabeledPickerTextField(
                      label: AppText.selectDate,
                      isRequired: false,
                      controller: leadListController.followDateController,
                      inputType: TextInputType.name,
                      hintText: "MM/DD/YYYY",
                      isDateField: true,
                      enabled: leadListController.isCallReminder.value,
                    )),
                    Obx(()=>CustomLabeledTimePickerTextField(
                      label: AppText.selectTime,
                      isRequired: false,
                      controller: leadListController.followTimeController,
                      inputType: TextInputType.datetime,
                      hintText: "HH:MM AM/PM",
                      isTimeField: true,
                      enabled: leadListController.isCallReminder.value,
                    )),
                  ],
                ),
              ),
            ),
          ),
          onSubmit: () {
            var id=0;

            leadListController.callFeedbackSubmit(
                leadId: leadId,
                currentLeadStage: currentLeadStage,
                callStatus: callStatus,
                callDuration: callDuration,
                callStartTime: callStartTime,
                callEndTime: callEndTime,
                id: id.toString(),
                fromWhere: "follow_up",
                selectedStage: "" ///Static
            );
            Get.back();
          },
        );
      },
    );
  }

  void showFilterDialog({
    required BuildContext context,
    required leadId,
    required leadStageId,
  }) {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.microtask(() {
          leadDDController.selectedStage.value = leadStageId;
          leadDDController.changeActiveStatus(leadStageId.toString());
        });
        return CustomBigDialogBox(
          titleBackgroundColor: AppColor.secondaryColor,

          title: "Change Lead Status",
          content: Form(
            key: _formKey2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(
                  height: 10,
                ),


                SizedBox(height: 10),


                Obx((){
                  if (leadDDController.isLeadStageLoading.value) {
                    return  Center(child:CustomSkelton.leadShimmerList(context));
                  }


                  return CustomDropdown<stage.Data>(
                    items: leadDDController.getAllLeadStageModel.value!.data!.where((lead) => lead.id != 1).toList(),
                    getId: (item) =>item.id.toString(),  // Adjust based on your model structure
                    getName: (item) => item.stageName.toString(),
                    selectedValue: leadDDController.getAllLeadStageModel.value?.data?.firstWhereOrNull(
                          (item) => item.id.toString() == leadDDController.selectedStage.value,
                    ),
                    onChanged: (value) {
                      leadDDController.selectedStage.value =  value?.id?.toString();
                      if( leadDDController.selectedStage.value!=null){
                        if (int.parse(leadDDController.selectedStage.value!) == 3) {
                          leadDDController.selectedStageActive.value = 1;
                        } else if (int.parse(leadDDController.selectedStage.value!) == 4) {
                          leadDDController.selectedStageActive.value = 1;
                        } else if (int.parse(leadDDController.selectedStage.value!) == 5) {
                          leadDDController.selectedStageActive.value = 0;
                        }  else if (int.parse(leadDDController.selectedStage.value!) == 6) {
                          leadDDController.selectedStageActive.value = 1;
                        } else if (int.parse(leadDDController.selectedStage.value!) == 7) {
                          leadDDController.selectedStageActive.value = 0;
                        }else if (int.parse(leadDDController.selectedStage.value!) == 13) {
                          leadDDController.selectedStageActive.value = 0;
                        }else {

                        }


                      }

                    },
                  );
                }),

                const SizedBox(height: 20),




              ],
            ),
          ),

          onSubmit: (){
            if (leadDDController.selectedStage.value!=null || leadDDController.selectedStage.value!="") {

              leadListController.workOnLeadAndStageUpdateApi(
                leadId: leadId.toString(),
                leadStageStatus:leadDDController.selectedStage.value.toString(),

              );
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
              );
              Get.back();
            }else{
              ToastMessage.msg("Please select stage");
            }


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


