
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ksdpl/models/dashboard/GetAllStateModel.dart';
import 'package:ksdpl/models/dashboard/GetDistrictByStateModel.dart' as dist;
import 'package:ksdpl/models/dashboard/GetCityByDistrictIdModel.dart' as city;
import 'package:ksdpl/models/dashboard/GetAllBankModel.dart' as bank;
import 'package:ksdpl/models/dashboard/GetAllKsdplProductModel.dart' as product;
import 'package:ksdpl/models/dashboard/GetProductListByBank.dart' as productBank;
import 'package:ksdpl/models/GetCampaignNameModel.dart' as campaign;
import 'package:ksdpl/models/leads/GetAllKsdplBranchModel.dart' as ksdplBranch;
import '../../../common/CustomSearchBar.dart';
import '../../../common/helper.dart';
import '../../../common/skelton.dart';
import '../../../common/validation_helper.dart';
import '../../../controllers/drawer_controller.dart';
import '../../../controllers/greeting_controller.dart';
import '../../../controllers/lead_dd_controller.dart';
import '../../../controllers/leads/addLeadController.dart';
import '../../../controllers/leads/infoController.dart';
import '../../../custom_widgets/CustomDropdown.dart';
import '../../../custom_widgets/CustomLabelPickerTextField.dart';
import '../../../custom_widgets/CustomLabeledTextField.dart';
import '../../common/storage_service.dart';
import '../../controllers/leads/leadlist_controller.dart';
import '../../controllers/open_poll_filter_controller.dart';
import '../../controllers/product/add_product_controller.dart';
import '../../controllers/product/product_detail_controller.dart';
import '../../controllers/product/view_product_controller.dart';
import '../../custom_widgets/CustomBigDialogBox.dart';
import '../../custom_widgets/CustomCard.dart';
import '../../custom_widgets/CustomDialogBox.dart';
import '../../custom_widgets/CustomTextFieldPrefix.dart';
import '../custom_drawer.dart';



class ProductDetailScreen extends StatelessWidget {





