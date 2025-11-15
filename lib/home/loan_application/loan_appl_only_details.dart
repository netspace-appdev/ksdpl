
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ksdpl/common/base_url.dart';
import 'package:ksdpl/controllers/camnote/camnote_controller.dart';
import 'package:ksdpl/controllers/leads/loan_appl_controller.dart';
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
import '../camnote/camnot_photo_view.dart';
import '../custom_drawer.dart';




class LoanApplicationOnlyDetailsScreen extends StatelessWidget {
  final CamNoteController camNoteController=Get.find();
  final LoanApplicationController loanApplicationController=Get.find();

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
                          LoanApplDetailSingleSection(context)
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
            AppText.loanApplicationDetails,
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

  Widget LoanApplDetailSingleSection(BuildContext context) {
    return Obx(() {
      if (loanApplicationController.isLoadingOnlyDetails.value || loanApplicationController.isLoadingOnlyDetails.value) {
        return Center(child: CustomSkelton.productShimmerList(context));
      }

      final data = loanApplicationController.loanApplicationDetailsOnlyModel.value?.data;

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
      final coApplicants = loanApplicationController.loanApplicationDetailsOnlyModel.value?.data?.coApplicants ?? [];
      final propertyDetails = loanApplicationController.loanApplicationDetailsOnlyModel.value?.data?.loanDetails;
      final financialDetails = loanApplicationController.loanApplicationDetailsOnlyModel.value?.data?.financialDetails;


      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Personal Info
          buildCard(AppText.personInformation, [
            DetailRow(label: AppText.bankName, value:""),
            DetailRow(label: AppText.branchName, value:""),
            DetailRow(label: AppText.bankerName, value:Helper.safeValueForField(data.bankerName)),
            DetailRow(label: AppText.bankerMobile, value:Helper.safeValueForField(data.bankerMobile)),
            DetailRow(label: AppText.bankerEmail, value:Helper.safeValueForField(data.bankerEmail)),
            DetailRow(label: AppText.loanApplicationNo, value:Helper.safeValueForField(data.loanApplicationNo)),
            DetailRow(label: AppText.aadharCardNo, value:Helper.safeValueForField(data.addharCardNumber)),
            DetailRow(label: AppText.panCardNo, value:Helper.safeValueForField(data.panCardNumber)),
            DetailRow(label: AppText.uniqueLeadNumber, value:Helper.safeValueForField(data.uniqueLeadNumber)),
            DetailRow(label: AppText.dsaCode, value:Helper.safeValueForField(data.dsaCode)),
            DetailRow(label: AppText.dsaStaffName, value:""),
            DetailRow(label: AppText.chqDdSlipNo, value:""),



          ],
              Icons.info_outline

          ),


          ///Applicant Details
          buildCard(AppText.applicantDetails, [
            DetailRow(label: AppText.name, value: Helper.safeValueForField(data.detailForLoanApplication?.applicant?.name)),
            DetailRow(label: AppText.fathersName, value: Helper.safeValueForField(data.detailForLoanApplication?.applicant?.fatherName)),
            DetailRow(label: AppText.gender, value: Helper.safeValueForField(data.detailForLoanApplication?.applicant?.gender)),
            DetailRow(label: AppText.dateOfBirth2, value: Helper.formatDateTimeLoan(data.detailForLoanApplication?.applicant?.dateOfBirth)),
            DetailRow(label: AppText.qualification, value: Helper.safeValueForField(data.detailForLoanApplication?.applicant?.qualification)),
            DetailRow(label: AppText.maritalStatus, value: Helper.safeValueForField(data.detailForLoanApplication?.applicant?.maritalStatus)),
            DetailRow(label: AppText.status, value: Helper.safeValueForField(data.detailForLoanApplication?.applicant?.status)),
            DetailRow(label: AppText.nationality, value: Helper.safeValueForField(data.detailForLoanApplication?.applicant?.nationality)),
            DetailRow(label: AppText.occupation, value: Helper.safeValueForField(data.detailForLoanApplication?.applicant?.occupation)),
            DetailRow(label: AppText.occupationSector, value: Helper.safeValueForField(data.detailForLoanApplication?.applicant?.occupationSector)),
            DetailRow(label: AppText.emailNoStar, value: Helper.safeValueForField(data.detailForLoanApplication?.applicant?.email)),
            DetailRow(label: AppText.mobileNumber, value: Helper.safeValueForField(data.detailForLoanApplication?.applicant?.mobile)),
            DetailRow(label: AppText.employerName, value:Helper.safeValueForField(data.detailForLoanApplication?.applicant?.employerDetails?.organizationName)),
            DetailRow(label: AppText.employerType, value: Helper.safeValueForField(data.detailForLoanApplication?.applicant?.employerDetails?.ownershipType)),
            DetailRow(label: AppText.natureOfBusiness, value: Helper.safeValueForField(data.detailForLoanApplication?.applicant?.employerDetails?.natureOfBusiness)),
            DetailRow(label: AppText.staffStrength, value: Helper.safeValueForInt(data.detailForLoanApplication?.applicant?.employerDetails?.staffStrength)),
            DetailRow(label: AppText.dateOfSal, value: Helper.formatDateTimeLoan(data.detailForLoanApplication?.applicant?.employerDetails?.dateOfSalary)),
            DetailRow(label: AppText.presentAdd, value: ""),
            DetailRow(label: AppText.permanentAdd, value: ""),

          ],
              Icons.info_outline

          ),
          /// Co Applicant
          buildCard(AppText.coApplDetails, [

            ListView.builder(
              itemCount: coApplicants.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final co = coApplicants[index];


                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Co Applicant -${index+1}"),
                    SizedBox(height: 10,),
                    DetailRow(label: AppText.name, value: Helper.safeValueForField(co.name)),
                    DetailRow(label: AppText.fathersName, value: Helper.safeValueForField(co.fatherName)),
                    DetailRow(label: AppText.gender, value: Helper.safeValueForField(co.gender)),
                    DetailRow(label: AppText.dateOfBirth, value: Helper.formatDateTimeLoan(co.dateOfBirth)),
                    DetailRow(label: AppText.qualification, value: Helper.safeValueForField(co.qualification)),
                    DetailRow(label: AppText.maritalStatus, value: Helper.safeValueForField(co.maritalStatus)),
                    DetailRow(label: AppText.status, value: Helper.safeValueForField(co.status)),
                    DetailRow(label: AppText.nationality, value: Helper.safeValueForField(co.nationality)),
                    DetailRow(label: AppText.occupation, value: Helper.safeValueForField(co.occupation)),
                    DetailRow(label: AppText.occupationSector, value: Helper.safeValueForField(co.occupationSector)),
                    DetailRow(label: AppText.emailNoStar, value: Helper.safeValueForField(co.email)),
                    DetailRow(label: AppText.mobileNumber, value: Helper.safeValueForField(co.mobile)),
                    DetailRow(label: AppText.employerName, value: Helper.safeValueForField(co.employerDetails?.organizationName)),
                    DetailRow(label: AppText.natureOfBusiness, value: Helper.safeValueForField(co.employerDetails?.natureOfBusiness)),
                    DetailRow(label: AppText.staffStrength, value: Helper.safeValueForInt(co.employerDetails?.staffStrength)),
                    DetailRow(label: AppText.dateOfSal, value: Helper.formatDateTimeLoan(co.employerDetails?.dateOfSalary)),
                    DetailRow(label: AppText.presentAdd, value: ""),
                    DetailRow(label: AppText.permanentAdd, value: ""),
                  ],
                );

              },
            )

          ],
              Icons.money_rounded

          ),

