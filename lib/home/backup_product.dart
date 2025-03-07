/*
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:product/services/home_service.dart';
import 'package:shimmer/shimmer.dart';

import '../../common/carousel_slider.dart';
import '../../common/helper.dart';
import '../../common/search_bar.dart';
import '../controllers/api_controller.dart';
import '../models/ProductListModel.dart';
import 'custom_drawer.dart';
import 'package:http/http.dart' as http;



class ProductScreen extends StatefulWidget {

  const ProductScreen({super.key});
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  final ApiController apiController = Get.put(ApiController());
  ProductListModel? productListModel;
  bool isLoading=false;
  dynamic arg= Get.arguments;
  @override
  void initState() {
    super.initState();
    getProduct(arg["productId"]);
  }
  @override
  Widget build(BuildContext context) {


    return  Scaffold(

      backgroundColor: AppColor.backgroundColor,

      appBar: AppBar(
        toolbarHeight: 80,

        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(

              width: 20.0,
              height: 20.0,

              decoration: BoxDecoration(

                  shape: BoxShape.circle,
                  color: AppColor.appWhite
              ),
              child: Icon(Icons.arrow_back, size: 28, color:AppColor.secondaryColor),
            ),
          ),
        ),
        title: Text(arg["productName"], style: TextStyle(color: AppColor.primaryColor,fontSize:AppFSize.mediumFont, fontWeight: FontWeight.w600),),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(Icons.notifications_none, size: 28, color: AppColor.secondaryColor),
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

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(height: 10,),
              CustomSearchBar(),
              SizedBox(height: 10,),
              isLoading?
              Center(child: shimmerList()):
              productListModel==null?
              // Center(child: Text(AppText.noData, style: TextStyle(color: AppColor.lightGrey,fontSize:AppFSize.mediumFont,),),)
              Center(child: shimmerList())
                  :
              productList(),
              SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }
  Widget productList(){
    return SingleChildScrollView(
      child: Column(
        children: [

          Padding(
              padding: const EdgeInsets.all(8.0),
              child:
              ListView.builder(

                itemCount: productListModel!.data!.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = productListModel!.data![index];
                  return Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 320.0,

                        decoration: BoxDecoration(
                            color: AppColor.appWhite,
                            borderRadius: BorderRadius.circular(10.0)

                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,

                            children: [
                              Container(

                                width: MediaQuery.of(context).size.width,
                                height: 200.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                    image: NetworkImage(ApiService.base2+ item.productThumimage!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                item.productTitle.toString(),
                                style: TextStyle(color: AppColor.secondaryColor,fontSize:AppFSize.mediumFont, ),
                              ),
                              Text(
                                item.shortdetails.toString(),
                                style: TextStyle(color: AppColor.lightGrey,fontSize:AppFSize.smallFont, ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                "\u{20B9} ${item.priceMrp}",
                                style: TextStyle(color: AppColor.secondaryColor,fontSize:AppFSize.largeFont, fontWeight: FontWeight.w600),
                              ),

                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  );
                },
              )
          )
        ],
      ),
    );
  }

  Future<void> getProduct(String catId) async{
    setState(() {
      isLoading=true;
    });
    final response = await http.post(
      Uri.parse(ApiService.listProduct),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'category': catId}),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse['code'] == 200 && jsonResponse['data'] != null) {
        setState(() {
          isLoading=false;
        });
        productListModel=ProductListModel.fromJson(jsonResponse);;
        print("productListModel on page===<${productListModel!.data!.first!.shortdetails.toString()}");
      } else {
        setState(() {
          isLoading=false;
        });
        throw Exception('Invalid API response');
      }
    } else {
      setState(() {
        isLoading=false;
      });
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Widget shimmerList() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: 6, // Number of shimmer placeholders
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 100.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          );

        },
      ),
    );
  }


}*/
