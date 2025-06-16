
import 'package:get/get.dart';
import 'package:ksdpl/home/leads/lead_search_screen.dart';



import '../bottom_nav/bot_nav_ex.dart';
import '../call_storage/CallStorageScreen.dart';
import '../controllers/profile/theme_selection_screen.dart';
import '../enforcement_panel/enforcement_dashboard.dart';
import '../enforcement_panel/upload_common_task.dart';

import '../exp.dart';
import '../home/EditProfile2.dart';
import '../home/LeadListScreen.dart';
import '../home/camnote/camnote_group_screen.dart';
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
import '../home/loan_application/loan_application_screen.dart';
import '../home/manage_branch.dart';
import '../home/news/NewsDetailsScreen.dart';
import '../home/notification_screen.dart';
import '../home/leads/open_poll_filter.dart';
import '../home/product.dart';
import '../home/product/add_product_screen.dart';
import '../home/product/edit_product/edit_product_screen.dart';
import '../home/product/product_detail_screen.dart';
import '../home/product/view_product_screen.dart';
import '../home/splash.dart';
import '../registration/forgot_password_screen.dart';
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
  GetPage(name: '/editProfile2', page: () => EditProfile2()),
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
  //GetPage(name: '/leadFollowup', page: () =>LeadFollowupScreen()),
  GetPage(name: '/leadDetailsTab', page: () =>LeadDetailsTab()),
  GetPage(name: '/leadHistory', page: () => LeadHistory()),
  GetPage(name: '/dashboardScreen', page: () => DashboardScreen()),
  GetPage(name: '/getAllReminder', page: () => GetAllReminderScreen()),
  GetPage(name: '/leadSearchScreen', page: () => LeadSearchScreen()),
  GetPage(name: '/newsDetailsScreen', page: () => NewsDetailsScreen()),
  GetPage(name: '/addProductScreen', page: () => AddProductScreen()),
  GetPage(name: '/viewProductScreen', page: () => ViewProductScreen()),
  GetPage(name: '/productDetailScreen', page: () => ProductDetailScreen()),
  GetPage(name: '/editProductScreen', page: () => EditProductScreen()),
  GetPage(name: '/camNoteGroupScreen', page: () => CamNoteGroupScreen()),
  GetPage(name: '/forgotPasswordScreen', page: () => ForgotPasswordScreen()),
];
