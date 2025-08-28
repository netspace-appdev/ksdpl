import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ksdpl/common/base_url.dart';
import 'package:ksdpl/common/helper.dart';
import 'package:ksdpl/controllers/InsuranceIllustrationsController/InsuranceIllustrationController.dart';
import 'package:ksdpl/controllers/bot_nav_controller.dart';
import 'package:ksdpl/controllers/lead_dd_controller.dart';
import 'package:ksdpl/controllers/leads/addLeadController.dart';
import 'package:ksdpl/controllers/vacancyListController/vacancyListController.dart';
import 'package:ksdpl/home/InsuranceIllustrations/InsuranceIllustrationScreen.dart';
import 'package:ksdpl/home/cibilgenerate/CibilGeneratePage.dart';
import 'package:ksdpl/home/insuranceLeads/insuranceLeadScreen.dart';
import 'package:ksdpl/home/tutorial_screen/tutorial_video.dart';
import 'package:ksdpl/home/vacancyListPage/VacancyListScreen.dart';

import 'package:ksdpl/home/viewExpense/viewExpense.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common/customListTIle.dart';
import '../common/storage_service.dart';
import '../controllers/cibilgenerate_controller/cibilRecordListController.dart';
import '../controllers/insuranceLeadsController/insuranceLeadController.dart';
import '../controllers/viewExpenseController/viewExpenseController.dart';
import '../controllers/webController.dart';
import '../controllers/attendance/attendance_controller.dart';
import '../controllers/camnote/camnote_controller.dart';
import '../controllers/leads/income_step_controller.dart';
import '../controllers/leads/leadlist_controller.dart';
import '../controllers/product/add_product_controller.dart';
import '../controllers/product/view_product_controller.dart';
import '../custom_widgets/RoundedInitialContainer.dart';
import 'RestrictedWebView.dart';
import 'addEmployeeExpenseDetails/addEmployeeExpenseDetails.dart';
import 'cibilgenerate/cibilRecordList.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String firstName="user";
  String email="user@email.com";
  String role="";

  LeadListController leadListController = Get.find();
  Addleadcontroller addLeadController = Get.find();
  BotNavController botNavController=Get.find();
  WebController _webController=Get.put(WebController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColor.primaryDark, AppColor.primaryLight],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              image: DecorationImage(
                image: AssetImage(AppImage.backDrawer),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 15, top: 40),
                child: Row(
                  //crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    RoundedInitialContainer(firstName: firstName,),
                    SizedBox(width: 10,),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.50,
                          child: Text(
                            firstName,//firstName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width*0.50,

                          child: Text(
                            role,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white70,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          // Navigation Items
          Padding(
            padding: const EdgeInsets.only(left: 17.0),
            child: Column(
              children: [
                CustomListTile(
                  title:  AppText.home,
                  imagePath:AppImage.home2,
                  onTap: () {
                    Navigator.pop(context);
                    botNavController.selectedIndex.value = 0;
                  },

                ),

                ExpansionTile(
                  childrenPadding: EdgeInsets.symmetric(horizontal: 20),
                  title:const Text(AppText.leads, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                  leading: Image.asset(AppImage.manInBlack, height: 20,),
                  children: [
                    ListTile(

                      leading:  Icon(Icons.add_task,color: AppColor.blackColor),
                      title:  Text("Add", style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                      onTap: () {
                        LeadDDController leadDDController=Get.find();
                        leadDDController.getAllKsdplProductApi();
                        AddProductController addProductController =Get.put(AddProductController());
                        addProductController.getAllProductCategoryApi();

                        addLeadController.fromWhere.value="drawer";

                        addLeadController.clearControllers();
                        CamNoteController camNoteController=Get.put(CamNoteController());
                        Get.toNamed("/addLeadScreen");
                      },
                    ),
                    ListTile(//color:Theme.of(context).brightness == Brightness.dark?Colors.white54: AppColor.black54
                      leading:  Icon(Icons.view_stream_outlined,color: AppColor.blackColor),
                      title:  Text("View",style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500)),
                      onTap: () {
                        leadListController.stateIdMain.value="0";
                        leadListController.distIdMain.value="0";
                        leadListController.cityIdMain.value="0";
                        leadListController.campaignMain.value="";
                        leadListController.fromWhere.value="drawer";
                        leadListController.isDashboardLeads.value=false;

                        Get.toNamed("/leadListMain");
                      },
                    ),
                  ],
                ),


                ExpansionTile(
                  childrenPadding: EdgeInsets.symmetric(horizontal: 20),
                  title:const Text(AppText.manageProducts, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                  leading: Image.asset(AppImage.product, height: 20,),
                  children: [
                    ListTile(

                      leading:  Icon(Icons.add_task,color: AppColor.blackColor),
                      title:  Text("Add Product", style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                      onTap: () {
                        LeadDDController leadDDController=Get.find();
                        leadDDController.getAllKsdplProductApi();
                        AddProductController addProductController =Get.put(AddProductController());
                        addProductController.getAllProductCategoryApi();
                        addProductController.getAllNegativeProfileApi();
                        addProductController.getAllCommonDocumentNameListApi();
                        addProductController.clearForm();
                        addProductController.currentStep.value=0;
                        addProductController.isFirstSave.value=0;

                        Get.toNamed("/addProductScreen");

                      },
                    ),
                    ListTile(//color:Theme.of(context).brightness == Brightness.dark?Colors.white54: AppColor.black54
                      leading:  Icon(Icons.view_stream_outlined,color: AppColor.blackColor),
                      title:  Text("View Products",style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500)),
                      onTap: () {
                        ViewProductController viewProductController=Get.put(ViewProductController());
                        viewProductController.getAllProductListApi();
                        AddProductController addProductController =Get.put(AddProductController());
                        addProductController.getAllProductCategoryApi();
                        Get.toNamed("/viewProductScreen");
                      },
                    ),
                  ],
                ),

                ExpansionTile(
                  childrenPadding: EdgeInsets.symmetric(horizontal: 20),
                  title: const Text(
                    AppText.manageCibil,
                    style: TextStyle(
                      color: AppColor.blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  leading: Image.asset(AppImage.addcivil, height: 20),
                  children: [
                    ListTile(
                      leading: Icon(Icons.add_task, color: AppColor.blackColor),
                      title: Text(
                        "Cibil Generate",
                        style: TextStyle(
                          color: AppColor.blackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        Get.to(() => Cibilgeneratepage());
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.menu, color: AppColor.blackColor),
                      title: Text(
                        "Cibil Record List",
                        style: TextStyle(
                          color: AppColor.blackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        CibilRecordListController cibilrecordListcontroller=Get.put(CibilRecordListController());
                        cibilrecordListcontroller.getCustomerCibilDetailByUserIdApi();
                        Get.to(() => CibilRecordListScreen());
                      },
                    ),
                  ],
                ),

                ExpansionTile(
                  childrenPadding: EdgeInsets.symmetric(horizontal: 20),
                  title:const Text(AppText.manageProfile, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                  leading: Image.asset(AppImage.user, height: 20,),
                  children: [
                    ListTile(
                      leading:  Icon(Icons.add_task,color: AppColor.blackColor),
                      title:  Text(AppText.addExpenses, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                      onTap: () {
                        Get.to(() => AddEmployeeExpenseDetails());
                      },
                    ),
                    ListTile(//color:Theme.of(context).brightness == Brightness.dark?Colors.white54: AppColor.black54
                      leading:  Icon(Icons.view_stream_outlined,color: AppColor.blackColor),
                      title:  Text(AppText.viewExpenses, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500)),
                      onTap: () {
                        ViewExpenseController viewExpenseController=Get.put(ViewExpenseController());
                        viewExpenseController.getExpenseByEmployeeIDApi();
                      //  AddProductController addProductController =Get.put(AddProductController());
                       // addProductController.getAllProductCategoryApi();
                        Get.to(ViewExpenseScreen());

                       // Get.toNamed("/viewProductScreen");
                      },
                    ),
                  ],
                ),

                ExpansionTile(
                  childrenPadding: EdgeInsets.symmetric(horizontal: 20),
                  title:const Text(AppText.manageVacancy, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                  leading: Image.asset(AppImage.user, height: 20,),
                  children: [
                    ListTile(
                      leading:  Icon(Icons.add_task,color: AppColor.blackColor),
                      title:  Text(AppText.vacancyList, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                      onTap: () {
                        Vacancylistcontroller vacalistcontroller=Get.put(Vacancylistcontroller());
                        vacalistcontroller.getAllVacancyApi();
                        Get.to(() => VacancyListScreen());
                      },
                    ),
                  ],
                ),

               /* ExpansionTile(
                  childrenPadding: EdgeInsets.symmetric(horizontal: 20),
                  title:const Text(AppText.manageAttendance, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                  leading: Image.asset(AppImage.product, height: 20,),
                  children: [
                    ListTile(

                      leading:  Icon(Icons.add_task,color: AppColor.blackColor),
                      title:  Text(AppText.attendance, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                      onTap: () {
                        var empId=StorageService.get(StorageService.EMPLOYEE_ID).toString();
                        AttendanceController attendanceController=Get.put(AttendanceController());
                        attendanceController.clearFields();
                        attendanceController.getAttendanceListOfEmployeesByEmployeeIdApi(employeeId: empId);
                        Get.toNamed("/viewAttendanceScreen");

                      },
                    ),
                    ListTile(//color:Theme.of(context).brightness == Brightness.dark?Colors.white54: AppColor.black54
                      leading:  Icon(Icons.view_stream_outlined,color: AppColor.blackColor),
                      title:  Text(AppText.manageLeaves, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500)),
                      onTap: () {
                        var empId=StorageService.get(StorageService.EMPLOYEE_ID).toString();
                        AttendanceController attendanceController=Get.put(AttendanceController());
                        attendanceController.clearFields();
                        attendanceController.getAllLeaveTypeApi();
                        attendanceController.getAllLeaveDetailByEmployeeIdApi(employeeId: empId);
                        Get.toNamed("/manageLeaveScreen");
                      },
                    ),
                  ],
                ),*/


                ExpansionTile(
                  childrenPadding: EdgeInsets.symmetric(horizontal: 20),
                  title:const Text(AppText.manageInsuranceLeads, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                  leading: Image.asset(AppImage.user, height: 20,),
                  children: [
                    ListTile(
                      leading:  Icon(Icons.add_task,color: AppColor.blackColor),
                      title:  Text(AppText.insuranceLeadsList, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                      onTap: () {
                        InsuranceLeadController insuranceLeadController =Get.put(InsuranceLeadController());
                        insuranceLeadController.getAllVacancyApi();
                        AddProductController addProductController =Get.put(AddProductController());
                        addProductController.getAllProductCategoryApi();
                        Get.to(() => InsuranceLeadScreen());
                      },
                    ),
                    ListTile(
                      leading:  Icon(Icons.add_task,color: AppColor.blackColor),
                      title:  Text(AppText.illustrationsList, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                      onTap: () {
                        InsuranceIllustrationController insuranceIllustrationController = Get.put(InsuranceIllustrationController());
                        insuranceIllustrationController.getInsuranceIllustrationApi();
                        Get.to(() => InsuranceIllustrationScreen());
                      },
                    ),
                  ],
                ),


                ExpansionTile(
                  childrenPadding: EdgeInsets.symmetric(horizontal: 20),
                  title: const Text(
                    AppText.manageTutorial,
                    style: TextStyle(
                      color: AppColor.blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  leading: Image.asset(AppImage.addppt, height: 20),
                  children: [
                    ListTile(
                      leading: Icon(Icons.add_task, color: AppColor.blackColor),
                      title: Text(
                        "Banker",
                        style: TextStyle(
                          color: AppColor.blackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        Get.to(() => TutorialVideo(
                          url: _webController.tutorial_video_Url,
                          title: "Banker",
                        ));
                      },
                    ),
                    // Keep rest of the ExpansionTile unchanged...
                    ListTile(
                      leading: Icon(Icons.view_stream_outlined, color: AppColor.blackColor),
                      title: Text(
                        "customer",
                        style: TextStyle(
                          color: AppColor.blackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        _webController.isCustomerExpanded.toggle(); // cleaner toggle syntax
                      },
                    ),

// ✅ Wrap the conditional block in Obx to reactively show/hide
                    Obx(() {
                      if (!_webController.isCustomerExpanded.value) return SizedBox();
                      return Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.circle, color: AppColor.blackColor,size: 10,),
                              title: Text(
                                "PPT in Hindi",
                                style: TextStyle(
                                  color: AppColor.blackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onTap: () {
                                Get.to(() => RestrictedWebView(
                                  url: _webController.hindiUrl,
                                  title: "PPT in Hindi",
                                ));
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.circle, color: AppColor.blackColor,size: 10,),
                              title: Text(
                                "PPT in English",
                                style: TextStyle(
                                  color: AppColor.blackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onTap: () {
                                Get.to(() => RestrictedWebView(
                                  url: _webController.englishUrl,
                                  title: "PPT in English",
                                ));
                              },
                            ),
                          ],
                        ),
                      );
                    }),

                    ListTile(
                      leading: Icon(Icons.view_stream_outlined, color: AppColor.blackColor),
                      title: Text(
                        "Staff",
                        style: TextStyle(
                          color: AppColor.blackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        Get.to(() => TutorialVideo(
                          url: _webController.tutorial_video_Url,
                          title: "Staff",
                        ));

                      },
                    ),
                  ],
                ),
                
                CustomListTile(
                  title:  "Website",
                  imagePath:AppImage.webImg,
                  onTap: () => _launchURL("https://kanchaneshver.in/"),
                ),
                CustomListTile(
                  title:  AppText.robmLogin,
                  imagePath:AppImage.webImg,
                  onTap: () => _launchURL("https://sales.kanchaneshver.com/"),
                ),
                CustomListTile(
                  title:  AppText.aicLogin,
                  imagePath:AppImage.webImg,
                  onTap: () => _launchURL("https://aic.kanchaneshver.com/"),
                ),

                CustomListTile(
                  title:  "Bank Credentials",
                  imagePath:AppImage.webImg,
                  onTap: () => _launchURL("https://docs.google.com/spreadsheets/d/1__iYzKKiDthxhfTqh8WEsdVolIcl2ymi0fqnShwNqto/edit?gid=0#gid=0"),
                ),


                // Logout Button
                CustomListTile(
                  title:  AppText.logout,
                  imagePath:AppImage.powerIcon,
                  onTap: () {
                    StorageService.clear();
                    Get.offAllNamed("/login");
                  },
                ),
                SizedBox(
                  height: 5,
                ),


                Text(
                  BaseUrl.devVersion,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    BaseUrl.buildDate,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),

                SizedBox(
                  height: 50,
                )

              ],
            ),
          )
        ],
      ),
    );
  }

  loadData(){

    firstName=StorageService.get(StorageService.FULL_NAME).toString();
    email=StorageService.get(StorageService.EMAIL).toString();
    var rawRole = StorageService.get(StorageService.ROLE).toString();
    role = rawRole.replaceAll('[', '').replaceAll(']', '');
  }

  _launchURL(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
