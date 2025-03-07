import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ksdpl/common/skelton.dart';
import 'package:ksdpl/controllers/dashboard/DashboardController.dart';

import 'package:ksdpl/services/home_service.dart';
import 'package:shimmer/shimmer.dart';

import '../../common/carousel_slider.dart';
import '../../common/helper.dart';
import '../../common/search_bar.dart';

import '../../controllers/api_controller.dart';
import '../common/circl_graph_class.dart';
import '../custom_widgets/line_chart.dart';
import 'custom_drawer.dart';





class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Map<String, String>> items = [
    {
      "image": AppImage.doc,
      "title": "1120",
      "subtitle": "New Leads"
    },
    {
      "image": AppImage.doc,
      "title": "1120",
      "subtitle": "Qualified Leads"
    },
    {
      "image": AppImage.doc,
      "title": "1120",
      "subtitle": "Follow-ups Made"
    },
    {
      "image": AppImage.doc,
      "title": "1120",
      "subtitle": "Closed Deals"
    },
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double maxGraphValue = 1000;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColor.backgroundColor,
      drawer:   CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
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
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child:Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),

                      header(),

                      SizedBox(
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
                    margin:  EdgeInsets.only(
                        top:  MediaQuery.of(context).size.height * 0.35
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

                        customGrid(),

                        const SizedBox(height: 20),

                        curveChart(),

                        const SizedBox(height: 30),

                        circleChart(),

                        const SizedBox(height: 30),

                        barChart(),

                        const SizedBox(height: 30),


                      ],
                    ),
                  ),
                ),
              ],
            ),
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
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Good Evening!",
                    style: TextStyle(
                        fontSize: 12,

                        color: AppColor.grey3
                    ),
                  ),
                  const Text(
                    "Falak John",
                    style: TextStyle(
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
              Image.asset(
                AppImage.searchIcon, // Replace with your image path
                height: 55,
              ),


              Image.asset(
                AppImage.bellIcon, // Replace with your image path
                height: 55,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget offerContainer(){
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
                /* image: DecorationImage(
                            image: AssetImage(AppImage.offerImage), // Use your image path
                            fit: BoxFit.cover, // Cover the entire container
                            opacity: 0.2, // Adjust transparency if needed
                          ),*/

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
                            child: index==0? Image.asset(AppImage.peopleIcon,height: 23,):Image.asset(AppImage.faq,height: 23,),
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
  }

  Widget customGrid(){
    return  SizedBox(

      height: 145,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns
          crossAxisSpacing: 10, // Space between columns
          mainAxisSpacing: 10, // Space between rows
          childAspectRatio: 2.4, // Adjust height

        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(8),
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
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColor.amberVersion, // Light yellow background
                    borderRadius: BorderRadius.circular(12),
                  ),
                  // child: const Icon(Icons.groups, color:  AppColor.secondaryColor, size: 30),
                  child: Image.asset(items[index]["image"]!, height: 23),
                ),

                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          items[index]["title"]!,
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
                        ),
                        SizedBox(width: 5),
                        Image.asset(AppImage.arrow, height: 12),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      items[index]["subtitle"]!,
                      style: TextStyle(fontSize: 10, color: AppColor.black1),
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
        Text(
          "Total Profile View",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 5),
        Text(
          "1024",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),

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
                    Divider(
                      color: Colors.grey,
                    ),
                    SizedBox(
                        height:  MediaQuery.of(context).size.height*0.1
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    SizedBox(
                        height:  MediaQuery.of(context).size.height*0.1
                    ),
                    Divider(
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

        Text(
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
                  size: Size(250, 250),
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
            Row(
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
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Legend1(color:AppColor.pinkColor, text: "Total Units: 24"),
            Legend1(color: AppColor.tealColor, text: "Total Departments: 12"),
          ],
        ),
        const SizedBox(height: 10),
        Legend1(color: AppColor.blackColor, text: "Total Branches: 20"),
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
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(show: false),
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
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(show: false),
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
      FlSpot(0, 500),
      FlSpot(1, 800),
      FlSpot(2, 500),
      FlSpot(3, 1000),
      FlSpot(4, 700),
      FlSpot(5, 300),
      FlSpot(6, 900),
    ];
  }
}
