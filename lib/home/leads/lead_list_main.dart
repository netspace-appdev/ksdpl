import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ksdpl/controllers/bot_nav_controller.dart';
import 'package:ksdpl/controllers/camnote/camnote_controller.dart';
import 'package:ksdpl/controllers/dashboard/DashboardController.dart';
import 'package:ksdpl/controllers/leads/addLeadController.dart';
import 'package:ksdpl/controllers/leads/loan_appl_controller.dart';
import 'package:lottie/lottie.dart';
import '../../common/CustomSearchBar.dart';
import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../common/storage_service.dart';
import '../../controllers/greeting_controller.dart';
import '../../controllers/lead_dd_controller.dart';
import '../../controllers/leads/infoController.dart';
import '../../controllers/leads/leadlist_controller.dart';
import '../../controllers/product/add_product_controller.dart';
import '../../controllers/product/view_product_controller.dart';
import '../../custom_widgets/CustomBigDialogBox.dart';
import '../../custom_widgets/CustomDialogBox.dart';
import '../../custom_widgets/CustomDropdown.dart';
import '../../custom_widgets/CustomIconDilogBox.dart';
import '../../custom_widgets/CustomLabelPickerTextField.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';
import '../../custom_widgets/CustomLabeledTextField2.dart';
import '../../custom_widgets/CustomLabeledTimePicker.dart';
import '../../custom_widgets/CustomTextFieldPrefix.dart';
import '../../services/call_service.dart';
import '../custom_drawer.dart';
import 'package:ksdpl/models/leads/GetAllLeadStageModel.dart' as stage;

class LeadListMain extends StatelessWidget {
  GreetingController greetingController = Get.put(GreetingController());
  InfoController infoController = Get.put(InfoController());
  LeadListController leadListController = Get.put(LeadListController(),);
  final TextEditingController _searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Addleadcontroller addLeadController = Get.put(Addleadcontroller());
  LeadDDController leadDDController=Get.find();
  BotNavController botNavController = Get.find();



  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        key:_scaffoldKey,

