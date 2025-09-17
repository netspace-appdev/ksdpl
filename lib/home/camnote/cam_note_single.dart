
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ksdpl/common/base_url.dart';
import 'package:ksdpl/controllers/camnote/camnote_controller.dart';
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
import 'camnot_photo_view.dart';



class CamNoteSingle extends StatelessWidget {
  final CamNoteController camNoteController=Get.find();

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
                          camNoteDetailSingleSection(context)
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
            AppText.camNoteDetails,
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

  Widget camNoteDetailSingleSection(BuildContext context) {
    return Obx(() {
      if (camNoteController.isLoading.value || camNoteController.isLoadingMainScreen.value) {
        return Center(child: CustomSkelton.productShimmerList(context));
      }

      final data = camNoteController.getCamNoteDetailByIdModel.value?.data;
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
          buildCard("Basic Info", [
            DetailRow(label: AppText.bankName, value: data.bankName.toString()),
            DetailRow(label: AppText.branchName, value: data.branchName.toString()/* +" - "+data..toString()*/),
            DetailRow(label: AppText.bankerName, value: data.bankersName.toString()),
            DetailRow(label: AppText.bankerMobile, value: data.bankersMobileNumber.toString()),
            DetailRow(label: AppText.bankerWhatsapp, value: data. bankersWhatsAppNumber.toString()),
            DetailRow(label: AppText.bankerEmail, value: data.bankersEmailID.toString()),
          ],
              Icons.info_outline

          ),

          buildCard("CIBIL Info", [
            DetailRow(label: AppText.cibil, value: data.cibil.toString()),
            DetailRow(label: AppText.totalLoanAvaileCibil, value: data.totalLoanAvailedOnCibil.toString()),
            DetailRow(label: AppText.totalLiveLoan, value: data. totalLiveLoan.toString()),
            DetailRow(label: AppText.totalEmi, value: data.totalEMI.toString()),
            DetailRow(label: AppText.emiStoppedBefore, value: data.emiStoppedOnBeforeThisLoan.toString()),
            DetailRow(label: AppText.emiWillContinue, value: data.emiWillContinue.toString()),
            DetailRow(label: AppText.totalOverdueCases, value: data.totalOverdueCasesAsPerCibil.toString()),
            DetailRow(label: AppText.totalOverdueAmountCibil, value: data.totalOverdueAmountAsPerCibil.toString()),
            DetailRow(label: AppText.totalEnquiries, value: data.totalEnquiriesMadeAsPerCibil.toString()),

          ],
              Icons.money_rounded

          ),

          buildCard("Loan Info", [
            DetailRow(label: AppText.loanSegment, value: data.productCategoryName.toString()),
            DetailRow(label: AppText.loanProduct, value: data.product.toString()),
            DetailRow(label: AppText.offeredSecurityType, value: data.offeredSecurityType.toString()),
            DetailRow(label: AppText.geoLocationProperty, value: data.geoLocationOfProperty.toString()),
            DetailRow(label: AppText.geoLocationResidence, value: data.geoLocationOfResidence.toString()),
            DetailRow(label: AppText.geoLocationOffice, value: data.geoLocationOfOffice.toString()),


          ],
              Icons.info_outline

          ),

          buildCard("Eligibility Criteria", [
            DetailRow(label: AppText.incomeType, value: data.incomeType.toString()),
            DetailRow(label: AppText.earningCustomerAge, value: data.earningCustomerAge.toString()),
            DetailRow(label: AppText.nonEarningCustomerAge, value: data.nonEarningCustomerAge.toString()),
            DetailRow(label: AppText.totalFamilyIncome, value: data.totalFamilyIncome.toString()),
            DetailRow(label: AppText.incomeCanBeConsidered, value: data.incomeCanBeConsidered.toString()),
            DetailRow(label: AppText.loanAmountRequested, value: data.loanAmountRequested.toString()),
            DetailRow(label: AppText.loanTenorRequested, value: data.loanTenorRequested.toString()),
            DetailRow(label: AppText.rateOfInterest, value: data.roi.toString()),
            DetailRow(label: AppText.proposedEmi, value: data.proposedEMI.toString()),
            DetailRow(label: AppText.propertyValue, value: data.propertyValueAsPerCustomer.toString()),
            DetailRow(label: AppText.foir, value: data.foir.toString()),
            DetailRow(label: AppText.ltv, value: data.ltv.toString()),

          ],
              Icons.rule

          ),

          buildCard("Sanction Details", [

            DetailRow(label: AppText.softSanctionStatus, value: data.softsanction==0?"Pending":
            data.softsanction==1?"Approved":
            data.softsanction==2?"Hold":
            data.softsanction==-1?"Rejected":
            ""),
            DetailRow(label: AppText.sanctionAmount, value: data.sanctionAmount.toString()),
            DetailRow(label: AppText.sanctionTenor, value: data.sanctionTenor.toString()),
            DetailRow(label: AppText.sanctionROI, value: data.sanctionROI.toString()),
            DetailRow(label: AppText.sanctionCondition, value: data.sanctionCondition.toString()),
            DetailRow(label: AppText.sanctionProcessingFees, value: data.sanctionProcessingFees.toString()),
            DetailRow(label: AppText.sanctionStampDuty, value: data.sanctionStampDuty.toString()),
            DetailRow(label: AppText.softSanctionDate, value: Helper.formatDate(data.softsanctionDate.toString())), //check it
            DetailRow(label: AppText.rejectReason, value: data.rejectReason.toString()),

            DetailRow(label: AppText.sanctionEstimatedEMI, value: data.sanctionEstimatedEMI.toString()),
            DetailRow(label: AppText.applicableLegalFee, value: data.sanctionApplicableLegalFee.toString()),
            DetailRow(label: AppText.applicableTechnicalFee, value: data.sanctionApplicableTechnicalFee.toString()),
            DetailRow(label: AppText.applicableAdminFee, value: data.sanctionApplicableAdminFee.toString()),
            DetailRow(label: AppText.applicableForeclosureCharges, value: data.sanctionApplicableForeclosureCharges.toString()),
            DetailRow(label: AppText.applicableOtherCharges, value: data.sanctionApplicableOtherCharges.toString()),
            DetailRow(label: AppText.tsrYears, value: data.sanctionTSRYears.toString()),
            DetailRow(label: AppText.applicableTSRCharges, value: data.sanctionApplicableTSRCharges.toString()),
            DetailRow(label: AppText.applicableValuationCharges, value: data.sanctionApplicableValuationCharges.toString()),

          ],
              Icons.security

          ),

          buildCard("Document Details", [
            DetailRow(label: AppText.documents, value: data.documents==null?"No documents" : Helper.formatStringToSerialNumbers(data.documents.toString())),

          ],
              Icons.document_scanner

          ),

          ExpansionTile(
            initiallyExpanded: true,
            childrenPadding: EdgeInsets.symmetric(horizontal: 20),
            title:const Text( AppText.personInformation, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
            leading: Icon(Icons.list_alt, size: 20,),
            children: [

              Column(
                children: [
                  ApiPhotoViewer(
                    controller: camNoteController,
                    imageKey: "property_photo",
                    imageUrls: data.photosOfProperty?.split(",")
                        .map((path) => "${BaseUrl.imageBaseUrl}$path")
                        .toList() ?? [],
                    label: "Photos Of Property",
                    isCloseVisible: false,
                  ),
                  SizedBox(height: 20),
                  ApiPhotoViewer(
                    controller: camNoteController,
                    imageKey: "residence_photo",
                    imageUrls: data.photosOfResidence?.split(",")
                        .map((path) => "${BaseUrl.imageBaseUrl}$path")
                        .toList() ?? [],
                    label: "Photos Of Residence",
                    isCloseVisible: false,
                  ),
                  SizedBox(height: 20),
                  ApiPhotoViewer(
                    controller: camNoteController,
                    imageKey: "office_photo",
                    imageUrls: data.photosOfOffice?.split(",")
                        .map((path) => "${BaseUrl.imageBaseUrl}$path")
                        .toList() ?? [],
                    label: "Photos Of Office",
                    isCloseVisible: false,
                  ),
                ],
              ),


            ],
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





