import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../common/CustomSearchBar.dart';
import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../controllers/greeting_controller.dart';
import '../../controllers/leads/infoController.dart';
import '../../controllers/leads/leadlist_controller.dart';


class LeadListMain extends StatelessWidget {
  GreetingController greetingController = Get.find();
  InfoController infoController = Get.find();
  LeadListController leadListController = Get.put(LeadListController());
  final TextEditingController _searchController = TextEditingController();

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

                         Obx((){
                           if (leadListController.isLoading.value) {
                             return  Center(child: CustomSkelton.productShimmerList(context));
                           }
                           if (leadListController.getAllLeadsModel == null ||
                               leadListController.getAllLeadsModel!.data == null || leadListController.getAllLeadsModel!.data!.isEmpty) {
                             return  Container(
                               height: MediaQuery.of(context).size.height*0.50,
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
                                   Align(
                                     alignment: Alignment.center,
                                     child: Text(
                                       "No data found",
                                       style: TextStyle(
                                         fontSize: 16,
                                         fontWeight: FontWeight.bold,
                                         color: AppColor.grey700
                                       ),
                                     ),
                                   ),

                                 ],
                               ),
                             );
                           }

                           return  ListView.builder(
                             itemCount: leadListController.getAllLeadsModel!.data!.length,
                             shrinkWrap: true,
                             physics: NeverScrollableScrollPhysics(),
                             itemBuilder: (context, index) {
                               final lead = leadListController.getAllLeadsModel!.data![index];


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
                                                     lead.name!.isNotEmpty ?  lead.name![0].toUpperCase() : "U", // Initial Letter
                                                     style: TextStyle(color: Colors.white),
                                                   ),
                                                 ),
                                               ),
                                               SizedBox(width: 10),
                                               Column(
                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                 children: [
                                                   Text(
                                                     lead.name.toString(),
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
                                                         lead.mobileNumber.toString(),
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
                                           _buildDetailRow("Email", lead.email.toString()),
                                           _buildDetailRow("Assigned", lead.assignedEmployeeDate.toString()),
                                           _buildDetailRow("Uploaded on", lead.uploadedDate.toString()),
                                          // _buildDetailRow("Uploaded by", lead.uploadedBy.toString()),
                                          // _buildDetailRow("City", "Sagwada"),
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
                                               showLeadStatusDialog(
                                                 context: context,
                                                 leadId: lead.id
                                               );
                                             },
                                             child: Container(
                                               padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16), // Adjust padding as needed
                                               decoration: BoxDecoration(
                                                 color: AppColor.orangeColor, // Button background color
                                                 borderRadius: BorderRadius.circular(2), // Rounded corners
                                               ),
                                               child: Text(
                                                 "Status",
                                                 style: TextStyle(color: AppColor.appWhite),
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

                             },
                           );
                         })


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
 //   String assigned = value.toString();
//    List<String> assignedParts = assigned.split('T');

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(
            width: 85,

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
               ": ${value}",

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

/*  void showLeadStatusDialog({
    required BuildContext context,
    required leadId
}) {
    List<String> options = [
      "Interested",
      "Not Interested",
    ];

    String? selectedOption = options[0]; // Default selection

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: Text("Select Status:", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700,),),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: options.map((option) {
                  return RadioListTile<String>(
                    title: Text(option),
                    value: option,
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value;
                      });
                    },
                    activeColor: AppColor.orangeColor, // Change active radio button color
                  );
                }).toList(),
              ),
              actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {


                      Navigator.pop(context); // Close dialog after submission
                    },
                    style: ElevatedButton.styleFrom(foregroundColor: AppColor.grey1),
                    child: Text("Close",style: TextStyle(color: AppColor.grey2), ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      String selectedValue = (selectedOption == "Interested") ? "4" : "5";
                      String activeValue = (selectedOption == "Interested") ? "1" : "0";
                      leadListController.updateLeadStageApi(
                        id: leadId.toString(),
                        stage: selectedValue,
                        active:activeValue
                      );
                      Navigator.pop(context); // Close dialog after submission
                    },
                    style: ElevatedButton.styleFrom(backgroundColor:AppColor.orangeColor),
                    child: Text("Submit",style: TextStyle(color: AppColor.appWhite), ),
                  ),
                ],
              )

              ],
            );
          },
        );
      },
    );
  }*/

  void showLeadStatusDialog({
    required BuildContext context,
    required leadId,
  }) {
    List<String> options = ["Interested", "Not Interested"];
    String? selectedOption = options[0]; // Default selection

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                width: double.infinity, // Makes it full width
                padding: EdgeInsets.zero,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 🔵 Title in Blue Strip
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color:AppColor.primaryColor, // Title background color
                        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                        gradient: LinearGradient(
                          colors: [AppColor.primaryLight, AppColor.primaryDark],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Text(
                        "Select Status:",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.white, // Title text color
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    // 📝 Content (Radio Buttons)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: options.map((option) {
                          return RadioListTile<String>(
                            title: Text(option),
                            value: option,
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value;
                              });
                            },
                            activeColor: AppColor.orangeColor, // Change active radio button color
                          );
                        }).toList(),
                      ),
                    ),

                    // 🟠 Buttons (Close & Submit)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context); // Close dialog
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColor.grey1,
                              side: BorderSide(color: AppColor.grey2),
                            ),
                            child: Text("Close", style: TextStyle(color: AppColor.grey2)),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              String selectedValue = (selectedOption == "Interested") ? "4" : "5";
                              String activeValue = (selectedOption == "Interested") ? "1" : "0";
                              leadListController.updateLeadStageApi(
                                id: leadId.toString(),
                                stage: selectedValue,
                                active: activeValue,
                              );
                              Navigator.pop(context); // Close dialog after submission
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.orangeColor,
                            ),
                            child: Text("Submit", style: TextStyle(color: AppColor.appWhite)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

}

