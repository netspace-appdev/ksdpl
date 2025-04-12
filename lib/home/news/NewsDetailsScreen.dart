import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ksdpl/common/base_url.dart';

import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../controllers/news_controller/newsDetailsController.dart';

class NewsDetailsScreen extends StatelessWidget {
  NewsDetailsController newsDetailsController=Get.put(NewsDetailsController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  // Gradient Header
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColor.primaryLight, AppColor.primaryDark],
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child:Column(
                      children: [

                        const SizedBox(
                          height: 20,
                        ),

                        header(context),

                      ],
                    ),
                  ),

                  // White Body Overlay
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.only(top: 90),
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      decoration: const BoxDecoration(
                        color: AppColor.backgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45),
                          topRight: Radius.circular(45),
                        ),
                      ),
                      child: newsDetails(context),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Image.asset(AppImage.arrowLeft, height: 24),
          ),
          const Text(
            "News Details",
            style: TextStyle(
              fontSize: 20,
              color: AppColor.grey3,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 24), // Just to balance the row
        ],
      ),
    );
  }

  Widget newsDetails(BuildContext context){

    return Obx((){
      if (newsDetailsController.isLoading.value) {
        return  Center(child: CustomSkelton.productShimmerList(context));
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          // Static Title
          Text(
            newsDetailsController.getNewsByIdModel.value!.data!.title.toString(),
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColor.primaryDark,
            ),
          ),
          const SizedBox(height: 10),

          // Static Date
           Text(
             Helper.formatDate(newsDetailsController.getNewsByIdModel.value!.data!.createdDate.toString()),
            style: TextStyle(
              fontSize: 14,
              color: AppColor.grey700,
            ),
          ),
          const SizedBox(height: 20),

          // Static Image
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: newsDetailsController.getNewsByIdModel.value!.data!.imageUrl.toString()==""?
            Image.asset(
              AppImage.noImage,
              width: double.infinity,
              height: 100,
              fit: BoxFit.cover,
            ):
            Image.network(
              BaseUrl.imageBaseUrl+ newsDetailsController.getNewsByIdModel.value!.data!.imageUrl.toString(),
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),

          ),
          const SizedBox(height: 20),

          // Static Description
           Text(
            newsDetailsController.getNewsByIdModel.value!.data!.description.toString(),
            style: TextStyle(
              fontSize: 16,
              color: AppColor.grey1,
              height: 1.5,
            ),
          ),
        ],
      );
    });
  }
}
