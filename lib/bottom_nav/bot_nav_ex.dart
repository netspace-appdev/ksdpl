
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ksdpl/common/helper.dart';
import 'package:ksdpl/models/drawer/GetLeadDetailModel.dart';
import '../common/storage_service.dart';
import '../controllers/bot_nav_controller.dart';
import '../controllers/lead_dd_controller.dart';
import '../controllers/leads/addLeadController.dart';
import '../controllers/leads/leadlist_controller.dart';
import '../controllers/leads/seachLeadController.dart';
import '../controllers/open_poll_filter_controller.dart';
import '../home/dashboard_screen.dart';
import '../home/leads/add_lead_screen.dart';
import '../home/leads/lead_list_main.dart';
import '../home/leads/open_poll_filter.dart';
import '../home/more_screen.dart';

class BottomNavBarExample extends StatefulWidget {
  @override
  _BottomNavBarExampleState createState() => _BottomNavBarExampleState();
}

class _BottomNavBarExampleState extends State<BottomNavBarExample> {
  BotNavController botNavController = Get.put(BotNavController());


  final List<Widget> _pages = [
    DashboardScreen(),
    LeadListMain(),
    OpenPollFilter(),
    MoreSettingScreen()
  ];


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() => _pages[botNavController.selectedIndex.value]),
        bottomNavigationBar: BottomAppBar(

          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          color: const Color(0xFF2E3A66), // Background color
          child: Container( //ClipPath
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                _buildNavItem(AppImage.homeIcon, AppImage.homeYellow,"Home", 0),
                _buildNavItem(AppImage.lead_white, AppImage.lead_yellow, "Leads", 1),
                const SizedBox(width: 50), // Space for FAB
                _buildNavItem(AppImage.poll_white, AppImage.poll_yellow, "LEH", 2),//Open Poll
                _buildNavItem(AppImage.homeIcon, AppImage.homeIcon, "More", 3),
              ],
            ),
          ),
        ),

        floatingActionButton: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [AppColor.secondaryColorLight, AppColor.secondaryColor],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: FloatingActionButton(
            backgroundColor: Colors.transparent, // Make FAB background transparent
            elevation: 0, // Remove default shadow
            onPressed: () {
              LeadDDController leadDDController = Get.find();
              leadDDController.selectedStage.value = "0";
              leadDDController.selectedState.value = "0";
              leadDDController.selectedState.value = null;
              leadDDController.selectedDistrict.value = null;
              leadDDController.selectedCity.value = null;
              LeadListController leadListController = Get.find();
              SearchLeadController searchLeadController=Get.put(SearchLeadController());
              searchLeadController.clearSearchFilter();
              leadListController.filteredGetAllLeadsModel.value=null;

              var managerId=StorageService.get(StorageService.EMPLOYEE_ID);
              var channelId=StorageService.get(StorageService.CHANNEL_ID);
              searchLeadController.getGetJuniorListApi(channelId: channelId,managerId: managerId);

              Get.toNamed("/leadSearchScreen");
            },
            shape: const CircleBorder(),
            child: Image.asset(AppImage.searchIcon, height: 20),
          ),
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
  Widget _buildNavItem(String unSelectedImg, String selectedImg, String label, int index) {
    return InkWell(
      onTap: (){
        if (index == 1) {  // AddLeadScreen index
          LeadListController leadListController = Get.find();
          leadListController.isDashboardLeads.value=false;
        }
        if (index == 2) {  // AddLeadScreen index

          Get.arguments?["leadId"]=0;
          Addleadcontroller addleadcontroller=Get.put(Addleadcontroller());
          addleadcontroller.clearControllers();

          print('is open poll index${index}');

          OpenPollFilterController openPollFilterController = Get.put(OpenPollFilterController());

          openPollFilterController.getCommonLeadListByFilterApi(
            stateId: "0",
            distId: "0",
            cityId:  "0",
            KsdplBranchId: "0",
          );

        }
        botNavController.onItemTapped(index);
      },
      child: Obx(() {
        bool isSelected = botNavController.selectedIndex.value == index;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              label == "More"
                  ? Icon(Icons.more_horiz, size: 24, color: isSelected ? AppColor.secondaryColor : AppColor.appWhite)
                  : Image.asset(isSelected ? selectedImg : unSelectedImg, height: 24),  // Image now updates properly
              const SizedBox(height: 5),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? AppColor.secondaryColor : Colors.white,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

