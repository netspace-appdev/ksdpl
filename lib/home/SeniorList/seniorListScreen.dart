import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ksdpl/models/JobRoleModelResponse.dart';
import 'package:ksdpl/models/dashboard/GetAllStateModel.dart' as state;
import 'package:ksdpl/models/dashboard/GetAllChannelModel.dart' as channel;

import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../controllers/lead_dd_controller.dart';
import '../../controllers/product/add_product_controller.dart';
import '../../controllers/seniorController.dart';
import '../../custom_widgets/CustomBigDialogBox.dart';
import '../../custom_widgets/CustomBigYesNoLoaderDialogBox.dart';
import '../../custom_widgets/CustomDropdown.dart';
import 'package:ksdpl/models/dashboard/GetDistrictByStateModel.dart' as dist;
import 'package:ksdpl/models/dashboard/GetCityByDistrictIdModel.dart' as city;
import '../../custom_widgets/CustomTextLabel.dart';
import '../../models/product/GetAllProductCategoryModel.dart' as productCat;
import '../custom_drawer.dart';
import 'package:ksdpl/models/dashboard/GetAllKsdplProductModel.dart' as product;

class SeniorlistScreen extends StatelessWidget {
 // const SeniorlistScreen({super.key});
  SeniorScreenController seniorScreenController = Get.find();
  LeadDDController leadDDController = Get.find();
  AddProductController addProductController = Get.put(AddProductController());


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        drawer: const CustomDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
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
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        header(context),
                      ],
                    ),
                  ),

                  // White Container
                  Align(
                    alignment: Alignment.topCenter, // Centers it
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: 90 // MediaQuery.of(context).size.height * 0.22
                      ),
                      width: double.infinity,
                      //height: MediaQuery.of(context).size.height,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      decoration: const BoxDecoration(
                        color: AppColor.backgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45),
                          topRight: Radius.circular(45),
                        ),

                      ),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        // Prevents extra spacing
                        children: [


                          // SizedBox(height: 20),
                          productSection(context)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget header(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: () {
                Get.back();
              },
              child: Image.asset(AppImage.arrowLeft, height: 24,)),

          const Text(
            AppText.leadersOfHub,
            style: TextStyle(
                fontSize: 20,
                color: AppColor.grey3,
                fontWeight: FontWeight.w700
            ),
          ),

          InkWell(
            onTap: () {
              LeadDDController leadDDController = Get.find();
              leadDDController.getAllChannelListApi();
             showFilterDialogEmployeeList(context: context);
            },
            child: Container(
              width: 40,
              height:40,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration:  BoxDecoration(
                color: AppColor.appWhite.withOpacity(0.15),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Center(child: Image.asset(AppImage.filterIcon, height: 17,)),
            ),
          )
        ],
      ),
    );
  }

  Widget productSection(BuildContext context) {
    return Obx(() {
      if (seniorScreenController.isLoadingMainScreen.value) {
        return Center(child: CustomSkelton.productShimmerList(context));
      }

      final data =  seniorScreenController.seniorFilteredList;

      if (data.isEmpty) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.50,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.grey200),
            color: AppColor.appWhite,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: const Center(
            child: Text(
              "No data found",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColor.grey700,
              ),
            ),
          ),
        );
      }

      final dataList = data;

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          final data1 = dataList[index];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildCard("${index + 1}.  ${data1.employeeName?.toString()??''} ", [
                DetailRow(label:  AppText.employeeName, value: data1.employeeName?.toString()??''),
                DetailRow(label: AppText.emailNoStar, value: data1.email?.toString()??''),
                DetailRow(label: AppText.contactNo2, value: data1.phoneNumber?.toString()??''),
                DetailRow(label: AppText.whatsappNoNoStar, value: data1.whatsappNumber?.toString()??''),
                DetailRow(label: AppText.jobRoll, value: data1.jobRole?.toString()??''),
                DetailRow(label: AppText.channelName, value: data1.channelName?.toString()??''),
                DetailRow(label: AppText.state, value: data1.stateName?.toString()??''),
                DetailRow(label: AppText.city, value: data1.cityName?.toString()??''),
                DetailRow(label: AppText.district, value: data1.districtName?.toString()??''),
                DetailRow(label: AppText.postalcode, value: data1.postalCode?.toString()??''),
              ],
                  Icons.info_outline

              ),
              SizedBox(height: 20),
            ],
          );
        },
      );

    });
  }


  Widget buildCard(String title, List<Widget> children, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        border: Border.all(color: AppColor.grey4, width: 1),


      ),
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: const BoxDecoration(
              color: AppColor.primaryColor, // Blue background
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),

            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white,),
                const SizedBox(width: 5,),
                Expanded(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content section
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
    );
  }
  void showFilterDialogEmployeeList({
    required BuildContext context,
  })   {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Obx(() => CustomBigYesNoLoaderDialogBox(
          titleBackgroundColor: AppColor.secondaryColor,
          title: "Employee List Filter",
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const SizedBox(
                height: 10,
              ),

              const CustomTextLabel(
                label: AppText.searchVerticalByProduct,
                isRequired: true,
              ),

              const SizedBox(height: 10),

             /* Obx((){
                if (seniorScreenController.isLoadingProductCategory.value) {
                  return  Center(child:CustomSkelton.leadShimmerList(context));
                }

                return CustomDropdown<productCat.Data>(
                  items: addProductController.productCategoryList  ?? [],
                  getId: (item) => item.id.toString(),  // Adjust based on your model structure
                  getName: (item) => item.productCategoryName.toString(),
                  selectedValue: addProductController.productCategoryList.firstWhereOrNull(
                        (item) => item.id == seniorScreenController.selectedProductCategory.value,
                  ),
                  onChanged: (value) async {
                    seniorScreenController.selectedProductCategory.value =  value?.id;

                   await seniorScreenController.getChannelDetailsByProductIdApiRequest(ProductId:value?.id.toString());
                    print("Channel list size: ${leadDDController.channelList.length}");
                    print("Selected channel: ${seniorScreenController.selectedChannel.value}");

                  },
                  onClear: (){
                    seniorScreenController.selectedProductCategory.value = 0;
                    seniorScreenController.selectedChannel.value=0;
                    seniorScreenController.isChannelDisable.value=false;
                    leadDDController.channelList.clear();
                  },
                );
              }),*/


              Obx((){
                if (leadDDController.isProductLoading.value) {
                  return  Center(child:CustomSkelton.leadShimmerList(context));
                }


                return CustomDropdown<product.Data>(
                  items: leadDDController.ksdplProductList ?? [],
                  getId: (item) => item.id.toString(),  // Adjust based on your model structure
                  getName: (item) => item.productName.toString(),
                  selectedValue: leadDDController.ksdplProductList.firstWhereOrNull(
                        (item) => item.id == seniorScreenController.selectedProductCategory.value,
                  ),
                  onChanged: (value) async {
                    seniorScreenController.selectedProductCategory.value =  value?.id;

                    await seniorScreenController.getChannelDetailsByProductIdApiRequest(ProductId:value?.id.toString());
                    print("Channel list size: ${leadDDController.channelList.length}");
                    print("Selected channel: ${seniorScreenController.selectedChannel.value}");
                  },
                  onClear: (){
                    seniorScreenController.selectedProductCategory.value = 0;
                    seniorScreenController.selectedChannel.value=0;
                    seniorScreenController.isChannelDisable.value=false;
                    leadDDController.channelList.clear();
                  },
                );
              }),

              const SizedBox(
                height: 10,
              ),

               Text(
                AppText.channelName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color:
                  AppColor.grey2,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              seniorScreenController.isChannelDisable.value==true?
              seniorScreenController.selectedChannel.value==0 ?
              const Text(
                AppText.noChannelFound,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color:
                  AppColor.redColor,
                ),
              ):
              Text(
                "${seniorScreenController.getChannelDetailsByProduct.value?.data?.first.channelName} -${seniorScreenController.getChannelDetailsByProduct.value?.data?.first.channelCode}",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color:
                  AppColor.secondaryColor,
                ),
              )
                  :
              Obx((){
                if (leadDDController.isChannelLoading.value) {
                  return  Center(child:CustomSkelton.leadShimmerList(context));
                }

                return CustomDropdown<channel.Data>(
                  items: leadDDController.channelList ?? [],
                  getId: (item) => item.id.toString(),  // Adjust based on your model structure
                  getName: (item) => item.channelName.toString()+" (${item.channelCode.toString()})",
                  selectedValue:  leadDDController.channelList.firstWhereOrNull(
                        (item) => item.id == seniorScreenController.selectedChannel.value,
                  ),
                  onChanged: (value) {
                    seniorScreenController.selectedChannel.value =  value?.id;
                  },
                  isEnabled: seniorScreenController.isChannelDisable.value==true?false:true,
                  onClear:(){
                    seniorScreenController.isChannelDisable.value=true;
                  },
                );
              }),
              const SizedBox(
                height: 10,
              ),

              const Text(
                AppText.state,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.grey2,
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              Obx((){
                if (leadDDController.isStateLoading.value) {
                  return  Center(child:CustomSkelton.productShimmerList(context));
                }

                return CustomDropdown<state.Data>(
                  items: leadDDController.getAllStateModel.value?.data ?? [],
                  getId: (item) => item.id.toString(),  // Adjust based on your model structure
                  getName: (item) => item.stateName.toString(),
                  selectedValue: leadDDController.getAllStateModel.value?.data?.firstWhereOrNull(
                        (item) => item.id.toString() == seniorScreenController.selectedState.value,
                  ),
                  onChanged: (value) {
                    seniorScreenController.selectedState.value =  value?.id?.toString();
                    leadDDController.getDistrictByStateIdApi(stateId: seniorScreenController.selectedState.value);
                  },
                );
              }),
              const SizedBox(
                height: 10,
              ),
              const Text(
                AppText.district,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.grey2,
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              Obx((){
                if (leadDDController.isDistrictLoading.value) {
                  return  Center(child:CustomSkelton.productShimmerList(context));
                }
                return CustomDropdown<dist.Data>(
                  items: leadDDController.getDistrictByStateModel.value?.data ?? [],
                  getId: (item) => item.id.toString(),  // Adjust based on your model structure
                  getName: (item) => item.districtName.toString(),
                  selectedValue: leadDDController.getDistrictByStateModel.value?.data?.firstWhereOrNull(
                        (item) => item.id.toString() == seniorScreenController.selectedDistrict.value,
                  ),
                  onChanged: (value) {
                    seniorScreenController.selectedDistrict.value =  value?.id?.toString();
                    leadDDController.getCityByDistrictIdApi(districtId: seniorScreenController.selectedDistrict.value);
                  },
                );
              }),
              const SizedBox(
                height: 10,
              ),
              const Text(
                AppText.city,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.grey2,
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              Obx((){
                if (leadDDController.isCityLoading.value) {
                  return  Center(child:CustomSkelton.leadShimmerList(context));
                }
                return CustomDropdown<city.Data>(
                  items: leadDDController.getCityByDistrictIdModel.value?.data ?? [],
                  getId: (item) => item.id.toString(),  // Adjust based on your model structure
                  getName: (item) => item.cityName.toString(),
                  selectedValue: leadDDController.getCityByDistrictIdModel.value?.data?.firstWhereOrNull(
                        (item) => item.id.toString() == seniorScreenController.selectedCity.value,
                  ),
                  onChanged: (value) {
                    seniorScreenController.selectedCity.value =  value?.id?.toString();
                  },
                );
              }),

              const SizedBox(height: 10),

              const CustomTextLabel(
                label: AppText.jobRoll,
                isRequired: true,
              ),

              const SizedBox(height: 10),

              Obx(() {
                if (seniorScreenController.isLoadingProductCategory.value) {
                  return Center(child: CustomSkelton.leadShimmerList(context));
                }

                final items = leadDDController.jobRoleFiltered;
                print('object________${items.isEmpty}');

                return CustomDropdown<JobRoleData>(
                  items: items,
                  getId: (item) => item.id.toString(),
                  getName: (item) => item.name ?? "",
                  selectedValue: items.firstWhereOrNull(
                        (item) =>
                    item.id.toString() == seniorScreenController.selectedJobroleId.value,
                  ),
                  onChanged: (value) {
                    seniorScreenController.selectedJobroleId.value =
                        value?.normalizedName;
                  },

                  onClear: () {
                    seniorScreenController.selectedJobroleId.value = null;
                  },
                );
              }),


/*
              Obx((){
                if (seniorScreenController.isLoadingProductCategory.value) {
                  return  Center(child:CustomSkelton.leadShimmerList(context));
                }

                return CustomDropdown<JobRoleData>(
                  items: seniorScreenController.jobRoleFiltered  ?? [],
                  getId: (item) => item.toString(),  // Adjust based on your model structure
                  getName: (item) => item.name.toString(),
                  selectedValue: seniorScreenController.jobRoleFiltered.firstWhereOrNull(
                        (item) => item.id == seniorScreenController.selectedJobroleId.value,
                  ),
                  onChanged: (value) {
                    seniorScreenController.selectedJobroleId.value =  value?.id.toString();
                  },
                  onClear: (){
                    seniorScreenController.selectedJobroleId.value = null;
                //    addProductController.productCategoryList.clear(); // reset dependent dropdown
                  },
                );
              }),
*/

              const SizedBox(
                height: 100,
              ),
            ],
          ),

          // 👇 Loader logic right here
          firstButtonChild: seniorScreenController.isLoadingProductCategory.value
              ? const SizedBox(
            height: 18,
            width: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          )
              : const Text(
            AppText.submit,
            style: TextStyle(color: Colors.white),
          ),

          secondButtonText: AppText.clearFilter,
          firstButtonColor: AppColor.secondaryColor,
          secondButtonColor: AppColor.primaryColor,

          onFirstButtonPressed: () {
            seniorScreenController.filterSubmit();
            Get.back();
          },
          onSecondButtonPressed: () {
            seniorScreenController.filterClear();
            Get.back();
          },
        ));
      },
    );
  }

