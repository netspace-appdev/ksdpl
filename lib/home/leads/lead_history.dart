import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../controllers/greeting_controller.dart';
import '../../controllers/leads/infoController.dart';
import '../../controllers/leads/leadDetailsController.dart';
import '../../controllers/leads/lead_history_controller.dart';
import '../../controllers/leads/leadlist_controller.dart';
import '../../custom_widgets/CustomCard.dart';


class LeadHistory extends StatelessWidget {

  GreetingController greetingController = Get.put(GreetingController());
  InfoController infoController = Get.put(InfoController());

  LeadListController leadListController = Get.put(LeadListController());
  LeadHistoryController leadHistoryController = Get.put(LeadHistoryController());

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(

        backgroundColor: AppColor.backgroundColor,

        body: SingleChildScrollView(
          child: Column(
            children: [


              // White Container
              Align(
                alignment: Alignment.topCenter,  // Centers it
                child: Container(
                  width: double.infinity,
                  //height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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

                      leadSection(context)

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget header(context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          InkWell(
              onTap: (){
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AppImage.arrowLeft,height: 24,),
              )),
          const Text(
            AppText.leadDetails,
            style: TextStyle(
                fontSize: 20,
                color: AppColor.grey3,
                fontWeight: FontWeight.w700


            ),
          ),

          InkWell(
            onTap: (){
              //showFilterDialog(context: context);
            },
            child: Container(

              width: 40,
              height:40,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration:  const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),

            ),
          )



        ],
      ),
    );
  }



  Widget leadSection(BuildContext context){
    return Obx((){
      if (leadHistoryController.isLoading.value) {
        return  Center(child: CustomSkelton.productShimmerList(context));
      }
      if (leadHistoryController.getLeadWorkByLeadIdModel.value == null ||
          leadHistoryController.getLeadWorkByLeadIdModel.value!.data == null || leadHistoryController.getLeadWorkByLeadIdModel.value!.data=="") {
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
          child: const Column(

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

      return ListView.builder(
        itemCount:leadHistoryController.getLeadWorkByLeadIdModel.value!.data!.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        reverse: true,
        itemBuilder: (context, index) {
          var lead=leadHistoryController.getLeadWorkByLeadIdModel.value!.data![index];
          print("call status===>${lead.callStatus.toString()}");
          //var time=Helper.formatTimeAgo(lead.workDate.toString());

          return CustomCard(
            borderColor: AppColor.grey200,
            backgroundColor: AppColor.appWhite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            /*      Text(AppText.leadHistory,
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),*/



                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star_border_outlined),
                        Icon(Icons.list_alt_rounded),
                        if(lead.callStatus.toString()=="0")
                        Icon(Icons.published_with_changes_rounded),
                        if(lead.callStatus.toString()=="1")
                        Icon(Icons.call),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(Helper.formatTimeAgo(lead.workDate.toString()),
                          style: TextStyle(
                              fontSize: 14,color: AppColor.grey700)),
                    ),
                  ],
                ),
               // if(lead.callStatus.toString()=="1")
                  Column(
                    children: [
                      Helper.customDivider(color: AppColor.grey200),
                      DetailRow(label: "Call Duration", value:lead.callDuration.toString() ),
                      DetailRow(label: "Call Start Time", value: lead.callStartTime.toString() ),
                      DetailRow(label: "Call End Time", value: lead.callEndTime.toString()),
                      DetailRow(label: "Call Reminder", value: lead.callReminder.toString()=="null"?"No Reminder": Helper.convertDateTime(lead.callReminder.toString())),
                      DetailRow(label: "Call Feedback", value: lead.feedBackRelatedToCall.toString()),
                      DetailRow(label: "Lead Feedback", value: lead.feedBackRelatedToLead.toString()),
                    ],
                  ),
                Helper.customDivider(color: AppColor.grey200),

                DetailRow(label: "Lead Status", value: lead.previousStageName.toString(), value2: lead.stageName.toString(),),

              ],
            ),
          );

        },
      );



    });

  }



}


//details

// Helper Widget for Status Chips
class StatusChip extends StatelessWidget {
  final String label;
  final Color color;

  StatusChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(label, style: TextStyle(color: AppColor.appWhite, fontSize: 12)),
    );
  }
}

// Helper Widget for Detail Rows
class DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final String? value2;

  DetailRow({required this.label, required this.value, this.value2});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(

            width: 120,
            child: Text("$label",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColor.primaryColor)),
          ),
          if(label=="Lead Status")
            Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(": ${value}", style: TextStyle(fontSize: 14), maxLines: 1),
                    Icon(Icons.arrow_right_alt),
                    Flexible(
                        child: Text(value2.toString(), style: TextStyle(fontSize: 14),),

                    )
                  ],
                ))
          else
            Expanded(
              child: Text(": "+value, style: TextStyle(fontSize: 14), maxLines: 1)),
        ],
      ),
    );
  }
}

// Helper Widget for Icon Buttons
class IconButtonWidget extends StatelessWidget {
  final IconData icon;
  final Color color;

  IconButtonWidget({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: Container(
        height: 27,
        width: 27,
        // color: color.withOpacity(0.2),
        decoration: BoxDecoration(

        ),
        child: Center(child: Icon(icon, color: color,size: 16,)),
      ),
    );
  }
}
