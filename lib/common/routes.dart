
import 'package:get/get.dart';



import '../bottom_nav/bot_nav_ex.dart';
import '../call_storage/CallStorageScreen.dart';
import '../controllers/profile/theme_selection_screen.dart';
import '../enforcement_panel/enforcement_dashboard.dart';
import '../enforcement_panel/upload_common_task.dart';

import '../home/LeadListScreen.dart';
import '../home/change_password.dart';
import '../home/edit_profile.dart';
import '../home/lead_details.dart';
import '../home/leads/LeadDetailsMain.dart';
import '../home/leads/add_lead_screen.dart';
import '../home/leads/lead_list_main.dart';
import '../home/manage_branch.dart';
import '../home/notification_screen.dart';
import '../home/product.dart';
import '../home/splash.dart';
import '../registration/login.dart';
import '../registration/registration.dart';


final routes = [
  GetPage(name: '/', page: () => SplashScreen()),
  GetPage(name: '/product', page: () => ProductScreen()),
  GetPage(name: '/login', page: () => LoginScreen()),
  GetPage(name: '/bottomNavbar', page: () => BottomNavBarExample()),
  GetPage(name: '/manageBranch', page: () => ManageBranchScreen1()),
  GetPage(name: '/registration', page: () => SplashScreen()),
  GetPage(name: '/editProfile', page: () => EditProfileScreen()),
  GetPage(name: '/changePassword', page: () => ChangePasswordScreen()),
  GetPage(name: '/themeSelection', page: () => ThemeSelectionScreen()),
  GetPage(name: '/enforcementDashboard', page: () => EnforcementDashboard()),
  GetPage(name: '/uploadCommonTask', page: () => UploadCommonTask()),
  GetPage(name: '/callStorageScreen', page: () => CallStorageScreen()),
  GetPage(name: '/leadDetails', page: () => LeadDetailsScreen()),
  GetPage(name: '/leadListMain', page: () => LeadListMain()),
  GetPage(name: '/leadListMain', page: () => LeadListMain()),
  GetPage(name: '/notificationScreen', page: () =>NotificationScreen()),
  GetPage(name: '/leadDetailsMain', page: () =>LeadDetailsMain()),
  GetPage(name: '/addLeadScreen', page: () =>AddLeadScreen()),
];