        backgroundColor: AppColor.backgroundColor,
        drawer:   CustomDrawer(),
        body: RefreshIndicator(
          onRefresh: () async {
            await leadListController.refreshItems(); // Make sure this triggers API call
          },
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
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

                        SizedBox(
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
                          SizedBox(
                            height: 10,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(()=> Row(
                                children: [

                                  Text(
                                    "",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  Container(
                                   // width: MediaQuery.of(context).size.width*0.50,
                                    child: Text(
                                      leadListController.leadStageName2.value.toString(),
                                      style: GoogleFonts.roboto(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    leadListController.getAllLeadsModel.value == null ||
                                        leadListController.getAllLeadsModel.value!.data == null || leadListController.getAllLeadsModel.value!.data!.isEmpty?"(0)":

                                    " (${ leadListController.leadListLength.value.toString()})",
                                    style: TextStyle(
                                      fontSize: 20,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )),
                              InkWell(
                                onTap: (){
                                  LeadDDController leadDDController=Get.find();
                                  leadDDController.getAllKsdplProductApi();
                                  AddProductController addProductController =Get.put(AddProductController());
                                  addProductController.getAllProductCategoryApi();
                                  addLeadController.fromWhere.value="leadList";
                                 addLeadController.clearControllers();
                                  CamNoteController camNoteController=Get.put(CamNoteController());
                                  Get.toNamed("/addLeadScreen");
                                },
                                child: const Row(

                                  children: [
                                    Icon(Icons.add,color: AppColor.orangeColor,size: 16,),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      AppText.addLead,
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
                          const SizedBox(
                            height: 20,
                          ),
                          leadSection(context)
                        ],
                      ),
                    ),
                  ),
                ],
              )
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
          leadListController.fromWhere.value=="drawer"?
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
    ):
          InkWell(
              onTap: (){
                _scaffoldKey.currentState?.openDrawer();
              },
              child: SvgPicture.asset(AppImage.drawerIcon)),

          Text(
            "Leads",
            style:  GoogleFonts.merriweather(
                fontSize: 20,
                color: AppColor.grey3,
                fontWeight: FontWeight.w700


            ),
          ),
          InkWell(
            onTap: (){
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

  Widget searchArea(){
    return Row(
      children: [
        Expanded(
          child: CustomSearchBar(
            controller: _searchController,
            onChanged: (val){},
            hintText: "Search Leads...",
          ),
        ),
        Container(

          width: 50,
          height:50,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: const BoxDecoration(
            color: AppColor.backgroundColor,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Center(child: Image.asset(AppImage.filterIcon, height: 22,)),
        )
      ],
    );
  }

  Widget leadSection(BuildContext context){
    return Obx((){
      if (leadListController.isLoading.value) {
        return  Center(child: CustomSkelton.productShimmerList(context));
      }
      if (leadListController.getAllLeadsModel.value == null ||
          leadListController.getAllLeadsModel.value!.data == null || leadListController.getAllLeadsModel.value!.data!.isEmpty) {
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
            itemCount: leadListController.getAllLeadsModel.value!.data!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {

              final lead = leadListController.getAllLeadsModel.value!.data![index];

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

                          if(lead.leadStage.toString()=="4" ||lead.leadStage.toString()=="6" )
                            _buildTextButton(
                              label:AppText.openPoll,
                              context: context,
                              color: Colors.purple,
                              icon:  Icons.lock_open,
                              leadId: lead.id.toString(),
                              label_code: "open_poll",
                              uln: lead.uniqueLeadNumber.toString()

                            ),

                        ],
                      ),
                    ),
                    SizedBox(height: 10),

                    /// Lead details
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          _buildDetailRow("Email", lead.email==null?"  -  ":lead.email.toString(), lead.leadStage??0),
                          _buildDetailRow("Assigned", lead.assignedEmployeeDate.toString(),lead.leadStage??0),
                          _buildDetailRow("Campaign",/*"Summer Sale"*/ lead.campaign??"  -  ",lead.leadStage??0),
                          _buildDetailRow("Status", lead.stageName.toString()??"",lead.leadStage??0),
                          if(lead.leadStage==4)
                            _buildDetailRow("Cam Note Count", lead.camNoteCount.toString()??"0",lead.leadStage??0),

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

                          (lead.leadStage.toString()=="3" && lead.reminderDate.toString()=="null")?
                           _buildIconButton(icon: AppImage.call_disable, color: AppColor.orangeColor, phoneNumber: lead.mobileNumber.toString(), label: "call_disable", leadId: lead.id.toString(), currentLeadStage:  lead.leadStage.toString(),context: context)
                          :_buildIconButton(icon: AppImage.call1, color: AppColor.orangeColor, phoneNumber: lead.mobileNumber.toString(), label: "call", leadId: lead.id.toString(), currentLeadStage:  lead.leadStage.toString(),context: context),
                          _buildIconButton(icon: AppImage.whatsapp, color: AppColor.orangeColor, phoneNumber: lead.mobileNumber.toString(), label: "whatsapp", leadId: lead.id.toString(), currentLeadStage:  lead.leadStage.toString(), context: context),
                          _buildIconButton(icon: AppImage.message1, color: AppColor.orangeColor, phoneNumber: lead.mobileNumber.toString(), label: "message", leadId: lead.id.toString(), currentLeadStage:  lead.leadStage.toString(),context: context),

                          InkWell(
                            onTap: () {

                              Get.toNamed("/leadDetailsTab", arguments: {"leadId":lead.id.toString()});

                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16), // Adjust padding as needed
                              decoration: BoxDecoration(
                                color: AppColor.orangeColor, // Button background color
                                borderRadius: BorderRadius.circular(2), // Rounded corners
                              ),
                              child: const Row(
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
                    //mamshi add new api
                    lead.leadStage==10||lead.leadStage==11?Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 8.0),
                          child: InkWell(
                            onTap:(){
                              print('dvashgvdvad${lead.uniqueLeadNumber}');
                              leadListController.callGetdisburseHistoryByUniqueLeadNoApi(lead.uniqueLeadNumber);
                              showUpdateDisburseHistorySheet(context);
                             },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              width:double.infinity,
                              decoration: BoxDecoration(
                                  color: AppColor.primaryColor,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: AppColor.grey700)
                              ),
                              child: const Center(
                                child: Text(
                                  AppText.updateDisburseHistory,
                                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColor.appWhite),
                                ),
                              ),
                            ),
                          ),
                    ):SizedBox(),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if(lead.leadStage.toString()=="8"||lead.leadStage.toString()=="9")...[
                            lead.leadStage.toString()=="9"?SizedBox(): InkWell(
                            onTap:(){

                              showDialog(
                                context: context,
                                builder: (context) {
                                  return CustomIconDialogBox(
                                    title: "Are you sure?",
                                    icon: Icons.info_outline,
                                    iconColor: AppColor.secondaryColor,
                                    description: "Do you want this lead to be added to Under Review ?",
                                    onYes: () {
                                      print('here call update lead stage');

                                      var empId=StorageService.get(StorageService.EMPLOYEE_ID).toString();

                                        leadListController.updateLeadStageApiForCall(
                                          id:lead.id.toString(),
                                          active: '1',
                                          stage:'9',
                                          empId: empId.toString(),
                                        );
                                    },
                                    onNo: () {

                                    },
                                  );
                                },
                              );
                             },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                              width:MediaQuery.of(context).size.width/3,

                              decoration: BoxDecoration(
                                  color: AppColor.primaryColor,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: AppColor.grey700)
                              ),
                              child: Center(
                                child: Text(
                                  AppText.underReview,
                                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColor.appWhite),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 6),

                         InkWell(
                            onTap:() async {
                              if (lead.leadStage.toString() == "9") {
                                // Await the API call first
                                await leadListController.callGetSoftSanctionByLeadIdAndBankIdApi(lead.id.toString());

                                // After API completes, open bottom sheet
                                showSanctionDialog(
                                  context,
                                  lead.uniqueLeadNumber.toString(),
                                );
                              } else {
                                // If condition not met, just open the sheet directly
                                showSanctionDialog(
                                  context,
                                  lead.uniqueLeadNumber.toString(),
                                );
                              }
                           //   lead.leadStage.toString()=="9"? leadListController.callGetSoftSanctionByLeadIdAndBankIdApi():
                            //  showSanctionDialog(context, lead.uniqueLeadNumber.toString());
                               },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                              width:lead.leadStage.toString()=="9"?MediaQuery.of(context).size.width*0.76:MediaQuery.of(context).size.width/3,
                              decoration: BoxDecoration(
                                  color: AppColor.primaryColor,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: AppColor.grey700)
                              ),
                              child:
                              const Center(
                                child: Text(
                                  AppText.appSaction,
                                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColor.appWhite),
                                ),
                              ),
                            ),
                          ),
                        ],
              ],
                      ),
                    ),

                    /// Bottom Row Buttons (Assigned, Follow Up, Call Back, Employment)
                    Row(
                      mainAxisAlignment:leadListController.leadCode.value=="6"? MainAxisAlignment.center: MainAxisAlignment.spaceBetween,
                      children: [

                        if(lead.leadStage.toString()=="4")...[

                          _buildTextButton(
                            label:AppText.doable,
                            context: context,
                            color: Colors.purple,
                            icon:  Icons.thumb_up_alt_outlined,
                            leadId: lead.id.toString(),
                            label_code: "doable",
                              uln: lead.uniqueLeadNumber.toString()
                          ),
                          _buildTextButton(
                            label:AppText.notDoable,
                            context: context,
                            color: Colors.purple,
                            icon:  Icons.thumb_down_alt_outlined,
                            leadId: lead.id.toString(),
                            label_code: "not_doable",
                              uln: lead.uniqueLeadNumber.toString()
                          )
                        ]
                        else if(lead.leadStage.toString()=="2" || lead.leadStage.toString()=="13" || lead.leadStage.toString()=="3" )...[

                          _buildTextButton(
                            label:AppText.interested,
                            context: context,
                            color: Colors.purple,
                            icon:  Icons.thumb_up_alt_outlined,
                            leadId: lead.id.toString(),
                            label_code: "interested",
                              uln: lead.uniqueLeadNumber.toString()
                          ),
                          _buildTextButton(
                            label:AppText.notInterested,
                            context: context,
                            color: Colors.purple,
                            icon:  Icons.thumb_down_alt_outlined,
                            leadId: lead.id.toString(),
                            label_code: "not_interested",
                              uln: lead.uniqueLeadNumber.toString()

                          ),
                        ]
                      ],
                    ),
                    SizedBox(height: 10),

                    Row(
                      mainAxisAlignment:leadListController.leadCode.value=="6"? MainAxisAlignment.center: MainAxisAlignment.spaceBetween,
                      children: [
                        if(lead.leadStage.toString()=="2" || lead.leadStage.toString()=="3" )...[

                          _buildTextButton(
                            label:AppText.couldntConneect,
                            context: context,
                            color: Colors.purple,
                            icon:  Icons.phone_callback,
                            leadId: lead.id.toString(),
                            label_code: "cc",
                            currentLeadStage: lead.leadStage.toString(),
                              uln: lead.uniqueLeadNumber.toString()
                          ),
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


                    if(lead.leadStage.toString()=="6" )
                      Column(
                      children: [
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            if(lead.leadStage.toString()=="6" )
                              _buildTextButton(
                                label:AppText.loanApplicationForm,
                                context: context,
                                color: Colors.purple,
                                icon:  Icons.list_alt_rounded,
                                leadId: lead.id.toString(),
                                label_code: "loan_appl_form",
                                currentLeadStage: lead.leadStage.toString(),
                                  uln: lead.uniqueLeadNumber.toString()
                              ),

                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 10,),

                    if(lead.leadStage.toString()=="4" ||lead.leadStage.toString()=="6")
                      _buildTextButton(
                          label:"Cam Note Details",
                          context: context,
                          color: Colors.purple,
                          icon:  Icons.person_outline_outlined,
                          leadId: lead.id.toString(),
                          label_code: "cam_note_details",
                          currentLeadStage: lead.leadStage.toString(),
                          uln: lead.uniqueLeadNumber.toString()
                      ),


                    SizedBox(height: 10),

                    if(lead.leadStage.toString()=="6"&&lead.loanDetail!>0)
                      _buildTextButton(
                          label:"Update Loan Application",
                          context: context,
                          color: Colors.purple,
                          icon:  Icons.list_alt_rounded,
                          leadId: lead.id.toString(),
                          label_code: "update_loan_update",
                          currentLeadStage: lead.leadStage.toString(),
                          uln: lead.uniqueLeadNumber.toString()
                      ),

                  ],
                ),
              );

            },
          ),
          if (leadListController.hasMore.value)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: () {
                  print("load more===>00${leadListController.fromWhereLeads.value}");

                  DashboardController dashboardController = Get.find();
                  leadListController.fromWhereLeads.value=="dashboard"?
                  leadListController.getDetailsListOfLeadsForDashboardApi(
                    applyDateFilter: dashboardController.isLeadCountYearly.toString(), //changeit
                    stageId: leadListController.leadCode.value,
                    isLoadMore: true
                  ):

                  leadListController.getAllLeadsApi(
                    employeeId: leadListController.eId.value.toString(),
                    leadStage:leadListController.leadCode.value.toString(),
                    stateId: leadListController.stateIdMain.value.toString(),
                    distId: leadListController.distIdMain.value.toString(),
                    cityId:leadListController.cityIdMain.value.toString(),
                    campaign: leadListController.campaignMain.value.toString(),
                    fromDate: leadListController.fromDateMain.value,
                    toDate: leadListController.toDateMain.value,
                    branch: leadListController.branchMain.value.toString(),
                    uniqueLeadNumber:leadListController.uniqueLeadNumberMain.value.toString(),
                    leadMobileNumber:leadListController.leadMobileNumberMain.value.toString(),
                    leadName:leadListController.leadNameMain.value.toString(),
                    isLoadMore: true,
                  );

                },
                child:

