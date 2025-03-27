
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ksdpl/common/helper.dart';
import '../controllers/bot_nav_controller.dart';
import '../controllers/lead_dd_controller.dart';
import '../controllers/leads/leadlist_controller.dart';
import '../home/dashboard_screen.dart';
import '../home/leads/add_lead_screen.dart';
import '../home/leads/lead_list_main.dart';
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
    AddLeadScreen(),
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

               /* _buildNavItem(Icons.person, "Profile", 1),
                const SizedBox(width: 50), // Space for FAB
                _buildNavItem(Icons.settings, "Settings", 2),
                _buildNavItem(Icons.more_horiz, "More", 3),
                _buildNavItem(Icons.more_horiz, "More", 3),*/

                _buildNavItem(AppImage.homeIcon, AppImage.homeYellow,"Home", 0),
                _buildNavItem(AppImage.personIcon, AppImage.personYellow, "Leads", 1),
                const SizedBox(width: 50), // Space for FAB
                _buildNavItem(AppImage.addIcon, AppImage.addIconYellow, "Add Lead", 2),
                _buildNavItem(AppImage.homeIcon, AppImage.homeIcon, "More", 3),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor:AppColor.secondaryColor, // Yellow color
          onPressed: () {
            LeadDDController leadDDController = Get.put(LeadDDController());
            LeadListController leadListController = Get.find();
            leadDDController.selectedState.value="0";
            leadDDController.selectedDistrict.value="0";
            leadDDController.selectedCity.value="0";
            leadListController.leadCode.value="4";
            Get.toNamed("/openPollFilter");
          },
          shape: const CircleBorder(),
          // child: const Icon(Icons.add, size: 30, color: Colors.white),
          child:  Image.asset(AppImage.searchIcon, height: 20,),//addIcon
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
  Widget _buildNavItem(String unSelectedImg, String selectedImg, String label, int index) {
    return InkWell(
      onTap: () => botNavController.onItemTapped(index),
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

