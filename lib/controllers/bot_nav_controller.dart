
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
    getFCMToken();
    getDeviceId();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("New notification: ${message.notification?.title}");
      showLocalNotification(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("User tapped on notification: ${message.notification?.title}");
    });

  }
  void getFCMToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print('🔑 FCM Token: $token');

    // You can send this token to your backend API
  }
  Future<void> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceId = 'unknown';

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id ?? 'no-id';
      print('📱deviceId: $deviceId');
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor ?? 'no-id';
    }

    print('📱 Device ID: $deviceId');
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
    final LeadListController leadListController = Get.put(LeadListController(),tag: 'list');
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

