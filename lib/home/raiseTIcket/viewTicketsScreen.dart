import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ksdpl/controllers/ticketControllers/raiseTicketController.dart';
import 'package:ksdpl/custom_widgets/CustomElevatedButton.dart';
import 'package:ksdpl/home/raiseTIcket/viewChatScreen.dart';
import '../../custom_widgets/commonActionButton.dart';
import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../controllers/ticketControllers/viewChatController.dart';
import '../../controllers/ticketControllers/viewTicketListController.dart';

class ViewTicketListScreen extends StatelessWidget {
 // const ViewTicketListScreen({super.key});

  ViewRaiseListController viewRaiseListController = Get.find();
  RaiseTicketController raiseTicketController=Get.put(RaiseTicketController());


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
   //     drawer:   const CustomDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  // Gradient Background
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

                  // White Container
                  Align(
                    alignment: Alignment.topCenter,  // Centers it
                    child: Container(
                      margin:  const EdgeInsets.only(
                          top:90 // MediaQuery.of(context).size.height * 0.22
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
                          const SizedBox(height: 20),
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
              child: Image.asset(AppImage.arrowLeft,height: 24,)),

          const Text(
            AppText.ticketList,
            style: TextStyle(
                fontSize: 20,
                color: AppColor.grey3,
                fontWeight: FontWeight.w700
            ),
          ),

          InkWell(
            onTap: (){

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

  Widget productSection(BuildContext context) {
    return Obx(() {

      ///
      /// New code
      if (viewRaiseListController.isLoadingValue.value) {
        return Center(child: CustomSkelton.productShimmerList(context));
      }

      final data =  viewRaiseListController.viewRaiseTicketListModel.value;

      if (data == null || data.data == null || data.data!.isEmpty) {
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

      final dataList = data.data!;

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          final data = dataList[index];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildCard("${index + 1}. ${data.ticketNo}", [
                DetailRow(label: AppText.status, value: viewRaiseListController.getStatusText(data.status)??'',statusId:data.status??0),
                DetailRow(label: AppText.ticketNo, value: data.ticketNo?.toString()??'',statusId:0),
                DetailRow(label: AppText.subject, value: data.subject?.toString()??'',statusId:0),
                DetailRow(label: AppText.priority, value: '${raiseTicketController.getPriorityName(int.tryParse(data.priority ?? ""))} ',statusId:0),
                DetailRow(label: AppText.panel, value: '${raiseTicketController.getQueryTypeName(int.tryParse(data.panelId.toString() ?? ""))} ',statusId:0),
                DetailRow(label: AppText.category, value: 'Category-${data.category?.toString()??''}', statusId:0),
                DetailRow(label: AppText.closeBy, value: '${data.closeBy?.toString()??''}', statusId:0),
               // CustomElevatedButton(text: AppText.view, onPressed:  myFunction(data.id))
                CommonActionButton(
                  text: AppText.view,
                  icon: Icons.remove_red_eye_sharp,
                  onPressed: () => myFunction(data.id),
                ),
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
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
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

  myFunction(int? id) {
    ViewChatController viewChatController = Get.put(ViewChatController());
    viewChatController.getTicketById(id:id);
    Get.to(() => ViewChatScreen());
  }
}


class DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final int statusId;

   DetailRow({
    Key? key,
    required this.label,
    required this.value,
     required this.statusId,
  }) : super(key: key);

  final ViewRaiseListController viewRaiseController = Get.find();

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
            style:  TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: statusId==0
                  ? Colors.black
                  : viewRaiseController.getStatusColor(statusId),
              //color: viewRaiseController.getStatusColorColors.black,
            ),
          ),
        ],
      ),
    );
  }
}




