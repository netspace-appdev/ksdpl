import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../common/CustomSearchBar.dart';
import '../../common/helper.dart';
import '../../controllers/greeting_controller.dart';
import '../../controllers/leads/infoController.dart';


class LeadListMain extends StatelessWidget {
  GreetingController greetingController = Get.find();
  InfoController infoController = Get.find();
  final TextEditingController _searchController = TextEditingController();
  List<String> _allItems = ["Apple", "Banana", "Mango", "Orange", "Pineapple"];
  List<String> _filteredItems = [];
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
                  // Gradient Background
                  Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColor.primaryLight, AppColor.primaryDark],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child:Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),

                        header(),

                        SizedBox(
                          height: 20,
                        ),

                        searchArea()

                      ],
                    ),
                  ),

                  // White Container
                  Align(
                    alignment: Alignment.topCenter,  // Centers it
                    child: Container(
                      margin:  EdgeInsets.only(
                          top:  MediaQuery.of(context).size.height * 0.22
                      ), // <-- Moves it 30px from top
                      width: double.infinity,
                      //height: MediaQuery.of(context).size.height,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      decoration: const BoxDecoration(
                        color: AppColor.backgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45),
                          topRight: Radius.circular(45),
                        ),

                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min, // Prevents extra spacing
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Lead Info",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(

                                children: [
                                  Icon(Icons.add,color: AppColor.orangeColor,size: 16,),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Add Lead",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.orangeColor
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          ListView.builder(
                            itemCount: 5,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                margin: EdgeInsets.symmetric(vertical: 10),
                                decoration:  BoxDecoration(
                                  border: Border.all(color: AppColor.grey200),
                                  color: AppColor.appWhite,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),

                                ),
                                child: Column(

                                  children: [
                                    /// Header with profile and menu icon
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 40,
                                                width: 40,

                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppColor.primaryColor,
                                                  border: Border.all(color: AppColor.secondaryColor),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "K", // Initial Letter
                                                    style: TextStyle(color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Kemi A. Olunloyo",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        height: 10,
                                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                        decoration:  BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          border: Border.all(color: AppColor.grey200),
                                                          color: AppColor.grey1,
                                                        ),
                                                      ),
                                                      Text(
                                                        "+91 9033885577",
                                                        style: TextStyle(
                                                          color: AppColor.grey700,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Icon(Icons.more_vert, color: AppColor.grey1,), // Three dots menu icon
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),

                                    /// Lead details
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Column(
                                        children: [
                                          _buildDetailRow("Acquired", "12:24 PM Fri, 29 Nov 24"),
                                          _buildDetailRow("Email", "info@gmail.com"),
                                          _buildDetailRow("City", "Sagwada"),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),

                                    /// Action Buttons (Call, Chat, Mail, WhatsApp, Status)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [

                                          _buildIconButton(AppImage.call1, AppColor.orangeColor),
                                          _buildIconButton(AppImage.chat1, Colors.orange),
                                          _buildIconButton(AppImage.message1, Colors.green),
                                          _buildIconButton(AppImage.whatsapp, Colors.green),
                                          InkWell(
                                            onTap: () {
                                              // Handle button press
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16), // Adjust padding as needed
                                              decoration: BoxDecoration(
                                                color: AppColor.orangeColor, // Button background color
                                                borderRadius: BorderRadius.circular(2), // Rounded corners
                                              ),
                                              child: Text(
                                                "Status",
                                                style: TextStyle(color: AppColor.primaryLight),
                                              ),
                                            ),
                                          )

                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),

                                    /// Bottom Row Buttons (Assigned, Follow Up, Call Back, Employment)
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        _buildTextButton("Assigned"),
                                        _buildTextButton("Follow Up"),
                                        _buildTextButton("Call Back"),
                                        _buildTextButton("Employment"),
                                      ],
                                    ),
                                  ],
                                ),
                              );


                             /* return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                margin: EdgeInsets.symmetric(vertical: 10),
                                decoration:  BoxDecoration(
                                  border: Border.all(color: AppColor.grey200),
                                  color: AppColor.appWhite,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),

                                ),
                                child: Column(

                                  children: [
                                    /// Header with profile and menu icon
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 40,
                                                width: 40,

                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppColor.primaryColor,
                                                  border: Border.all(color: AppColor.secondaryColor),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "K", // Initial Letter
                                                    style: TextStyle(color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Kemi A. Olunloyo",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        height: 10,
                                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                        decoration:  BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          border: Border.all(color: AppColor.grey200),
                                                          color: AppColor.grey1,
                                                        ),
                                                      ),
                                                      Text(
                                                        "+91 9033885577",
                                                        style: TextStyle(
                                                          color: AppColor.grey700,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Icon(Icons.more_vert, color: AppColor.grey1,), // Three dots menu icon
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),

                                    /// Lead details
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Column(
                                        children: [
                                          _buildDetailRow("Acquired", "12:24 PM Fri, 29 Nov 24"),
                                          _buildDetailRow("Email", "info@gmail.com"),
                                          _buildDetailRow("City", "Sagwada"),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),

                                    /// Action Buttons (Call, Chat, Mail, WhatsApp, Status)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [

                                          _buildIconButton(AppImage.call1, AppColor.orangeColor),
                                          _buildIconButton(AppImage.chat1, Colors.orange),
                                          _buildIconButton(AppImage.message1, Colors.green),
                                          _buildIconButton(AppImage.whatsapp, Colors.green),
                                          InkWell(
                                            onTap: () {
                                              // Handle button press
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16), // Adjust padding as needed
                                              decoration: BoxDecoration(
                                                color: AppColor.orangeColor, // Button background color
                                                borderRadius: BorderRadius.circular(2), // Rounded corners
                                              ),
                                              child: Text(
                                                "Status",
                                                style: TextStyle(color: AppColor.primaryLight),
                                              ),
                                            ),
                                          )

                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),

                                    /// Bottom Row Buttons (Assigned, Follow Up, Call Back, Employment)
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        _buildTextButton("Assigned"),
                                        _buildTextButton("Follow Up"),
                                        _buildTextButton("Call Back"),
                                        _buildTextButton("Employment"),
                                      ],
                                    ),
                                  ],
                                ),
                              );*/
                            },
                          )


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
  Widget header(){
    return Obx(()=>Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 48, // Adjust size as needed
                height: 48,
                decoration: BoxDecoration(
                  color: AppColor.orangeColor,
                  // shape: BoxShape.circle,
                  border: Border.all(color: AppColor.appWhite, width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                alignment: Alignment.center,
                child: Text(
                  infoController.firstName.value.isNotEmpty ?  infoController.firstName.value[0].toUpperCase() : "U",
                  style: TextStyle(
                    color: AppColor.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Obx(()=>Text(
                     greetingController.greetingMsg.value.toString(),
                     style: TextStyle(
                         fontSize: 12,

                         color: AppColor.grey3
                     ),
                   )),
                  Text(
                    infoController.firstName.value.toString(),
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,

                        color: AppColor.grey3
                    ),
                  )
                ],
              ),
            ],
          ),


          Image.asset(
            AppImage.noti_icon, // Replace with your image path
            height: 40,
          ),

        ],
      ),
    ));
  }

  Widget searchArea(){
    return Row(
      children: [
        Expanded(
          child: CustomSearchBar(
            controller: _searchController,
            onChanged: (val){},
            hintText: "Search Leads...",
          ),
        ),
        Container(

          width: 50,
          height:50,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: const BoxDecoration(
            color: AppColor.backgroundColor,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Center(child: Image.asset(AppImage.filterIcon, height: 22,)),
        )
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(
            width: 100,

            child: Text(
              "$label",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColor.primaryLight,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              ": $value",
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper widget for icon buttons
  Widget _buildIconButton(String icon, Color color) {
    return IconButton(
      onPressed: () {},
      // icon: Icon(icon, color: color),
      icon: Container(

        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration:  BoxDecoration(
          border: Border.all(color: AppColor.grey200),
          color: AppColor.appWhite,
          borderRadius: BorderRadius.all(
            Radius.circular(2),
          ),

        ),
        child: Center(
          // child: Icon(icon, color: color),
          child: Image.asset(icon, height: 12,),
        ),
      ),
    );
  }

  /// Helper widget for text buttons
  Widget _buildTextButton(String label) {
    return GestureDetector(
      onTap: () {
        // Handle button press
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10), // Adjust padding as needed
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.grey1), // Border color
          borderRadius: BorderRadius.circular(2), // Rounded corners
        ),
        child: Text(
          label,
          style: TextStyle(color: AppColor.grey1, fontSize: 10),
        ),
      ),
    )
    ;
  }


}

