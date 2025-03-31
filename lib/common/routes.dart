
import 'package:get/get.dart';



import '../bottom_nav/bot_nav_ex.dart';
import '../call_storage/CallStorageScreen.dart';
import '../controllers/profile/theme_selection_screen.dart';
import '../enforcement_panel/enforcement_dashboard.dart';
import '../enforcement_panel/upload_common_task.dart';

import '../exp.dart';
import '../home/LeadListScreen.dart';
import '../home/change_password.dart';
import '../home/dashboard_screen.dart';
import '../home/edit_profile.dart';
import '../home/leads/GetAllReminderScreen.dart';
import '../home/leads/lead_details.dart';
import '../home/leads/LeadDetailsMain.dart';
import '../home/leads/add_lead_screen.dart';
import '../home/leads/lead_details_tab.dart';
import '../home/leads/lead_follow_up_screen.dart';
import '../home/leads/lead_history.dart';
import '../home/leads/lead_list_main.dart';
import '../home/leads/loan_application_screen.dart';
import '../home/manage_branch.dart';
import '../home/notification_screen.dart';
import '../home/leads/open_poll_filter.dart';
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
  GetPage(name: '/leadListMain', page: () => LeadListMain()),
  GetPage(name: '/notificationScreen', page: () =>NotificationScreen()),
  GetPage(name: '/leadDetailsMain', page: () =>LeadDetailsMain()),
  GetPage(name: '/addLeadScreen', page: () =>AddLeadScreen()),
  GetPage(name: '/loanApplication', page: () =>LoanApplicationScreen()),
  GetPage(name: '/openPollFilter', page: () =>OpenPollFilter()),
  GetPage(name: '/leadFollowup', page: () =>LeadFollowupScreen()),
  GetPage(name: '/leadDetailsTab', page: () =>LeadDetailsTab()),
  GetPage(name: '/leadHistory', page: () => LeadHistory()),
  GetPage(name: '/dashboardScreen', page: () => DashboardScreen()),
  GetPage(name: '/getAllReminder', page: () => GetAllReminderScreen()),
];