/*  void showFilterDialogEmployeeList({
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomBigDialogBox(
          titleBackgroundColor: AppColor.secondaryColor,
          title: "Employee List Filter",
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const SizedBox(
                height: 10,
              ),



              const CustomTextLabel(
                label: AppText.productSegment,
                isRequired: true,
              ),

              const SizedBox(height: 10),

              Obx((){
                if (seniorScreenController.isLoadingProductCategory.value) {
                  return  Center(child:CustomSkelton.leadShimmerList(context));
                }

                return CustomDropdown<productCat.Data>(
                  items: addProductController.productCategoryList  ?? [],
                  getId: (item) => item.id.toString(),  // Adjust based on your model structure
                  getName: (item) => item.productCategoryName.toString(),
                  selectedValue: addProductController.productCategoryList.firstWhereOrNull(
                        (item) => item.id == seniorScreenController.selectedProductCategory.value,
                  ),
                  onChanged: (value) {
                    seniorScreenController.selectedProductCategory.value =  value?.id;
                    seniorScreenController.getChannelDetailsByProductIdApiRequest(ProductId:value?.id.toString());

                  },
                  onClear: (){
                    seniorScreenController.selectedProductCategory.value = 0;
                    addProductController.productCategoryList.clear(); // reset dependent dropdown
                  },
                );
              }),
              const SizedBox(
                height: 10,
              ),
              const Text(
                AppText.channelName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.grey2,
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              Obx((){
                if (leadDDController.isChannelLoading.value) {
                  return  Center(child:CustomSkelton.leadShimmerList(context));
                }

                return CustomDropdown<channel.Data>(
                  items: leadDDController.getAllChannelModel.value?.data ?? [],
                  getId: (item) => item.id.toString(),  // Adjust based on your model structure
                  getName: (item) => item.channelName.toString()+" (${item.channelCode.toString()})",
                  selectedValue: leadDDController.getAllChannelModel.value?.data?.firstWhereOrNull(
                        (item) => item.id == seniorScreenController.selectedChannel.value,
                  ),
                  onChanged: (value) {
                    seniorScreenController.selectedChannel.value =  value?.id;
                  },
                  isEnabled: seniorScreenController.isChannelDisable.value==true?false:true,
                  onClear:(){
                    seniorScreenController.isChannelDisable.value=true;
                  },
                );
              }),
              const SizedBox(
                height: 10,
              ),

              const Text(
                AppText.state,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.grey2,
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              Obx((){
                if (leadDDController.isStateLoading.value) {
                  return  Center(child:CustomSkelton.productShimmerList(context));
                }

                return CustomDropdown<state.Data>(
                  items: leadDDController.getAllStateModel.value?.data ?? [],
                  getId: (item) => item.id.toString(),  // Adjust based on your model structure
                  getName: (item) => item.stateName.toString(),
                  selectedValue: leadDDController.getAllStateModel.value?.data?.firstWhereOrNull(
                        (item) => item.id.toString() == seniorScreenController.selectedState.value,
                  ),
                  onChanged: (value) {
                    seniorScreenController.selectedState.value =  value?.id?.toString();
                    leadDDController.getDistrictByStateIdApi(stateId: seniorScreenController.selectedState.value);
                  },
                );
              }),
              const SizedBox(
                height: 10,
              ),
              const Text(
                AppText.district,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.grey2,
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              Obx((){
                if (leadDDController.isDistrictLoading.value) {
                  return  Center(child:CustomSkelton.productShimmerList(context));
                }
                return CustomDropdown<dist.Data>(
                  items: leadDDController.getDistrictByStateModel.value?.data ?? [],
                  getId: (item) => item.id.toString(),  // Adjust based on your model structure
                  getName: (item) => item.districtName.toString(),
                  selectedValue: leadDDController.getDistrictByStateModel.value?.data?.firstWhereOrNull(
                        (item) => item.id.toString() == seniorScreenController.selectedDistrict.value,
                  ),
                  onChanged: (value) {
                    seniorScreenController.selectedDistrict.value =  value?.id?.toString();
                    leadDDController.getCityByDistrictIdApi(districtId: seniorScreenController.selectedDistrict.value);
                  },
                );
              }),
              const SizedBox(
                height: 10,
              ),
              const Text(
                AppText.city,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.grey2,
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              Obx((){
                if (leadDDController.isCityLoading.value) {
                  return  Center(child:CustomSkelton.leadShimmerList(context));
                }
                return CustomDropdown<city.Data>(
                  items: leadDDController.getCityByDistrictIdModel.value?.data ?? [],
                  getId: (item) => item.id.toString(),  // Adjust based on your model structure
                  getName: (item) => item.cityName.toString(),
                  selectedValue: leadDDController.getCityByDistrictIdModel.value?.data?.firstWhereOrNull(
                        (item) => item.id.toString() == seniorScreenController.selectedCity.value,
                  ),
                  onChanged: (value) {
                    seniorScreenController.selectedCity.value =  value?.id?.toString();
                  },
                );
              }),

              const SizedBox(height: 10),

              const CustomTextLabel(
                label: AppText.jobRoll,
                isRequired: true,
              ),

              const SizedBox(height: 10),

              Obx(() {
                if (seniorScreenController.isLoadingProductCategory.value) {
                  return Center(child: CustomSkelton.leadShimmerList(context));
                }

                final items = leadDDController.jobRoleFiltered;
                print('object________${items.isEmpty}');

                return CustomDropdown<JobRoleData>(
                  items: items,
                  getId: (item) => item.id.toString(),
                  getName: (item) => item.name ?? "",
                  selectedValue: items.firstWhereOrNull(
                        (item) =>
                    item.id.toString() == seniorScreenController.selectedJobroleId.value,
                  ),
                  onChanged: (value) {
                    seniorScreenController.selectedJobroleId.value =
                        value?.id.toString();
                  },

                  onClear: () {
                    seniorScreenController.selectedJobroleId.value = null;
                  },
                );
              }),

*/
/*
              Obx((){
                if (seniorScreenController.isLoadingProductCategory.value) {
                  return  Center(child:CustomSkelton.leadShimmerList(context));
                }

                return CustomDropdown<JobRoleData>(
                  items: seniorScreenController.jobRoleFiltered  ?? [],
                  getId: (item) => item.toString(),  // Adjust based on your model structure
                  getName: (item) => item.name.toString(),
                  selectedValue: seniorScreenController.jobRoleFiltered.firstWhereOrNull(
                        (item) => item.id == seniorScreenController.selectedJobroleId.value,
                  ),
                  onChanged: (value) {
                    seniorScreenController.selectedJobroleId.value =  value?.id.toString();
                  },
                  onClear: (){
                    seniorScreenController.selectedJobroleId.value = null;
                //    addProductController.productCategoryList.clear(); // reset dependent dropdown
                  },
                );
              }),
*/
/*
            ],
          ),
          onSubmit: () {
            seniorScreenController.filterSubmit();
           Get.back();
          },
        );
      },
    );
  }*/


}


class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 14, color: AppColor.primaryColor
            ),
          ),
          const SizedBox(height: 4),
          value=="null" || value==AppText.customdash?
          const Row(
            children: [
              Icon(Icons.horizontal_rule, size: 15,),
            ],):
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}


