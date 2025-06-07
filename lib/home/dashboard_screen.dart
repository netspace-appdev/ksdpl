import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ksdpl/common/skelton.dart';
import 'package:ksdpl/controllers/dashboard/DashboardController.dart';
import 'package:ksdpl/controllers/leads/leadlist_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../common/helper.dart';
import '../common/base_url.dart';
import '../common/circl_graph_class.dart';
import '../controllers/bot_nav_controller.dart';
import '../controllers/greeting_controller.dart';
import '../controllers/lead_dd_controller.dart';
import '../controllers/leads/infoController.dart';
import '../custom_widgets/CustomBigDialogBox.dart';
import '../custom_widgets/CustomDropdown.dart';
import '../custom_widgets/CustomLabelPickerTextField.dart';
import '../custom_widgets/CustomLabeledTextField.dart';
import '../custom_widgets/CustomLabeledTimePicker.dart';
import '../custom_widgets/line_chart.dart';
import '../services/call_service.dart';
import 'custom_drawer.dart';
import 'package:ksdpl/models/leads/GetAllLeadStageModel.dart' as stage;


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GreetingController greetingController = Get.put(GreetingController());
  DashboardController dashboardController = Get.put(DashboardController());

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  InfoController infoController = Get.put(InfoController());
  double maxGraphValue = 1000;
  BotNavController botNavController=Get.find();
  LeadDDController leadDDController=Get.find();
  LeadListController leadListController =Get.put(LeadListController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColor.backgroundColor,
      drawer:   const CustomDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          await dashboardController.refreshItems();
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            Stack(
              children: [
                // Gradient Background
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColor.primaryLight, AppColor.primaryDark],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child:Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),

                      header(),

                      const SizedBox(
                        height: 20,
                      ),

                      offerContainer(),

                    ],
                  ),
                ),

                // White Container
                Align(
                  alignment: Alignment.topCenter,  // Centers it
                  child: Container(
                    margin:  const EdgeInsets.only(
                        top: 290  // 250
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

                        todayWorkStatus(),

                        const SizedBox(
                          height: 20,
                        ),


                        reminders(),

                        const  SizedBox(
                          height: 20,//20
                        ),

                        birthday(),

                        const SizedBox(
                          height: 20,
                        ),

                        latestNews(),

                        const  SizedBox(
                          height: 20,
                        ),


                        /*  curveChart(),

                  const SizedBox(height: 30),

                  circleChart(),

                  const SizedBox(height: 30),*/

                      ],
                    ),
                  ),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }

  Widget header(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                  onTap: (){
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  child: SvgPicture.asset(AppImage.drawerIcon)),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(()=>  Text(
                    greetingController.greetingMsg.value.toString(),
                    style:  GoogleFonts.poppins(
                        fontSize: 12,

                        color: AppColor.grey3
                    ),
                  )),
                  Text(
                    infoController.firstName.value.toString(),
                    style:  GoogleFonts.roboto(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,

                        color: AppColor.grey3
                    ),
                  )
                ],
              ),
            ],
          ),


         /* Row(
            mainAxisSize: MainAxisSize.min,

            children: [

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
          )*/

          InkWell(
            onTap: (){
              showFilterDialogForLeadCount(context: context);
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

  ///old working code

/*
  Widget offerContainer() {
    return Obx(() {
      if (dashboardController.isLoading.value) {
        return Center(child: CustomSkelton.dashboardShimmerList(context));
      }

      if (dashboardController.getCountOfLeadsModel.value == null ||
          dashboardController.getCountOfLeadsModel.value!.data == null) {
        return Center(
          child: Container(
            height: 160,
            width: MediaQuery.of(context).size.width * 0.80,
            decoration: BoxDecoration(
              color: AppColor.appWhite,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const Center(
              child: Text(
                AppText.noDataFound,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.grey1,
                ),
              ),
            ),
          ),
        );
      }

      // ✅ Updated fixed stages as per latest API
      List<Map<String, dynamic>> fixedLeadStages = [

        {"id": 2, "stageName": "Fresh"},
        {"id": 3, "stageName": "Working"},
        {"id": 4, "stageName": "Interested"},
        {"id": 5, "stageName": "Not Interested"},
        {"id": 6, "stageName": "Doable"},
        {"id": 7, "stageName": "Not Doable"},
        {"id": 8, "stageName": "Logged In"},
        {"id": 9, "stageName": "Under Review"},
        {"id": 10, "stageName": "Sanction"},
        {"id": 11, "stageName": "Partial Disbursed"},
        {"id": 12, "stageName": "Fully Disbursed"},
        {"id": 13, "stageName": "Could not connect"},
      ];

      var apiLeads = dashboardController.getCountOfLeadsModel.value!.data!;
      Map<int, dynamic> apiMap = {for (var lead in apiLeads) lead.id!: lead};

      // 🎯 Build final list with fallback
      List<dynamic> fixedLeads = fixedLeadStages.map((item) {
        var match = apiMap[item['id']];
        if (match != null) {
          return match;
        } else {
          return {
            "id": item['id'],
            "stageName": item['stageName'],
            "leadCount": 0,
          };
        }
      }).toList();

      // 🔄 Chunk list in groups of 4
      List<List<dynamic>> leadChunks = [];
      for (var i = 0; i < fixedLeads.length; i += 4) {
        leadChunks.add(fixedLeads.sublist(
          i,
          (i + 4 > fixedLeads.length) ? fixedLeads.length : i + 4,
        ));
      }

      return SizedBox(
        height: 180,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: leadChunks.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var chunk = leadChunks[index];

            return Container(
              width: MediaQuery.of(context).size.width * 0.80,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: index % 2 == 0 ? AppColor.appWhite : AppColor.secondaryColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: customGrid(chunk, index),
            );
          },
        ),
      );
    });
  }

  Widget customGrid(List<dynamic> chunk, int chunkIndex) {
    return SizedBox(
      height: 145,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.9,
        ),
        itemCount: chunk.length,
        itemBuilder: (context, ind) {
          final item = chunk[ind];
          final leadCount = item is Map ? item['leadCount'] ?? 0 : item.leadCount ?? 0;
          final stageName = item is Map ? item['stageName'] ?? '' : item.stageName ?? '';
          final stageId = item is Map ? item['id'] ?? 0 : item.id ?? 0;

          return Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColor.grey4),
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    LeadListController leadListController = Get.find();
                    leadListController.selectCheckbox(stageId);
                    leadListController.filterSubmit();
                    botNavController.selectedIndex.value = 1;
                    int globalIndex = chunkIndex * 4 + ind;

                    print("globalIndex===>${globalIndex.toString()}");



                    if(globalIndex==0){
                      leadListController.selectCheckbox(1);
                      leadListController.filterSubmit();
                      botNavController.selectedIndex.value = 1;
                    }else if(globalIndex==2){
                      leadListController.selectCheckbox(4);
                      leadListController.filterSubmit();
                      botNavController.selectedIndex.value = 1;
                    }else if(globalIndex==1){
                      leadListController.selectCheckbox(2);
                      leadListController.filterSubmit();
                      botNavController.selectedIndex.value = 1;
                    }else if(globalIndex==3){
                      leadListController.selectCheckbox(5);
                      leadListController.filterSubmit();
                      botNavController.selectedIndex.value = 1;
                    }else if(globalIndex==4){
                      leadListController.selectCheckbox(6);
                      leadListController.filterSubmit();
                      botNavController.selectedIndex.value = 1;
                    }else if(globalIndex==5){
                      leadListController.selectCheckbox(7);
                      leadListController.filterSubmit();
                      botNavController.selectedIndex.value = 1;
                    }else if(globalIndex==11){
                      leadListController.selectCheckbox(3);
                      leadListController.filterSubmit();
                      botNavController.selectedIndex.value = 1;
                    }else{

                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColor.amberVersion,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(AppImage.doc, height: 20),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          leadCount.toString(),
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(width: 5),
                        Image.asset(AppImage.arrow, height: 8),
                      ],
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: 50,
                      child: Text(
                        stageName,
                        style: const TextStyle(fontSize: 8, color: AppColor.blackColor),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
*/


///new code and experiment for lead count
  Widget offerContainer() {
    return Obx(() {
      if (dashboardController.isLoading.value) {
        return Center(child: CustomSkelton.dashboardShimmerList(context));
      }

      if (dashboardController.getDetailsCountOfLeads.value == null ||
          dashboardController.getDetailsCountOfLeads.value!.data == null) {
        return Center(
          child: Container(
            height: 160,
            width: MediaQuery.of(context).size.width * 0.80,
            decoration: BoxDecoration(
              color: AppColor.appWhite,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const Center(
              child: Text(
                AppText.noDataFound,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.grey1,
                ),
              ),
            ),
          ),
        );
      }

      // ✅ Updated fixed stages as per latest API
      List<Map<String, dynamic>> fixedLeadStages = [

        {"id": 1, "stageName": "Total Assigned"},
        {"id": 2, "stageName": "Self Sourced Leads"},
        {"id": 3, "stageName": "Total Leads"},
        {"id": 4, "stageName": "Fresh Leads"},
        {"id": 5, "stageName": "Total Working"},
        {"id": 6, "stageName": "Ongoing Calls"},
        {"id": 7, "stageName": "Not Interested"},
        {"id": 8, "stageName": "Could Not Connect"},
        {"id": 9, "stageName": "Interested"},
        {"id": 10, "stageName": "Not Doable"},
        {"id": 11, "stageName": "Hold"},
        {"id": 12, "stageName": "Doable"},
        {"id": 13, "stageName": "Logged In"},
        {"id": 14, "stageName": "Sanction"},
        {"id": 15, "stageName": "Partial Disbursed"},
        {"id": 16, "stageName": "Fully Disbursed"},
      ];

      var apiLeads = dashboardController.getDetailsCountOfLeads.value!.data!;
      Map<String, dynamic> apiMap = {for (var lead in apiLeads) lead.headingName!: lead};

      // 🎯 Build final list with fallback
      List<dynamic> fixedLeads = fixedLeadStages.map((item) {
        var match = apiMap[item['stageName']];
        if (match != null) {
          return match;
        } else {
          return {
            "id": item['id'],
            "stageName": item['stageName'],
            "count": 0,
          };
        }
      }).toList();

      // 🔄 Chunk list in groups of 4
      List<List<dynamic>> leadChunks = [];
      for (var i = 0; i < fixedLeads.length; i += 4) {
        leadChunks.add(fixedLeads.sublist(
          i,
          (i + 4 > fixedLeads.length) ? fixedLeads.length : i + 4,
        ));
      }

      return SizedBox(
        height: 185,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: leadChunks.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var chunk = leadChunks[index];

            return Container(
              width: MediaQuery.of(context).size.width * 0.80,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
               // color: index % 2 == 0 ? AppColor.appWhite : AppColor.secondaryColor,
                gradient:
                index % 2 == 0 ?
                LinearGradient(
                  colors: [AppColor.appWhite, AppColor.appOffWhite],
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                ):

                LinearGradient(
                  colors: [AppColor.secondaryColorLight, AppColor.secondaryColor],
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: customGrid(chunk, index),
            );
          },
        ),
      );
    });
  }

  Widget customGrid(List<dynamic> chunk, int chunkIndex) {
    return SizedBox(
      height: 145,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.9,
        ),
        itemCount: chunk.length,
        itemBuilder: (context, ind) {
          final item = chunk[ind];
          final leadCount = item is Map ? item['count'] ?? 0 : item.count ?? 0;
          final stageName = item is Map ? item['stageName'] ?? '' : item.headingName ?? '';
         // final stageId = item is Map ? item['id'] ?? 0 : item.id ?? 0;

          return Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColor.grey4),
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    leadListController.fromWhereLeads.value="dashboard";

                    int globalIndex = chunkIndex * 4 + ind;



                    var stageId=0;
                   // LeadListController leadListController=Get.find();
                    if(globalIndex==0){
                      stageId=1;
                      leadListController.selectCheckbox(-1);
                      leadListController.leadStageName2.value ="Total Assigned";
                      botNavController.selectedIndex.value = 1;
                    } else if(globalIndex==1){
                      stageId=2;
                      leadListController.selectCheckbox(-1);
                      leadListController.leadCode.value="4";
                      leadListController.leadStageName2.value ="Self Sourced Leads";
                      botNavController.selectedIndex.value = 1;
                    } else if(globalIndex==2){
                      stageId=3;
                      leadListController.selectCheckbox(-1);
                      leadListController.leadStageName2.value ="Total Leads";
                      botNavController.selectedIndex.value = 1;
                    }else if(globalIndex==3){
                      stageId=4;
                      leadListController.selectCheckbox(1);
                      leadListController.leadStageName2.value ="Fresh Leads";
                      botNavController.selectedIndex.value = 1;
                    }else if(globalIndex==4){
                      stageId=5;
                      leadListController.selectCheckbox(-1);
                      leadListController.leadStageName2.value ="Total Working Leads";
                      botNavController.selectedIndex.value = 1;
                    }else if(globalIndex==5){
                      stageId=6;
                      leadListController.selectCheckbox(2);
                      leadListController.leadStageName2.value ="Ongoing Calls";
                      botNavController.selectedIndex.value = 1;
                    }else if(globalIndex==6){
                      stageId=7;
                      leadListController.selectCheckbox(5);
                      leadListController.leadStageName2.value ="Not Interested";
                      botNavController.selectedIndex.value = 1;
                    }else if(globalIndex==7){
                      stageId=8;
                      leadListController.selectCheckbox(3);
                      leadListController.leadStageName2.value ="Could Not Connect";
                      botNavController.selectedIndex.value = 1;
                    }else if(globalIndex==8){
                      stageId=9;
                      leadListController.selectCheckbox(4);
                      leadListController.leadStageName2.value ="Interested";
                      botNavController.selectedIndex.value = 1;

                    }else if(globalIndex==9){
                      stageId=10;
                      leadListController.selectCheckbox(7);
                      leadListController.leadStageName2.value ="Not Doable";
                      botNavController.selectedIndex.value = 1;
                    }else if(globalIndex==10){
                      stageId=11;
                      leadListController.selectCheckbox(-1);
                      leadListController.leadStageName2.value ="Hold";
                      botNavController.selectedIndex.value = 1;
                    }else if(globalIndex==11){
                      stageId=12;
                      leadListController.selectCheckbox(6);
                      leadListController.leadStageName2.value ="Doable";
                      botNavController.selectedIndex.value = 1;
                    }else if(globalIndex==12){
                      stageId=13;
                      leadListController.selectCheckbox(-1);
                      leadListController.leadStageName2.value ="Logged In";
                      botNavController.selectedIndex.value = 1;
                    }else if(globalIndex==13){
                      stageId=14;
                      leadListController.selectCheckbox(-1);
                      leadListController.leadStageName2.value ="Sanction";
                      botNavController.selectedIndex.value = 1;
                    }else if(globalIndex==14){
                      stageId=15;
                      leadListController.selectCheckbox(-1);
                      leadListController.leadStageName2.value ="Partial Disbursed";
                      botNavController.selectedIndex.value = 1;
                    }else if(globalIndex==15){
                      stageId=16;
                      leadListController.selectCheckbox(-1);
                      leadListController.leadStageName2.value ="Fully Disbursed";
                      botNavController.selectedIndex.value = 1;
                    }else{

                    }
                    leadListController.getDetailsListOfLeadsForDashboardApi(
                      applyDateFilter: "false",
                      stageId: stageId.toString(),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColor.amberVersion,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(AppImage.doc, height: 20),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          leadCount.toString(),
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(width: 5),
                        Image.asset(AppImage.arrow, height: 8),
                      ],
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: 50,
                      child: Text(
                        stageName,
                        style: const TextStyle(fontSize: 8, color: AppColor.blackColor),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }


  void showFilterDialogForLeadCount({
    required BuildContext context,
  }) {

    //working leads is now ongoing call
    List<String> options = ["Yearly Lead Counts","Monthly Lead Counts"];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomBigDialogBox(
          titleBackgroundColor: AppColor.secondaryColor,

          title: "Lead Count Filter",
          content: Column(
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
                      value: dashboardController.selectedIndex.value == index,
                      onChanged: (value) => dashboardController.selectCheckbox(index),
                    );
                  }).toList(),
                )),
              ),

            ],
          ),
          onSubmit: () {
            dashboardController.filterSubmit();
            Navigator.pop(context); // Close dialog after submission
            // Handle submission logic
          },
        );
      },
    );
  }

  Widget barChart(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Total Profile View",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 5),
        const Text(
          "1024",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),

        Stack(
          children: [
            SizedBox(
              //  color: Colors.red,
                height: 200,
                child: BarChart(_getBarChartData())), // Background Bar Chart
            Positioned(
              top: MediaQuery.of(context).size.height*0.1,
              left: 0,
              right: 0,
              child: SizedBox(
                  height: 50,
                  child: LineChart(_getLineChartData())),
            ),

            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child:Column(
                  children: [
                    const Divider(
                      color: Colors.grey,
                    ),
                    SizedBox(
                        height:  MediaQuery.of(context).size.height*0.1
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    SizedBox(
                        height:  MediaQuery.of(context).size.height*0.1
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                  ],
                )
            ),
          ],
        )
      ],
    );
  }

  Widget circleChart(){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "Performance Insights",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Background rings
                CustomPaint(
                  size: const Size(250, 250),
                  painter: CircularGraphPainter(),
                ),
                // Center image
                Image.asset(
                  AppImage.searchGlass,
                  width: 60,
                  height: 60,
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Legend
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Legend(color: AppColor.pinkColor, text: "Below: 40%"),
                Legend(color: AppColor.orangeColor, text: "60% - 80%"),
                Legend(color: AppColor.purpleColor, text: "Above: 80%"),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget curveChart(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Legend
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Legend1(color:AppColor.secondaryColor, text: "Total Units: 24"),
            Legend1(color: AppColor.tealColor, text: "Total Departments: 12"),
          ],
        ),
        const SizedBox(height: 10),
        const Legend1(color: AppColor.blackColor, text: "Total Branches: 20"),
        const SizedBox(height: 30),
        // Graph
        SizedBox(
          height: 200,
          child: LineChartWidget(),
        ),
      ],
    );
  }

  /// Bar Chart Data
  BarChartData _getBarChartData() {
    return BarChartData(

      maxY: maxGraphValue, // Set the same max value
      gridData: const FlGridData(show: false),
      titlesData: const FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      barGroups: [
        _barData(0, 600),
        _barData(1, 800),
        _barData(2, 500),
        _barData(3, 1000),
        _barData(4, 700),
        _barData(5, 300),
        _barData(6, 900),
      ],
    );
  }

  /// Individual Bar Data
  BarChartGroupData _barData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: Colors.grey.withOpacity(0.3),
          width: 20,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  /// Line Chart Data (Zigzag Yellow Line)
  LineChartData _getLineChartData() {
    return LineChartData(
      maxY: maxGraphValue,
      gridData:const FlGridData(show: false),
      titlesData: const FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        LineChartBarData(
          spots: _getLineChartSpots(),
          isCurved: false,
          color: AppColor.secondaryColor,
          barWidth: 4,
          isStrokeCapRound: true,
          belowBarData: BarAreaData(show: false),
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) =>
                FlDotCirclePainter(radius: 4, color: AppColor.appWhite, strokeWidth: 2, strokeColor: AppColor.secondaryColor),
          ),
        ),
      ],
    );
  }

  /// Data Points for Zigzag Line
  List<FlSpot> _getLineChartSpots() {
    return [
      const FlSpot(0, 500),
      const FlSpot(1, 800),
      const FlSpot(2, 500),
      const FlSpot(3, 1000),
      const  FlSpot(4, 700),
      const FlSpot(5, 300),
      const FlSpot(6, 900),
    ];
  }
  ///old Birthday
  /*Widget birthday(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Padding(
          padding:  EdgeInsets.symmetric(vertical: 10),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppText.upcomingBirthdays,
                style: GoogleFonts.merriweather(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Obx((){
          if (dashboardController.isLoading.value) {
            return  Center(child: CustomSkelton.dashboardShimmerList(context));
          }
          if (dashboardController.getUpcomingDateOfBirthModel.value == null ||
              dashboardController.getUpcomingDateOfBirthModel.value!.data == null) {
            return Center(child: Container(
              height: 160,
              width: MediaQuery.of(context).size.width*0.80,
              decoration: BoxDecoration(
                color: AppColor.appWhite,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],

              ),
              child: const Center(
                child: Text(
                  AppText.noBirhday,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.grey1,
                  ),
                ),
              ),
            )); // Handle the null case
          }
          return Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dashboardController.getUpcomingDateOfBirthModel.value!.data!.length,
              itemBuilder: (context, index) {



                var birthday = dashboardController.getUpcomingDateOfBirthModel.value!.data![index];
                List<Color> colors = [AppColor.secondaryColor, AppColor.lightGreen, AppColor.lightBrown];
                var thColor=colors[index % colors.length]; // Cycle through colors

                return Container(
                  width: 150,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: AppColor.appWhite,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: thColor, width: 1),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        height: 40,
                        width: 40,

                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: thColor,
                          border: Border.all(color: thColor),
                        ),
                        child: Center(
                          child: Text(
                            birthday.employeeName!.isNotEmpty ? birthday.employeeName![0].toUpperCase() : "U", // Initial Letter
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        birthday.employeeName.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColor.blackLight),
                      ),
                      Text(
                        Helper.birthdayFormat(birthday.dateOfBirth.toString()), // Formatted date
                        style: const TextStyle(fontSize: 14, color: AppColor.blackLight),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: thColor,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                // Add action for sending wishes
                              },
                              child: const Text(
                                "Send Wishes",
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        })
      ],
    );
  }*/

  ///new birthday
  Widget birthday() {
    return Obx(() {
      if (dashboardController.isLoading.value) {
        return Center(child: CustomSkelton.dashboardShimmerList(context));
      }

      if (dashboardController.getUpcomingDateOfBirthModel.value == null ||
          dashboardController.getUpcomingDateOfBirthModel.value!.data == null ||
          dashboardController.getUpcomingDateOfBirthModel.value!.data!.isEmpty) {
        return _noBirthdayCard();
      }

      return Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
          /*  gradient: LinearGradient(
              colors: [AppColor.primaryLight, AppColor.primaryDark],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            ),*/
            color: AppColor.appWhite,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColor.grey4, width: 1),
           /* boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],*/
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Text(
                  AppText.upcomingBirthdays,
                  style: GoogleFonts.merriweather(
                    fontSize: 15,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              /// Birthday list
              SizedBox(
                height: 175,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dashboardController.getUpcomingDateOfBirthModel.value!.data!.length,
                  itemBuilder: (context, index) {
                    var birthday = dashboardController.getUpcomingDateOfBirthModel.value!.data![index];
                    List<Color> colors = [AppColor.secondaryColor, AppColor.lightGreen, AppColor.lightBrown];
                    var thColor = colors[index % colors.length];

                    return Container(
                      width: 150,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColor.appWhite,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: thColor, width: 1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// Avatar
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: thColor,
                              border: Border.all(color: thColor),
                            ),
                            child: Center(
                              child: Text(
                                birthday.employeeName!.isNotEmpty
                                    ? birthday.employeeName![0].toUpperCase()
                                    : "U",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),

                          /// Name
                          Text(
                            birthday.employeeName.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColor.blackLight,
                            ),
                          ),

                          /// Date
                          Text(
                            Helper.birthdayFormat(birthday.dateOfBirth.toString()),
                            style: const TextStyle(fontSize: 14, color: AppColor.blackLight),
                          ),

                          /// Send wishes button
                          Container(
                            height: 40,
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 8),
                            decoration: BoxDecoration(
                              color: thColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextButton(
                              onPressed: () {
                                // Add action for sending wishes
                              },
                              child: const Text(
                                "Send Wishes",
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }



  Widget latestNews(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Obx((){
          if (dashboardController.isLoading.value) {
            return  Center(child: CustomSkelton.dashboardShimmerList(context));
          }
          if (dashboardController.getBreakingNewsModel.value == null ||
              dashboardController.getBreakingNewsModel.value!.data == null ||dashboardController.getBreakingNewsModel.value!.data!.isEmpty) {
            return _noNewsCard(); // Handle the null case
          }
          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColor.appWhite,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColor.grey4, width: 1),

              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    child: Text(
                      "Latest News",
                      style: GoogleFonts.merriweather(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dashboardController.getBreakingNewsModel.value!.data!.length,
                      itemBuilder: (context, index) {
                        var data = dashboardController.getBreakingNewsModel.value!.data![index];
                        return Container(
                          width: 200,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColor.grey4, width: 1),
                          ),
                          child:SizedBox(
                            width: 200, // Width of each news card
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child:
                                  data.imageUrl.toString()==""?
                                  Image.asset(
                                    AppImage.noImage,
                                    width: double.infinity,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ):
                                  Image.network(
                                    BaseUrl.imageBaseUrl+ data.imageUrl.toString(),
                                    width: double.infinity,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // Wrapping title and description inside Expanded/Flexible to prevent overflow
                                Expanded(
                                  child: Text(
                                    data.title.toString(),//data["title"]!,
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Expanded(
                                  child: Text(
                                    data.description.toString(),
                                    style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                // Remove,d Spacer() as it forces max height usage
                               /* Align(
                                  alignment: Alignment.bottomLeft,
                                  child: TextButton(
                                    //onPressed: () => _launchURL(data.url.toString()),
                                    onPressed: (){
                                      Get.toNamed("/newsDetailsScreen", arguments: {
                                        "newsId":data.id.toString()
                                      });
                                    },
                                    child: const Text(
                                      "Read More",
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ),*/
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                      //width: MediaQuery.of(context).size.width*0.40,

                                      decoration: BoxDecoration(
                                        //color: color,
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(5),
                                          border: Border.all(color: AppColor.grey700)
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.newspaper, color:AppColor.grey700, size: 16),
                                          SizedBox(width: 6),
                                          Text(
                                            "Read More",
                                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColor.grey700),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        })
      ],
    );
  }

  _launchURL(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }



  Widget reminders() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Obx(() {
          if (dashboardController.isLoading.value) {
            return Center(child: CustomSkelton.dashboardShimmerList(context));
          }

          if (dashboardController.getRemindersModel.value == null ||
              dashboardController.getRemindersModel.value!.data == null ||
              dashboardController.getRemindersModel.value!.data!.isEmpty) {
            return _noReminderCard();
          }

          if (dashboardController.getRemindersModel.value?.data?.isNotEmpty ?? false) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              dashboardController.scrollToLatestItem();
            });
          }

          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(

                gradient: LinearGradient(
                  colors: [AppColor.primaryLight, AppColor.primaryDark],
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppText.upcomingFollowUp,
                          style: GoogleFonts.merriweather(
                            fontSize: 15,
                            color: AppColor.appWhite,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed("/getAllReminder");
                          },
                          child: Text(
                            "View All",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColor.appWhite,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dashboardController.getRemindersModel.value!.data!.length > 5
                          ? 5
                          : dashboardController.getRemindersModel.value!.data!.length,
                      itemBuilder: (context, index) {
                        var data = dashboardController.getRemindersModel.value!.data![index];
                        return Container(
                          width: 250,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColor.grey200),
                            color: AppColor.appWhite,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(

                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /// Top Row: Avatar + Name & Number
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      leadListController.isFBDetailsShow.value = false;
                                      leadListController.followDateController.text = "";
                                      leadListController.followTimeController.text = "";
                                      leadDDController.selectedStage.value = data.leadStageStatus.toString();
                                      leadListController.leadCode.value =
                                          leadDDController.selectedStage.value ?? "0";

                                      CallService callService = CallService();
                                      callService.makePhoneCall(
                                        phoneNumber: data.leadMobileNo.toString(),
                                        leadId: data.leadId.toString(),
                                        currentLeadStage: data.leadStageStatus.toString(),
                                        context: context,
                                        showFeedbackDialog: showCallFeedbackDialog,
                                      );
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: AppColor.secondaryColor,
                                      radius: 24,
                                     /* child: Text(
                                        data.leadCustomerName!.isNotEmpty
                                            ? data.leadCustomerName![0].toUpperCase()
                                            : "U",
                                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                      ),*/
                                      child: Icon(Icons.phone, color: AppColor.appWhite,),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          Helper.capitalizeEachWord(data.leadCustomerName!),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight:FontWeight.w900,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                           
                                            Flexible(
                                              child: Text(
                                                data.leadMobileNo ?? '',
                                                style: TextStyle(
                                                  color: AppColor.grey700,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 10,),



                              /// Follow-up date
                              _buildDetailRow2(
                                "Followup on",
                                Helper.convertDateTime(data.callReminder.toString()),
                              ),

                            /*  SizedBox(height: 10,),

                              /// Call Now button
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.secondaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                ),
                                icon: const Icon(Icons.phone,color: AppColor.appWhite),
                                label:  Text(
                                  "Call Now",
                                  style: TextStyle(fontSize: 14, color: AppColor.appWhite),
                                ),
                                onPressed: () {
                                  leadListController.isFBDetailsShow.value = false;
                                  leadListController.followDateController.text = "";
                                  leadListController.followTimeController.text = "";
                                  leadDDController.selectedStage.value = data.leadStageStatus.toString();
                                  leadListController.leadCode.value =
                                      leadDDController.selectedStage.value ?? "0";

                                  CallService callService = CallService();
                                  callService.makePhoneCall(
                                    phoneNumber: data.leadMobileNo.toString(),
                                    leadId: data.leadId.toString(),
                                    currentLeadStage: data.leadStageStatus.toString(),
                                    context: context,
                                    showFeedbackDialog: showCallFeedbackDialog,
                                  );
                                },
                              ),*/
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildDetailRow2(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(left:8.0),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Icon(Icons.watch_later_outlined, color: AppColor.grey1,),
            const SizedBox(width: 6),
            Text(
              "$value",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Row(
      children: [
        const Icon(Icons.calendar_today, size: 14),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            "$title: $value",
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _noReminderCard() {
    return Center(
      child: Container(
        height: 160,
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
          color: AppColor.appWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColor.grey4, width: 1),
        ),
        child:  Center(
        /*  child: Text(
            AppText.noDataFound,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColor.grey1,
            ),
          ),*/
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                    height: 110,
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Lottie.asset(AppImage.nodataCofee,
                        repeat: false
                    )),
              ),
              Text(
                  "No Reminders",
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

  Widget _noBirthdayCard() {
    return Center(
      child: Container(
        height: 160,
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
          color: AppColor.appWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColor.grey4, width: 1),
        ),
        child:  Center(

          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                    height: 110,
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Lottie.asset(AppImage.noBirthday,     repeat: false)),
              ),
              Text(
                  "No Birthdays",
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

  Widget _noNewsCard() {
    return Center(
      child: Container(
        height: 160,
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
          color: AppColor.appWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColor.grey4, width: 1),
        ),
        child:  Center(

          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                    height: 110,
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Lottie.asset(AppImage.noNews,repeat: false)),
              ),
              SizedBox(height: 5,),
              Text(
                  "No News",
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


  Widget todayWorkStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Obx(() {
          if (dashboardController.isLoading.value) {
            return Center(child: CustomSkelton.dashboardShimmerList(context));
          }

          var model = dashboardController.todayWorkStatusRBModel.value;
          var data = model?.data?.isNotEmpty == true ? model!.data![0] : null;

          if (data == null) {
            return _noDataCard();
          }

          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColor.secondaryColorLight, AppColor.secondaryColor],
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                    child: Text(
                      "Today's Work Status",

                      style: GoogleFonts.merriweather(
                        fontSize: 15,
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _statusMiniCard(
                    icon: Icons.phone_android,
                    label: AppText.todaycall,
                    value: data.todayCall.toString(),
                    color: AppColor.primaryColor,
                  ),
                  const SizedBox(height: 12),
                  _statusMiniCard(
                    icon: Icons.thumb_up,
                    label: AppText.convertedToInterested,
                    value: data.todayConvertToInterested.toString(),
                    color: AppColor.lightGreen,
                  ),
                  const SizedBox(height: 12),
                  _statusMiniCard(
                    icon: Icons.call,
                    label:AppText.connectedCalls,
                    value: data.todayConnectedCall.toString(),
                    color: Colors.lightBlue,
                  ),
                  const SizedBox(height: 12),
                  _statusMiniCard(
                    icon: Icons.watch_later_outlined,
                    label: AppText.todaycallDuration,
                    value: data.todayCallDuration.toString(),
                    color: Colors.redAccent,
                  ),
                  const SizedBox(height: 12),
                  _statusMiniCard(
                    icon: Icons.show_chart,
                    label: AppText.ongoingCallYTD,
                    value: data.leadsCalledInYear.toString(),
                    color: Colors.deepPurpleAccent,
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  /// Mini-card for each row inside the big card
  Widget _statusMiniCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.appWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 28, color: color),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                //fontWeight: FontWeight.w500,
                color: AppColor.blackColor,
              ),
            ),
          ),
          Text(
            value,// value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _noDataCard() {
    return Center(
      child: Container(
        height: 160,
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
          color: AppColor.appWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColor.grey4, width: 1),

        ),
        child:  Center(

          child: Column(
            children: [
              Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Lottie.asset(
                      AppImage.noDataGirl,
                    repeat: false
                  )),
              Text(
                "No work status",
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
                            int leadCode = int.parse(leadListController.leadCode.value); // Assuming this is reactive or available

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

}