                leadListController.isMainListMoreLoading.value //isDashboardLeadListMoreLoading
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

  void showSanctionDialog(BuildContext context, String uid) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomBigDialogBox(
          titleBackgroundColor: AppColor.secondaryColor,
          title: "",
          content: Obx(() {
            if (leadListController.isLoad.value) {
              return const Center(
                child: SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: AppColor.orangeColor,
                  ),
                ),
              );
            }

            return Form(
              key: _formKey2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),

                  // Sanction Amount Field
                  CustomLabeledTextField(
                    label: AppText.sanctionAmount,
                    isRequired: true,
                    controller: leadListController.sanctionAmountController,
                    inputType: TextInputType.number,
                    hintText: AppText.hintsanctionAmount,
                    isTextArea: false,
                    validator: validateSanctionAmount,
                  ),

                  const SizedBox(height: 15),

                  // Sanction Date Field
                  CustomLabeledPickerTextField(
                    label: AppText.sanctionDate,
                    isRequired: true,
                    controller: leadListController.sanctionDateController,
                    inputType: TextInputType.datetime,
                    hintText: AppText.mmddyyyy,
                    isDateField: true,
                    validator: validateSanctionDate,
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            );
          }),

          // Submit button
          onSubmit: () {
            if (_formKey2.currentState!.validate()) {
              leadListController.addSanctionDetailsApi(uln: uid);
            }
          },
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value, int leadStage) {

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
            width: 160,
            color: AppColor.lightPrimary2,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            child: Text(
             "${value}",
overflow: TextOverflow.ellipsis,
              style: TextStyle(color:  AppColor.primaryColor),
            ),
          ):
          leadStage==3 && label=="Status"?
          StatusChip(label: value, color: Colors.orange):
          Expanded(
            child: Text(
              label=="Assigned" ||  label=="Uploaded on"?": ${ Helper.formatDate(value)}":  ": ${value}",

              style:  TextStyle(color:Colors.black87),
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
  })
  {
    return IconButton(
      onPressed: () {
        print("currentLeadStage on call tap===>${currentLeadStage}");
        print("leadId on call tap===>${leadId}");

        if(label=="call"){
          leadListController.isFBDetailsShow.value=false;
          leadListController.followDateController.text="";
          leadListController.followTimeController.text="";
          leadDDController.selectedStage.value=currentLeadStage;
          CallService callService = CallService();
          callService.makePhoneCall(
            phoneNumber:phoneNumber,//phoneNumber,// phoneNumber,//"+919630749382",,//"+919238513910",//"+919201963012",,//"+919399299880", //
            leadId: leadId,
            currentLeadStage: currentLeadStage,//newLeadStage,
          /*  context: context,*/
            showFeedbackDialog:showCallFeedbackDialog,
          );


        }
        if(label=="whatsapp"){
          leadListController.openWhatsApp(phoneNumber: phoneNumber, message: AppText.whatsappMsg);
        }
        if(label=="message"){
          leadListController.sendSMS(phoneNumber: phoneNumber, message: AppText.whatsappMsg);
        }
        if(label=="call_disable"){

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

  Widget _disableTextButton({
    required String label,
    required BuildContext context,
    required Color color,
    required IconData icon,
    required String leadId,
    required String label_code,
    required String uln,
    String? currentLeadStage
  }) {

    return InkWell(
      onTap: null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            width:
            label_code=="loan_appl_form"?MediaQuery.of(context).size.width*0.82:
            (label_code=="add_feedback" ) ?
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
                Icon(icon, color: label_code=="add_feedback"?AppColor.appWhite:Colors.red, size: 16),
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



  Widget _buildTextButton({
    required String label,
    required BuildContext context,
    required Color color,
    required IconData icon,
    required String leadId,
    required String label_code,
    required String uln,
    String? currentLeadStage
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
          camNoteController.clearStep1();
          camNoteController.clearStep2();
          camNoteController.getAllPackageMasterApi();
          camNoteController.currentStep.value=0;
          camNoteController.infoFilledBankers.clear();
          camNoteController.infoFilledBankers.clear();
          camNoteController.selectedBankers.clear();
          camNoteController.bankerBranchMap.clear();
          camNoteController.clearImages("property_photo");
          camNoteController.clearImages("residence_photo");
          camNoteController.clearImages("office_photo");
          camNoteController.enableAllCibilFields.value=true;
          leadDDController.getAllKsdplProductApi();
          camNoteController.getCamNoteDetailByLeadIdApi(leadId: leadId);
          camNoteController.getProductDetailsByFilterModel.value=null;
          Get.toNamed("/camNoteGroupScreen",);

        }else if (label_code == "add_feedback") {

          leadListController.callFeedbackController.clear();
          leadListController.leadFeedbackController.clear();
          leadListController.followDateController.clear();
          leadListController.followTimeController.clear();
          leadListController.isCallReminder.value=false;
          leadDDController.selectedStage.value=currentLeadStage;
          showFollowupDialog(
              context: context,
              leadId: leadId,
              currentLeadStage: currentLeadStage.toString(),
              callDuration: "00:00",
              callStartTime:  "null",
              callEndTime: "null",
              callStatus: "0"
          );

        }else if (label_code == "interested" || label_code =="not_interested" || label_code == "doable" || label_code =="not_doable" || label_code == "cc") {
          showDialog(
            context: context,
            builder: (context) {
              return CustomDialogBox(
                title: "Are you sure?",

                onYes: () {
                  var empId=StorageService.get(StorageService.EMPLOYEE_ID).toString();
                  if (label_code == "interested") {

                    var isActive = leadListController.changeActiveStatus("4");
                    leadListController.updateLeadStageApiForCall(
                        id:leadId.toString(),
                        active: isActive.toString(),
                        stage:"4",
                        empId: empId.toString(),
                    );
                  } else if (label_code == "not_interested") {
                    var isActive = leadListController.changeActiveStatus("5");
                    leadListController.updateLeadStageApiForCall(
                        id:leadId.toString(),
                        active: isActive.toString(),
                        stage:"5",
                        empId: empId.toString()
                    );
                  } else if (label_code == "doable") {
                    var isActive = leadListController.changeActiveStatus("6");
                    leadListController.updateLeadStageApiForCall(
                        id:leadId.toString(),
                        active: isActive.toString(),
                        stage:"6",
                        empId: empId.toString()
                    );
                  } else if (label_code == "not_doable") {
                    var isActive = leadListController.changeActiveStatus("7");
                    leadListController.updateLeadStageApiForCall(
                        id:leadId.toString(),
                        active: isActive.toString(),
                        stage:"7",
                        empId: empId.toString()
                    );
                  } else if (label_code == "cc") {
                    var isActive = leadListController.changeActiveStatus("13");
                    leadListController.updateLeadStageApiForCall(
                        id:leadId.toString(),
                        active: isActive.toString(),
                        stage:"13",
                        empId: empId.toString()
                    );
                  }
                },
                onNo: () {

                },
              );
            },
          );
        }else if (label_code == "loan_appl_form") {

        leadDDController.getAllKsdplProductApi();
          Get.toNamed("/loanApplication", arguments: {
          'leadId': leadId.toString(),
          'uln': uln.toString(),
          });

        }

       //here we are call cam not update form
        else if (label_code == "cam_note_details") {
          print("leadId on tap-->${leadId}");


          addLeadController.getLeadDetailByIdApi(leadId: leadId);

          CamNoteController camNoteController=Get.put(CamNoteController());

          camNoteController.getCamNoteDetailByLeadIdApi(leadId: leadId);
          if(currentLeadStage=="4"){


            camNoteController.fromDoableOrInterested.value="4";
          }else{
            camNoteController.fromDoableOrInterested.value="6";
          }
          Get.toNamed("/camNoteDetailsScreen");

        }
        else if (label_code == "update_loan_update") {
          showUpdateLoanApplicationDialog(context,uln);
        }


        else{

        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            width:
            label_code=="loan_appl_form" || label_code=="cam_note_details"|| label_code=="update_loan_update" ?MediaQuery.of(context).size.width*0.82:
            (label_code=="add_feedback" ) ?
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
                      AppImage.handshake,
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



  void showLeadStatusDialog({
    required BuildContext context,
    required leadId,
  }) {
    List<String> options=[];
    if(leadListController.leadCode.value=="2"){
      options = ["Interested", "Not Interested"];
    }else  if(leadListController.leadCode.value=="4"){
      options = ["Doable", "Not Doable"];
    }else{

    }

    String? selectedOption = options[0]; // Default selection

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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 🔵 Title in Blue Strip
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color:AppColor.primaryColor, // Title background color
                        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                        gradient: LinearGradient(
                          colors: [AppColor.primaryLight, AppColor.primaryDark],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Text(
                        "Select Status:",
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: options.map((option) {
                          return RadioListTile<String>(
                            title: Text(option),
                            value: option,
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value;
                              });
                            },
                            activeColor: AppColor.orangeColor, // Change active radio button color
                          );
                        }).toList(),
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
                              String selectedValue = (selectedOption == "Interested") ? "4" : "5";
                              String activeValue = (selectedOption == "Interested") ? "1" : "0";

                              String selectedValueDoable = (selectedOption == "Doable") ? "6" : "7";
                              String activeValueDoable = (selectedOption == "Doable") ? "1" : "0";
                              if(leadListController.leadCode.value=="2"){


                                leadListController.workOnLeadApi(
                                  leadId: leadId.toString(),
                                  leadStageStatus:selectedValue,
                                );

                              }else  if(leadListController.leadCode.value=="4"){

                                leadListController.workOnLeadApi(
                                  leadId: leadId.toString(),
                                  leadStageStatus:selectedValue,
                                );
                              }else{

                              }

                              Navigator.pop(context); // Close dialog after submission
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
            );
          },
        );
      },
    );
  }
  void showUpdateLoanApplicationDialog(BuildContext context, String uln) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomBigDialogBox(
          titleBackgroundColor: AppColor.secondaryColor,
          title: "",
          content: Obx(() {
            if (leadListController.isLoad.value) {
              return const Center(
                child: SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                    color: AppColor.orangeColor,
                  ),
                ),
              );
            }

            return Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),

                      CustomLabeledTextField(
                        label: AppText.loanApplicationNo,
                        isRequired: true,
                        controller: leadListController.updateLoanFormController,
                        inputType: TextInputType.name,
                        hintText: AppText.enterLoanApplicationNo,
                        isTextArea: false,
                        validator: validateLoanApplicationNo,
                      ),

                      const SizedBox(height: 6),
                    ],
                  ),
                ),
              ),
            );
          }),
          onSubmit: () {
            if (formKey.currentState!.validate()) {
              leadListController.updateLoanFormApiCall(uln);
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

  String? validateLoanApplicationNo(String? value) {
    if (value == null || value.isEmpty) {
      return AppText.loanNumberRequired;
    }
    return null;
  }



  void showFilterDialog({
    required BuildContext context,
    required leadId,
  })
  {

   //working leads is now ongoing call
    List<String> options = ["All Leads","Fresh Leads","Ongoing Call","Could Not Connect", "Interested Leads",
      "Not Interested", "Doable Leads","Not Doable","Logged in","Under Review","Sanction","Partial Disbursed","Fully Disbursed"];

    showDialog(
      context: context,
      barrierDismissible: false,

      builder: (BuildContext context) {
        return CustomBigDialogBox(
          titleBackgroundColor: AppColor.secondaryColor,
          title: "Filter",
          content: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(Get.context!).size.height * 0.7, // Prevents overflow
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical:0 ),
                    child:  Obx(()=>Column(
                      children: options.asMap().entries.map((entry) {
                        int index = entry.key;
                        String option = entry.value;
              
                        return CheckboxListTile(
                          activeColor: AppColor.secondaryColor,
                          title: Text(option),
                          value: leadListController.selectedIndex.value == index,
                          onChanged: (value) => leadListController.selectCheckbox(index),
                        );
                      }).toList(),
                    )),
                  ),
              
                ],
              ),
            ),
          ),
          onSubmit: () {
            leadListController.fromWhereLeads.value="main";
            leadListController.isDashboardLeads.value=false;
            leadListController.filterSubmit();
            Navigator.pop(context); // Close dialog after submission
            // Handle submission logic
          },
        );
      },
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


  void showCallFeedbackDialog({
    /*required BuildContext context,*/
    required leadId,
    required currentLeadStage,
    required callDuration,
    required callStartTime,
    required callEndTime,
    required callStatus,
  })
  {
    showDialog(
      barrierDismissible: false,
      /*context: context,*/
      context: Get.context!,
      builder: (BuildContext context) {
        if(currentLeadStage=="6"){
          leadListController.isFBDetailsShow.value=true;
        }

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



                              final filteredStages = leadDDController.getFilteredStagesByLeadStageId(
                                currentLeadStage.toString(),
                              );


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
                                      leadListController.isFBDetailsShow.value=true;
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
  })
  {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {




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
                    SizedBox(height: 10),
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
            if (leadListController.callFeedbackController.text.isEmpty &&
                leadListController.followDateController.text.isEmpty &&
                leadListController.followTimeController.text.isEmpty
            ) {
              ToastMessage.msg(AppText.addDetailsFirst);
            } else {
              var id=0;

              leadListController.onlyFollowupSubmit(
                  leadId: leadId,
                  currentLeadStage: currentLeadStage,
                  callStatus: callStatus,
                  callDuration: callDuration,
                  callStartTime: callStartTime,
                  callEndTime: callEndTime,
                  id: id.toString(),
                  fromWhere: "follow_up",
                  selectedStage:  leadDDController.selectedStage.value.toString(),
              );
              Get.back();
            }

          },
        );
      },
    );
  }


  void showSuccessDialog({
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomBigDialogBox(
          submitButtonText: "Ok",
          titleBackgroundColor: AppColor.secondaryColor,

          title: "",
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Container(
                  height: 150,
                  width: 150,
                  child: Lottie.asset(AppImage.ok)),

              const Align(
                alignment: Alignment.center,
                child: Text(
                  AppText.forgotMsg,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.grey2,
                  ),
                ),
              ),

            ],
          ),
          onSubmit: () {
            Get.back();
          },
        );
      },
    );
  }


    String? validateSanctionAmount(String? value) {
      if (value == null || value.trim().isEmpty) {
        return AppText.sanctionAmountRequired;
      }
      return null;
    }

    String? validateSanctionDate(String? value) {
      if (value == null || value.trim().isEmpty) {
        return AppText.sanctiondateRequired;
      }
      return null;
    }

  void showUpdateDisburseHistorySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.8, // Initial height (80% of screen)
          minChildSize: 0.4,     // Minimum height
          maxChildSize: 0.95,    // Maximum height
          builder: (context, scrollController) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              ),
              child: Form(
                key: _formKey3,
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),

                      Row(
                        children: [
                          Expanded(
                            child: CustomLabeledTextField(
                              label: "Sanction Amount",
                              isRequired: false,
                              controller: leadListController.sanctionAmount2Controller,
                              hintText: "Sanction Amount",
                              isTextArea: false,
                              inputType: TextInputType.number,
                              isInputEnabled: false,
                              // validator: validateSanctionAmount,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: CustomLabeledTextField(
                              label: "Total Disburse Amt",
                              isRequired: false,
                              controller: leadListController.totalDisburseAmountController,
                              hintText: "Total Disburse Amount",
                              isTextArea: false,
                              isInputEnabled: false,
                              inputType: TextInputType.number,
                           //   validator: validateSanctionAmount,

                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      CustomLabeledTextField(
                        label: "Unique Lead No",
                        isRequired: false,
                        controller: leadListController.uniqueLeadNoController,
                        hintText: "Unique Lead No",
                        isTextArea: false,
                        inputType: TextInputType.text,
                        isInputEnabled: false,
                        validator: validateLoanApplicationNo,

                      ),
                      const SizedBox(height: 12),

                      CustomLabeledPickerTextField(
                        label: AppText.sanctionDate,
                        isRequired: true,
                        controller: leadListController.disburseDateController,
                        inputType: TextInputType.datetime,
                        hintText: AppText.mmddyyyy,
                        isDateField: true,
                        validator: validateSanctionDate,
                      ),
                      const SizedBox(height: 12),

                      CustomLabeledTextField(
                        label: "Partial / Disburse Amount",
                        isRequired: true,
                        controller: leadListController.partialAmountController,
                        hintText: "Enter Disburse Amount",
                        inputType: TextInputType.number,
                        validator: partialValidation,
                      ),
                      const SizedBox(height: 12),

                      CustomLabeledTextField(
                        label: "Transaction Details",
                        isRequired: true,
                        controller: leadListController.transactionDetailsController,
                        hintText: "Enter Transaction Details",
                        inputType: TextInputType.text,
                        validator: transuctionValidation,

                      ),
                      const SizedBox(height: 12),

                      CustomLabeledTextField2(
                        label: AppText.contactNo2,
                        isRequired: true,
                        controller: leadListController.contactNoController,
                        hintText: AppText.hintContact,
                        inputType: TextInputType.number,
                        maxLength: 10,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Contact No is required";
                          }
                          if (value.length != 10) {
                            return "Contact No must be 10 digits";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (value.length == 10) {
                            leadListController.callGetBankerDetailSanction(value);
                          }
                        },
                      ),
                      const SizedBox(height: 12),

                      CustomLabeledTextField(
                        label: "Disbursed By",
                        isRequired: true,
                        controller: leadListController.disbursedByController,
                        hintText: "Enter Disbursed By",
                        inputType: TextInputType.text,
                        validator: validateDisbursedBy,
                      ),
                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.secondaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                        if (_formKey3.currentState!.validate()) {

                          leadListController.callUpdateDisburseHistory();
                        }
                          },
                          child: leadListController.isLoad2.value
                              ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 5,
                              color: Colors.white,
                            ),
                          )
                              : const Text(
                            AppText.submit,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
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



  Widget _buildDateField(
      String label, TextEditingController controller, BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (picked != null) {
          controller.text = "${picked.month}/${picked.day}/${picked.year}";
        }
      },
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        suffixIcon: const Icon(Icons.calendar_today),
      ),
    );
  }




  String? partialValidation(String? value) {

    if (value == null || value.trim().isEmpty) {
      return AppText.partialAmountRequired;
    }
    return null; // valid
  }


  String? transuctionValidation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppText.transuctionDetailRequired;
    }
    return null;
  }

  String? validateDisbursedBy(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppText.disburedbyRequired;
    }
    return null;
  }
}

class StatusChip extends StatelessWidget {
  final String label;
  final Color color;

  StatusChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColor.greenColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(label, style: TextStyle(color: AppColor.appWhite, fontSize: 12)),
    );
  }
}