          ///Property

          buildCard(AppText.propertyDetails, [

            DetailRow(label: AppText.propertyId, value: Helper.safeValueForField(propertyDetails?.propertyId)),
            DetailRow(label: AppText.surveyNo, value: Helper.safeValueForField(propertyDetails?.surveyNo)),
            DetailRow(label: AppText.blockNo, value: Helper.safeValueForField(propertyDetails?.blockNo)),
            DetailRow(label: AppText.houseFlatNo, value: Helper.safeValueForField(propertyDetails?.flatHouseNo)),
            DetailRow(label: AppText.societyName, value: Helper.safeValueForField(propertyDetails?.societyBuildingName)),
            DetailRow(label: AppText.streetName, value: Helper.safeValueForField(propertyDetails?.streetName)),
            DetailRow(label: AppText.locality, value: Helper.safeValueForField(propertyDetails?.locality)),
            DetailRow(label: AppText.pinCode, value: Helper.safeValueForField(propertyDetails?.pincode)),
            DetailRow(label: AppText.state, value: Helper.safeValueForField(propertyDetails?.state)),
            DetailRow(label: AppText.district, value: Helper.safeValueForField(propertyDetails?.district)),
            DetailRow(label: AppText.city, value: Helper.safeValueForField(propertyDetails?.city)),
            DetailRow(label: AppText.taluka, value: Helper.safeValueForField(propertyDetails?.taluka)),


          ],
              Icons.money_rounded

          ),
          buildCard(AppText.financialDetails, [

            DetailRow(label: AppText.grossMonthlySalary, value: Helper.safeValueForNum(financialDetails?.grossMonthlySalary)),




          ],
              Icons.money_rounded

          ),

      /*    buildCard("Sanction Details", [

            DetailRow(label: AppText.softSanctionStatus, value: data.softsanction==0?"Pending":
            data.softsanction==1?"Approved":
            data.softsanction==2?"Hold":
            data.softsanction==-1?"Rejected":
            ""),
            DetailRow(label: AppText.sanctionAmount, value: data.loanApplicationNo.toString()),


          ],
              Icons.security

          ),*/

        /*  buildCard("Document Details", [
            DetailRow(label: AppText.documents, value: data.documents==null?"No documents" : Helper.formatStringToSerialNumbers(data.documents.toString())),

          ],
              Icons.document_scanner

          ),*/

         /* ExpansionTile(
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
          ),*/


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





