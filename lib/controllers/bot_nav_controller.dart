
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../main.dart';
import 'leads/addLeadController.dart';
import 'leads/leadlist_controller.dart';
class BotNavController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("New notification: ${message.notification?.title}");
      showLocalNotification(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("User tapped on notification: ${message.notification?.title}");
    });

  }


  void showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'high_importance_channel', // must match channel in manifest
      'High Importance Notifications',
      channelDescription: 'Used for important notifications',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000, // unique id
      message.notification?.title ?? 'No title',
      message.notification?.body ?? 'No body',
      notificationDetails,
    );
  }

  void onItemTapped(int index) {
    final LeadListController leadListController = Get.put(LeadListController());
    final Addleadcontroller addleadcontroller = Get.put(Addleadcontroller());
    if (selectedIndex.value == index) return; // Prevent unnecessary state updates

    selectedIndex.value = index;
    if (index == 1) {
      leadListController.fromWhere.value = "bottom_nav";
      leadListController.stateIdMain.value="0";
      leadListController.distIdMain.value="0";
      leadListController.cityIdMain.value="0";
      leadListController.campaignMain.value="";
    } else if (index == 2) {
      addleadcontroller.fromWhere.value = "bottom_nav";
    }
  }
}

