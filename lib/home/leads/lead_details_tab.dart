/*
import 'package:flutter/material.dart';

import 'LeadDetailsMain.dart';
class LeadDetailsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text("Lead Details"),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.home), text: "Details"),
              Tab(icon: Icon(Icons.person), text: "History"),
              Tab(icon: Icon(Icons.settings), text: "followup details"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            LeadDetailsMain(),
            Center(child: Text("Profile Screen", style: TextStyle(fontSize: 20))),
            Center(child: Text("Settings Screen", style: TextStyle(fontSize: 20))),
          ],
        ),
      ),
    );
  }
}*/

import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';


import '../../common/CustomSearchBar.dart';
import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../controllers/greeting_controller.dart';
import '../../controllers/leads/infoController.dart';
import '../../controllers/leads/leadDetailsController.dart';
import '../../controllers/leads/lead_history_controller.dart';
import '../../controllers/leads/leadlist_controller.dart';

import '../../custom_widgets/CustomTextFieldPrefix.dart';
import 'LeadDetailsMain.dart';
import 'lead_history.dart';

class LeadDetailsTab extends StatelessWidget {
/*  GreetingController greetingController = Get.find();
  InfoController infoController = Get.find();*/
  GreetingController greetingController = Get.put(GreetingController());
  InfoController infoController = Get.put(InfoController());

  LeadListController leadListController = Get.put(LeadListController());
  //LeadDetailController leadDetailController = Get.put(LeadDetailController());
  final TextEditingController _searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

/*  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(

          backgroundColor: AppColor.backgroundColor,
         ///new code

          body: Column(
            children: [
              Stack(
                children: [
                  // Gradient Background
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
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

                        header(context),

                      ],
                    ),
                  ),

                  // White Container
                  Align(
                    alignment: Alignment.topCenter,  // Centers it
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Container(
                        margin:  EdgeInsets.only(
                            top:90 // MediaQuery.of(context).size.height * 0.22
                        ), // <-- Moves it 30px from top
                        width: double.infinity,
                       // height: MediaQuery.of(context).size.height*0.99,
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
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

                             TabBar(
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicatorColor: AppColor.secondaryColor, // Yellow Indicator
                              labelColor: AppColor.secondaryColor, // Yellow when selected
                              unselectedLabelColor: AppColor.grey700, // Grey when unselected
                              onTap: (val){
                                if(val==1){
                                  LeadHistoryController leadHistoryController=Get.put(LeadHistoryController());
                                  dynamic arg= Get.arguments;
                                  var leadId=arg["leadId"];
                                  leadHistoryController.getLeadWorkByLeadIdApi(leadId:leadId );
                                }
                              },
                              tabs: const [
                                CustomTab(icon: Icons.list_alt, text: "Details"),
                                CustomTab(icon: Icons.history, text: "History"),
                                //CustomTab(icon: Icons.content_paste_search_outlined, text: "Followup"),
                              ],
                            ),


                            Expanded(
                            // height: MediaQuery.of(context).size.height,
                             child: TabBarView(
                                children: [
                                  LeadDetailsMain(),
                                  LeadHistory(),

                                ],
                              ),
                             )


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
  }*/

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.backgroundColor,
          body: Builder(
            builder: (context) {
              final TabController tabController = DefaultTabController.of(context);

              // Attach listener once
              tabController.addListener(() {
                if (!tabController.indexIsChanging && tabController.index == 1) {
                  final LeadHistoryController leadHistoryController =
                  Get.put(LeadHistoryController());
                  final arg = Get.arguments;
                  final leadId = arg["leadId"];
                  leadHistoryController.getLeadWorkByLeadIdApi(leadId: leadId);
                }
              });

              return SingleChildScrollView(
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
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              header(context),
                            ],
                          ),
                        ),
                
                        // White Container
                        Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: Container(
                              margin: const EdgeInsets.only(top: 90),
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 0),
                              decoration: const BoxDecoration(
                                color: AppColor.backgroundColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(45),
                                  topRight: Radius.circular(45),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 10),
                
                                  // Tabs
                                  const TabBar(
                                    indicatorSize: TabBarIndicatorSize.tab,
                                    indicatorColor: AppColor.secondaryColor,
                                    labelColor: AppColor.secondaryColor,
                                    unselectedLabelColor: AppColor.grey700,
                                    tabs: [
                                      CustomTab(
                                          icon: Icons.list_alt, text: "Details"),
                                      CustomTab(
                                          icon: Icons.history, text: "History"),
                                    ],
                                  ),
                
                                  // Tab Views
                                  Expanded(
                                    child: TabBarView(
                                      children: [
                                        LeadDetailsMain(),
                                        LeadHistory(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AppImage.arrowLeft,height: 24,),
              )),
          Text(
            AppText.leadDetails,
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


}


//details

class CustomTab extends StatelessWidget {
  final IconData icon;
  final String text;

  const CustomTab({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      icon: Icon(icon),
      text: text,

    );
  }
}