import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ksdpl/common/skelton.dart';
import 'package:ksdpl/controllers/dashboard/DashboardController.dart';

import 'package:ksdpl/services/home_service.dart';
import 'package:shimmer/shimmer.dart';

import '../../common/carousel_slider.dart';
import '../../common/helper.dart';
import '../../common/search_bar.dart';

import '../../controllers/api_controller.dart';
import '../home/custom_drawer.dart';
import 'drawer_enforcement.dart';






class EnforcementDashboard extends StatefulWidget {
  const EnforcementDashboard({super.key});

  @override
  State<EnforcementDashboard> createState() => _EnforcementDashboardState();
}

class _EnforcementDashboardState extends State<EnforcementDashboard> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final DashboardController dashboardController = Get.put(DashboardController());
  final ApiController apiController = Get.put(ApiController());

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppColor.backgroundColor,

        appBar: AppBar(
          toolbarHeight: 80,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: InkWell(
              onTap: (){
                scaffoldKey.currentState!.openDrawer();
              },
              child: Container(

                width: 20.0,
                height: 20.0,

                decoration: BoxDecoration(

                    shape: BoxShape.circle,
                    color: AppColor.appWhite
                ),
                child: Icon(Icons.menu, size: 28, color:AppColor.black54),
              ),
            ),
          ),
          title: Text(AppText.brandName, style: TextStyle(color: AppColor.primaryColor,fontSize:AppFSize.largeFont, fontWeight: FontWeight.w600),),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.notifications_none, size: 28, color: AppColor.black54),
            ),
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.center,
                  colors: <Color>[AppColor.appBlue2, AppColor.appWhite]),
            ),
          ),
        ),
        drawer:   DrawerEnforcement(),
        body: SingleChildScrollView (
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(

              children: [
                SizedBox(height: 10,),
                Align(
                  alignment: Alignment.center,
                  child: Container(

                    height: 100,
                    width:200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    //  color: AppColor.primaryColor,
                    ),
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: Column(
                        children: [
                         // Icon(Icons.admin_panel_settings_sharp,color: AppColor.appWhite,size: 40,),
                        //  SizedBox(height: 10,),
                          Text("Enforcement Panel", style: TextStyle(color: AppColor.black87),)
                        ],
                      ),
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget category(){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppText.category, style: TextStyle(color: AppColor.secondaryColor,fontSize:AppFSize.largeFont, fontWeight: FontWeight.w500),),
            Text(AppText.viewAll, style: TextStyle(color: AppColor.primaryColor,fontSize:AppFSize.mediumFont, fontWeight: FontWeight.w600),),
          ],
        ),
        Obx((){
          if (apiController.isLoading.value) {
            return  Center(child: CustomSkelton.homeShimmerList());
          }else if (apiController.categoryListModel==null) {
            //return const Center(child: Text(AppText.noData, style: TextStyle(color: AppColor.lightGrey,fontSize:AppFSize.mediumFont,),),);
            return  Center(child: CustomSkelton.homeShimmerList());
          }else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 120.0, // Set height for the horizontal list
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: apiController.categoryListModel!.data!.length,
                  itemBuilder: (context, index) {
                    // print("data in API===>${apiController.sliderModel!.data![index].}");
                    final item = apiController.categoryListModel!.data![index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: InkWell(
                        onTap: (){
                          Get.toNamed("/product", arguments:{
                            "productId":item.id.toString(),
                            "productName":item.title.toString(),
                          } );

                        },
                        child: Container(
                          width: 100.0,
                          height: 100.0,

                          decoration: BoxDecoration(
                              color: AppColor.appWhite,
                              borderRadius: BorderRadius.circular(10.0      )

                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(

                                width: 50.0,
                                height: 50.0,

                                decoration: BoxDecoration(

                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppColor.orangeColor, width: 3.0),
                                  image: DecorationImage(
                                    image: NetworkImage(ApiService.base2+item.categoryThumimage!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                item.title.toString(),
                                style: const TextStyle(fontSize: 14.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
        })


      ],
    );
  }


}
