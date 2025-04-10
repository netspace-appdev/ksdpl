

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ksdpl/common/skelton.dart';
import 'package:ksdpl/controllers/dashboard/DashboardController.dart';
import 'package:ksdpl/controllers/leads/leadlist_controller.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../common/helper.dart';

import '../common/base_url.dart';
import '../common/circl_graph_class.dart';

import '../controllers/bot_nav_controller.dart';
import '../controllers/greeting_controller.dart';
import '../controllers/leads/infoController.dart';

import '../custom_widgets/CustomBigDialogBox.dart';
import '../custom_widgets/CustomLabelPickerTextField.dart';
import '../custom_widgets/CustomLabeledTextField.dart';
import '../custom_widgets/CustomLabeledTimePicker.dart';
import '../custom_widgets/line_chart.dart';
import '../services/call_service.dart';
import 'custom_drawer.dart';



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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //print("New notification: ${message.notification?.title}");
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      //print("User tapped on notification: ${message.notification?.title}");
    });
*/

  }
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
                        top: 280  // 250
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

                        //customGrid(),

                        birthday(),

                        const SizedBox(
                          height: 20,
                        ),

                        latestNews(),

                        const  SizedBox(
                          height: 20,
                        ),

                        reminders(),

                        const  SizedBox(
                          height: 50,//20
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
                    style: const TextStyle(
                        fontSize: 12,

                        color: AppColor.grey3
                    ),
                  )),
                  Text(
                    infoController.firstName.value.toString(),
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,

                        color: AppColor.grey3
                    ),
                  )
                ],
              ),
            ],
          ),


          Row(
            mainAxisSize: MainAxisSize.min,

            children: [


              /*  InkWell(
                onTap:(){
                  Get.toNamed("/notificationScreen");
                },
                child: Image.asset(
                  AppImage.bellIcon, // Replace with your image path
                  height: 22,
                ),
              ),*/
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
          )
        ],
      ),
    );
  }

  /*Widget offerContainer(){
    return  SizedBox(

      height: 150,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 2,
          //physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context,index){
            return Container(
              width: MediaQuery.of(context).size.width*0.80,
              padding: const EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(horizontal: 5),

              decoration: BoxDecoration(
                color: index==0?AppColor.appWhite:AppColor.secondaryColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
                *//* image: DecorationImage(
                            image: AssetImage(AppImage.offerImage), // Use your image path
                            fit: BoxFit.cover, // Cover the entire container
                            opacity: 0.2, // Adjust transparency if needed
                          ),*//*

              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left Section (Icon + Text)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Icon
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: index==0?AppColor.amberVersion:AppColor.appWhite, // Light yellow background
                              borderRadius: BorderRadius.circular(12),
                            ),
                            // child: const Icon(Icons.groups, color:  AppColor.secondaryColor, size: 30),
                            child: index==0? Image.asset(AppImage.peopleGroup,height: 23,):Image.asset(AppImage.faq,height: 23,),
                          ),
                          SizedBox(width: 10),

                          // Main Number
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "2256",
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                              ),

                              // Subtitle
                              const Text(
                                "Total Learners",
                                style: TextStyle(fontSize: 14, color: AppColor.black1),
                              ),
                            ],
                          )
                        ],
                      ),

                      const SizedBox(height: 15),

                      // Second Number
                      const Text(
                        "300",
                        style: TextStyle(fontSize: 18, fontWeight:  FontWeight.w900),
                      ),

                      // Updated Time
                      const Text(
                        "Updated hour ago",
                        style: TextStyle(fontSize: 12, color:  AppColor.black1),
                      ),
                    ],
                  ),

                  // Right Section (Chart)
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(show: false),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: [
                              const FlSpot(0, 1),
                              const FlSpot(1, 1.5),
                              const FlSpot(2, 1.2),
                              const FlSpot(3, 1.8),
                              const FlSpot(4, 1.6),
                            ],
                            isCurved: true,
                            color: Colors.red,
                            barWidth: 3,
                            isStrokeCapRound: true,
                            dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(show: false),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );

          }
      ),
    );
  }*/

  Widget offerContainer(){
    return  Obx((){

      if (dashboardController.isLoading.value) {
        return  Center(child: CustomSkelton.dashboardShimmerList(context));
      }
      if (dashboardController.getCountOfLeadsModel.value == null ||
          dashboardController.getCountOfLeadsModel.value!.data == null) {
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
              AppText.noDataFound,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColor.grey1,
              ),
            ),
          ),
        )); // Handle the null case
      }
      var allLeads = dashboardController.getCountOfLeadsModel.value!.data!;

      // Filter out the "Fresh" lead
      var filteredLeads = allLeads.where((lead) => lead.id != 1).toList();

      // Group the leads into chunks of 4
      List<List<dynamic>> leadChunks = [];
      for (var i = 0; i < filteredLeads.length; i += 4) {
        leadChunks.add(filteredLeads.sublist(i, (i + 4 > filteredLeads.length) ? filteredLeads.length : i + 4));
      }
      return SizedBox(

        height: 180,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: leadChunks.length,
            shrinkWrap: true,
            itemBuilder: (context,index){
              var chunk = leadChunks[index];


              return Container(
                width: MediaQuery.of(context).size.width*0.80,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(horizontal: 5),

                decoration: BoxDecoration(
                  color: index%2==0?AppColor.appWhite:AppColor.secondaryColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                  /* image: DecorationImage(
                            image: AssetImage(AppImage.offerImage), // Use your image path
                            fit: BoxFit.cover, // Cover the entire container
                            opacity: 0.2, // Adjust transparency if needed
                          ),*/

                ),
                child: customGrid(chunk,index),
              );

            }
        ),
      );
    });
  }


  Widget customGrid( List<dynamic> chunk, int chunkIndex){
    return  SizedBox(

      height: 145,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns
          crossAxisSpacing: 10, // Space between columns
          mainAxisSpacing: 10, // Space between rows
          childAspectRatio: 1.9, // Adjust height

        ),
        itemCount: chunk.length,
        itemBuilder: (context, ind) {

          return Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColor.grey4),
              /* boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 3,
                                  spreadRadius: 2,
                                ),
                              ],*/
            ),
            child: Row(

              children: [
                InkWell(
                  onTap: (){
                    int globalIndex = chunkIndex * 4 + ind;


                    LeadListController leadListController=Get.find();
                    if(globalIndex==0){
                      leadListController.selectCheckbox(1);
                      leadListController.filterSubmit();
                      botNavController.selectedIndex.value = 1;
                    }else if(globalIndex==2){
                      leadListController.selectCheckbox(3);
                      leadListController.filterSubmit();
                      botNavController.selectedIndex.value = 1;
                    }else if(globalIndex==3){
                      leadListController.selectCheckbox(4);
                      leadListController.filterSubmit();
                      botNavController.selectedIndex.value = 1;
                    }else if(globalIndex==4){
                      leadListController.selectCheckbox(5);
                      leadListController.filterSubmit();
                      botNavController.selectedIndex.value = 1;
                    }else if(globalIndex==5){
                      leadListController.selectCheckbox(6);
                      leadListController.filterSubmit();
                      botNavController.selectedIndex.value = 1;
                    }else if(globalIndex==11){
                      leadListController.selectCheckbox(2);
                      leadListController.filterSubmit();
                      botNavController.selectedIndex.value = 1;
                    }else{

                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColor.amberVersion, // Light yellow background
                      borderRadius: BorderRadius.circular(12),
                    ),
                    // child: const Icon(Icons.groups, color:  AppColor.secondaryColor, size: 30),
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
                          chunk[ind].leadCount.toString(),
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(width: 5),
                        Image.asset(AppImage.arrow, height: 8),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: 40,
                      child: Text(
                        chunk[ind].stageName.toString(),
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

  Widget birthday(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding:  EdgeInsets.symmetric(vertical: 10),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppText.upcomingBirthdays,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
  }

  Widget latestNews(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding:  EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Text(
            "Latest News",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        Obx((){
          if (dashboardController.isLoading.value) {
            return  Center(child: CustomSkelton.dashboardShimmerList(context));
          }
          if (dashboardController.getBreakingNewsModel.value == null ||
              dashboardController.getBreakingNewsModel.value!.data == null ||dashboardController.getBreakingNewsModel.value!.data!.isEmpty) {
            return Center(child: Container(
              height: 160,
              width: MediaQuery.of(context).size.width*0.80,
              decoration: BoxDecoration(
                color: AppColor.appWhite,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColor.grey4, width: 1),

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
            )); // Handle the null case
          }
          return SizedBox(
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
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: TextButton(
                            onPressed: () => _launchURL(data.url.toString()),
                            child: const Text(
                              "Read More",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
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

  Widget reminders(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppText.upcomingFollowUp,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: (){
                  Get.toNamed("/getAllReminder");
                },
                child: Text(
                  "View All",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColor.secondaryColor),
                ),
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
          if (dashboardController.getRemindersModel.value == null ||
              dashboardController.getRemindersModel.value!.data == null ||dashboardController.getRemindersModel.value!.data!.isEmpty) {
            return Center(child: Container(
              height: 160,
              width: MediaQuery.of(context).size.width*0.80,
              decoration: BoxDecoration(
                color: AppColor.appWhite,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColor.grey4, width: 1),

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
            )); // Handle the null case
          }
          if (dashboardController.getRemindersModel.value?.data?.isNotEmpty ?? false) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              dashboardController.scrollToLatestItem();
            });
          }

          return SizedBox(
            height: 230,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dashboardController.getRemindersModel.value!.data!.length > 5
                  ? 5
                  : dashboardController.getRemindersModel.value!.data!.length,
              //reverse: true,


              itemBuilder: (context, index) {
                var data = dashboardController.getRemindersModel.value!.data![index];
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
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
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.center,

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
                                      data.leadCustomerName!.isNotEmpty ? data.leadCustomerName![0].toUpperCase() : "U", // Initial Letter
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,

                                  children: [
                                    Text(
                                      Helper.capitalizeEachWord(data.leadCustomerName!.toString()),

                                      // lead.name.toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
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
                                          data.leadMobileNo.toString(),
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

                          ],
                        ),
                      ),
                      SizedBox(height: 10),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            _buildDetailRow("Next Followup Date", Helper.convertDateTime(data.callReminder.toString())),
                          ],
                        ),
                      ),
                      //SizedBox(height: 10),

                      Align(
                        alignment: Alignment.bottomCenter,
                        child: TextButton(
                          onPressed: () {

                            CallService callService = CallService();
                            callService.makePhoneCall(
                              phoneNumber: data.leadMobileNo.toString(),//"+919399299880"
                              leadId:  data.leadId.toString(),
                              currentLeadStage:  data.leadStageStatus.toString(),
                              context: context,
                              showFeedbackDialog:showCallFeedbackDialog,
                            );
                          },
                          child: const Text(
                            "Call Now",
                            style: TextStyle(color: AppColor.secondaryColor, fontSize: 14),
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
  }

/*  Widget _buildDetailRow(String label, String value) {

    return Container(

      height: 40,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Column(
          children: [
            Text(
              "$label",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColor.primaryLight,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                value,

                style: TextStyle(color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }*/
  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: AppColor.primaryLight,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }


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
        LeadListController leadListController =Get.find();
        return CustomBigDialogBox(
          titleBackgroundColor: AppColor.secondaryColor,
          title: AppText.addFAndF,
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
                    SizedBox(height: 10),
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
                  ],
                ),
              ),
            ),
          ),
          onSubmit: () {
            if (leadListController.callFeedbackController.text.isEmpty &&
                leadListController.leadFeedbackController.text.isEmpty) {
              ToastMessage.msg(AppText.addFeedbackFirst);
            } else {
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
                  fromWhere: "call"

              );
              Get.back();
            }

          },
        );
      },
    );
  }
}
