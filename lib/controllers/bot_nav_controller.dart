
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'leads/addLeadController.dart';
import 'leads/leadlist_controller.dart';
class BotNavController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }


  void onItemTapped(int index) {
    final LeadListController leadListController = Get.put(LeadListController());
    final Addleadcontroller addleadcontroller = Get.put(Addleadcontroller());
    if (selectedIndex.value == index) return; // Prevent unnecessary state updates

    selectedIndex.value = index;
    print("Navigating to index: $index");

    if (index == 1) {
      leadListController.fromWhere.value = "bottom_nav";
      leadListController.stateIdMain.value="0";
      leadListController.distIdMain.value="0";
      leadListController.cityIdMain.value="0";
    } else if (index == 2) {
      addleadcontroller.fromWhere.value = "bottom_nav";
    }
  }
}