  ProductDetailsController productDetailsController = Get.put(ProductDetailsController());
  AddProductController addProductController = Get.find();


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        drawer:   CustomDrawer(),
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
                      margin:  EdgeInsets.only(
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
            AppText.productDetails,
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
              decoration:  BoxDecoration(
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
      if (productDetailsController.isLoading.value || addProductController.isLoadingMainScreen.value) {
        return Center(child: CustomSkelton.productShimmerList(context));
      }

      final data = productDetailsController.getProductListById.value?.data;
      if (data == null || data == "") {
        return /// Header with profile and menu icon
          Align(
              alignment: Alignment.center,
              child: Text(
                  "No data found",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColor.grey700
                  )));
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildCard("Basic Product Info", [
            DetailRow(label: AppText.productName, value: data.product.toString()),
            DetailRow(label: AppText.productSegment, value: data.productCategoryName.toString()),
            DetailRow(label: AppText.selectCustomerCategory, value: data.customerCategory.toString()),
            DetailRow(label: AppText.minCibil, value: data.minCIBIL.toString()),
          ],
            Icons.info_outline

          ),

          buildCard("Bank & Contact Info", [
            DetailRow(label: AppText.bankNostar, value: data.bankName.toString()),
            DetailRow(label: AppText.bankerName, value: data.bankersName.toString()),
            DetailRow(label: AppText.bankerMobile, value: data.bankersMobileNumber.toString()),
            DetailRow(label: AppText.bankerWhatsapp, value: data.bankersWhatsAppNumber.toString()),
            DetailRow(label: AppText.bankerEmail, value: data.bankersEmailID.toString()),
          ],
              Icons.phone
          ),

          buildCard("Collateral & Profile Restrictions", [
            DetailRow(label: AppText.selectCollateralSecurityCategory, value: data.collateralSecurityCategory.toString()), //Collateral is Prime now
            DetailRow(label: AppText.collateralSecurityExcluded, value: data.collateralSecurityExcluded.toString()),
           // DetailRow(label: AppText.profileExcluded, value: data.profileExcluded.toString()),
            DetailRow(label: AppText.negativeProfiles, value: data.negativeProfiles.toString()),
            DetailRow(label: AppText.negativeAreas, value: data.negativeAreas.toString()),
            DetailRow(label: AppText.geoLimit, value: data.geoLimit.toString()),
          ],
              Icons.security
          ),

          buildCard("Eligibility Criteria", [
            DetailRow(label: AppText.selectIncomeType, value: data.incomeTypes.toString()),
            DetailRow(label:  AppText.ageLimitEarningApplicants, value: data.ageLimitEarningApplicants.toString()),
            DetailRow(label: AppText.ageLimitNonEarningCoApplicant, value: data.ageLimitNonEarningCoApplicant.toString()),
            DetailRow(label: AppText.minAgeEarningApplicants, value: data.ageLimitNonEarningCoApplicant.toString()),
            DetailRow(label: AppText.minAgeNonEarningApplicants, value: data.minimumAgeNonEarningApplicants.toString()),
            DetailRow(label: AppText.minIncomeCriteria, value: data.minimumIncomeCriteria.toString()),
            DetailRow(label: AppText.minLoanAmount, value: data.minimumLoanAmount.toString()),
            DetailRow(label: AppText.maxLoanAmount, value: data.maximumLoanAmount.toString()),
            DetailRow(label: AppText.minRoi, value: data.minimumROI.toString()),
            DetailRow(label:  AppText.maxRoi, value: data.maximumROI.toString()),
            DetailRow(label: AppText.minTenor, value: data.minTenor.toString()),
            DetailRow(label:  AppText.maxTenor, value: data.maximumTenor.toString()),
            DetailRow(label: AppText.ageAtMaturity, value: data.maximumTenorEligibilityCriteria.toString()),
          ],
              Icons.rule
          ),

          buildCard("Financial Limits", [
            DetailRow(label: AppText.minPropertyValue, value: data.minimumPropertyValue.toString()),
            DetailRow(label:  AppText.maxIir, value: data.maximumIIR.toString()),
            DetailRow(label: AppText.maxFoir, value: data.maximumFOIR.toString()),
            DetailRow(label: AppText.maxLtv, value: data.maximumLTV.toString()),
          ],
              Icons.radar
          ),

          buildCard("Charges & Fees", [
            DetailRow(label: AppText.processingFee, value: data.processingFee.toString()),
            DetailRow(label: AppText.processingCharges, value: data.processingCharges.toString()),
            DetailRow(label:  AppText.legalFee, value: data.legalFee.toString()),
            DetailRow(label: AppText.technicalFee, value: data.technicalInspectionFee.toString()),
            DetailRow(label:  AppText.adminFee, value: data.adminFee.toString()),
            DetailRow(label: AppText.foreclosureCharges, value: data.foreclosureCharges.toString()),
            DetailRow(label: AppText.otherCharges, value: data.otherCharges.toString()),
            DetailRow(label: AppText.stampDuty, value: data.stampDuty.toString()),
            DetailRow(label: AppText.tsrYears, value: data.tsRYears.toString()),
            DetailRow(label: AppText.tsrCharges, value: data.tsRCharges.toString()),
            DetailRow(label: AppText.valuationCharges, value: data.valuationCharges.toString()),
            DetailRow(label: AppText.fromAmtRange, value: data.fromAmountRange.toString()),
            DetailRow(label: AppText.toAmtRange, value: data.toAmountRange.toString()),
            DetailRow(label: AppText.totalOverdueCases2, value: data.totalOverdueCases.toString()),
            DetailRow(label: AppText.totalOverdueAmount, value: data.totalOverdueAmount.toString()),
            DetailRow(label: AppText.totalEnquiries2, value: data.totalEnquiries.toString()),
          ],
              Icons.attach_money
          ),

          buildCard("Administrative Info", [
            DetailRow(label: AppText.noOfDocuments, value: data.noOfDocument.toString()),
            DetailRow(label: AppText.ksdplProduct, value: data.ksdplProductName.toString()),
            DetailRow(label: AppText.eligibleProfitPercent, value: data.profitPercentage.toString()),
            DetailRow(label: AppText.maxTat, value: data.maximumTAT.toString()),
          ],
              Icons.admin_panel_settings_sharp
          ),

          buildCard("Documents", [
            addProductController.getDocumentProductIdModel.value!.data!.isEmpty?
            DetailRow(label: "No Docs Found", value: "")
           : ListView.builder(
              itemCount:addProductController.getDocumentProductIdModel.value!.data!.length,//viewProductController.getAllProductListModel.value!.data!.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                // final product = viewProductController.getAllProductListModel.value!.data![index];
                final data =  addProductController.getDocumentProductIdModel.value!.data![index];


                return DetailRow(label: data.documentName.toString(), value: (data.documentType!.trim().toString()=="m" || data.documentType!.trim().toString()=="M") ?"Mandatory":"Optional" );

              },
            ),

          /*  getDocumentProductIdModel.value!.data![0]
            DetailRow(label: "No of Documents", value: data.noOfDocument.toString()),*/
          ],
              Icons.list_alt_rounded
          ),

          SizedBox(height: 20),
        ],
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
            decoration: BoxDecoration(
              color: AppColor.primaryColor, // Blue background
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),

            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white,),
                SizedBox(width: 5,),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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
/*class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Container(

            width: 120,
            child: Text("$label",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColor.primaryColor)),
          ),
          Text(":", style: TextStyle(fontSize: 14),),
          Expanded(
              child: value=="null" || value==AppText.customdash?
              Row(


                children: [
                  Icon(Icons.horizontal_rule, size: 15,),
                ],):
              Text(" "+value, style: TextStyle(fontSize: 14), maxLines: 2)),
        ],
      ),
    );
  }
}*/

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
          Row(


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





