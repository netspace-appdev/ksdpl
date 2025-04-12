
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';

import 'common/notification_helper.dart';
import 'common/routes.dart';
import 'controllers/profile/them_controller.dart';

///reminder
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
///rm end

/*Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}*/
/*Future<void> requestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else {
    print('User declined or has not accepted permission');
  }
}*/

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//  requestPermission();
  await GetStorage.init();

  await Permission.microphone.request();
  await Permission.phone.request();
  await Permission.storage.request();

  Get.put(ThemeController());
  ///reminder
  /*tz.initializeTimeZones();

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);*/
  await NotificationHelper.init();
  ///rm end
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    return Obx(()=>GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KSDPL',
      theme: ThemeData.light(
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,

      ),

      darkTheme: ThemeData.dark(),
      themeMode: themeController.themeMode.value,
      getPages: routes,
      initialRoute:"/",
    ));
  }
}



