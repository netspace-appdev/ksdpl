
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
import 'package:lottie/lottie.dart';
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
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
              
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Image.asset(AppImage.noDataFound,),
                    const Text(
                        "No data found",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColor.grey700
                        ))
                  ],
                ),
              ));
      }
      final coApplicants = loanApplicationController.loanApplicationDetailsOnlyModel.value?.data?.coApplicants ?? [];
      final propertyDetails = loanApplicationController.loanApplicationDetailsOnlyModel.value?.data?.loanDetails;
      final financialDetails = loanApplicationController.loanApplicationDetailsOnlyModel.value?.data?.financialDetails;
      final familyMembers = loanApplicationController.loanApplicationDetailsOnlyModel.value?.data?.familyMembers ?? [];
      final referenceDetails = loanApplicationController.loanApplicationDetailsOnlyModel.value?.data?.referenceDetails ?? [];
      final creditCards = loanApplicationController.loanApplicationDetailsOnlyModel.value?.data?.creditCards ?? [];
      final chargesDetails = loanApplicationController.loanApplicationDetailsOnlyModel.value?.data?.chargesDetails;
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
            DetailRow(label: AppText.dsaStaffName, value:Helper.safeValueForField(data.detailForLoanApplication?.dsaStaffName)),
            DetailRow(label: AppText.chqDdSlipNo, value:Helper.safeValueForField(data.detailForLoanApplication?.chqDdSlipNo)),
            DetailRow(label: AppText.channel, value:Helper.safeValueForInt(data.channelId)),
            DetailRow(label: AppText.channelCode, value:Helper.safeValueForField(data.channelCode)),
            DetailRow(label: AppText.processingFee2, value:Helper.safeValueForNum(data.detailForLoanApplication?.processingFee)),
            DetailRow(label: AppText.processingFeeDate, value:Helper.formatDateTimeLoan(data.detailForLoanApplication?.processingFeeDate)),
            DetailRow(label: AppText.loanPurpose, value:Helper.safeValueForField(data.detailForLoanApplication?.loanPurpose)),
            DetailRow(label: AppText.scheme, value:Helper.safeValueForField(data.detailForLoanApplication?.scheme)),
            DetailRow(label: AppText.repaymentType, value:Helper.safeValueForField(data.detailForLoanApplication?.repaymentType)),
            DetailRow(label: AppText.loanType, value:Helper.safeValueForField(data.detailForLoanApplication?.typeOfLoan)),
            DetailRow(label: AppText.loanAmountApplied, value:Helper.safeValueForNum(data.detailForLoanApplication?.loanAmountApplied)),
            DetailRow(label: AppText.loanTenure, value:Helper.safeValueForNum(data.detailForLoanApplication?.loanTenureYears)),
            DetailRow(label: AppText.monthlyInstallment, value:Helper.safeValueForNum(data.detailForLoanApplication?.monthlyInstallment)),
            DetailRow(label: AppText.previousLoanApplied, value:Helper.safeValueForBoolYesNo(data.detailForLoanApplication?.previousLoanApplied)),




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
            DetailRow(label: AppText.presentAdd, value:Helper.formatAddressLoan(
              houseFlatNo: data.detailForLoanApplication?.applicant?.presentAddress?.houseFlatNo,
              buildingNo: data.detailForLoanApplication?.applicant?.presentAddress?.buildingNo,
              societyName: data.detailForLoanApplication?.applicant?.presentAddress?.societyName,
              locality: data.detailForLoanApplication?.applicant?.presentAddress?.locality,
              streetName: data.detailForLoanApplication?.applicant?.presentAddress?.streetName,
              city: data.detailForLoanApplication?.applicant?.presentAddress?.city,
              taluka: data.detailForLoanApplication?.applicant?.presentAddress?.taluka,
              district: data.detailForLoanApplication?.applicant?.presentAddress?.district,
              state: data.detailForLoanApplication?.applicant?.presentAddress?.state,
              country: data.detailForLoanApplication?.applicant?.presentAddress?.country,
              pinCode: data.detailForLoanApplication?.applicant?.presentAddress?.pinCode,
            ),),
            DetailRow(label: AppText.permanentAdd, value:Helper.formatAddressLoan(
              houseFlatNo: data.detailForLoanApplication?.applicant?.permanentAddress?.houseFlatNo,
              buildingNo: data.detailForLoanApplication?.applicant?.permanentAddress?.buildingNo,
              societyName: data.detailForLoanApplication?.applicant?.permanentAddress?.societyName,
              locality: data.detailForLoanApplication?.applicant?.permanentAddress?.locality,
              streetName: data.detailForLoanApplication?.applicant?.permanentAddress?.streetName,
              city: data.detailForLoanApplication?.applicant?.permanentAddress?.city,
              taluka: data.detailForLoanApplication?.applicant?.permanentAddress?.taluka,
              district: data.detailForLoanApplication?.applicant?.permanentAddress?.district,
              state: data.detailForLoanApplication?.applicant?.permanentAddress?.state,
              country: data.detailForLoanApplication?.applicant?.permanentAddress?.country,
              pinCode: data.detailForLoanApplication?.applicant?.permanentAddress?.pinCode,
            ),),

            DetailRow(label: AppText.officeAdd, value:Helper.formatAddressLoan(
              houseFlatNo: data.detailForLoanApplication?.applicant?.officeAddress?.houseFlatNo,
              buildingNo: data.detailForLoanApplication?.applicant?.permanentAddress?.buildingNo,
              societyName: data.detailForLoanApplication?.applicant?.permanentAddress?.societyName,
              locality: data.detailForLoanApplication?.applicant?.permanentAddress?.locality,
              streetName: data.detailForLoanApplication?.applicant?.permanentAddress?.streetName,
              city: data.detailForLoanApplication?.applicant?.permanentAddress?.city,
              taluka: data.detailForLoanApplication?.applicant?.permanentAddress?.taluka,
              district: data.detailForLoanApplication?.applicant?.permanentAddress?.district,
              state: data.detailForLoanApplication?.applicant?.permanentAddress?.state,
              country: data.detailForLoanApplication?.applicant?.permanentAddress?.country,
              pinCode: data.detailForLoanApplication?.applicant?.permanentAddress?.pinCode,
            ),),

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
                    DetailRow(label: AppText.presentAdd, value: Helper.formatAddressLoan(
                      houseFlatNo: co.presentAddress?.houseFlatNo,
                      buildingNo: co.presentAddress?.buildingNo,
                      societyName: co.presentAddress?.societyName,
                      locality: co.presentAddress?.locality,
                      streetName: co.presentAddress?.streetName,
                      city: co.presentAddress?.city,
                      taluka: co.presentAddress?.taluka,
                      district: co.presentAddress?.district,
                      state: co.presentAddress?.state,
                      country: co.presentAddress?.country,
                      pinCode: co.presentAddress?.pinCode,
                    ),),
                    DetailRow(label: AppText.permanentAdd, value: Helper.formatAddressLoan(
                      houseFlatNo: co.permanentAddress?.houseFlatNo,
                      buildingNo: co.permanentAddress?.buildingNo,
                      societyName: co.permanentAddress?.societyName,
                      locality: co.permanentAddress?.locality,
                      streetName: co.permanentAddress?.streetName,
                      city: co.permanentAddress?.city,
                      taluka: co.permanentAddress?.taluka,
                      district: co.permanentAddress?.district,
                      state: co.permanentAddress?.state,
                      country: co.permanentAddress?.country,
                      pinCode: co.permanentAddress?.pinCode,
                    ),),
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
            DetailRow(label: AppText.netMonthlySalary, value: Helper.safeValueForNum(financialDetails?.netMonthlySalary)),
            DetailRow(label: AppText.annualBonus, value: Helper.safeValueForNum(financialDetails?.annualBonus)),
            DetailRow(label: AppText.avgMonOvertime, value: Helper.safeValueForNum(financialDetails?.avgMonthlyOvertime)),
            DetailRow(label: AppText.avgMonCommission, value: Helper.safeValueForNum(financialDetails?.avgMonthlyCommission)),
            DetailRow(label: AppText.monthlyPfDeduction, value: Helper.safeValueForNum(financialDetails?.monthlyPFDeduction)),
            DetailRow(label: AppText.otherMonthlyIncome, value: Helper.safeValueForNum(financialDetails?.otherMonthlyIncome)),

          ],
              Icons.money_rounded

          ),

          ///family

          buildCard(AppText.familyMember, [

            ListView.builder(
              itemCount: familyMembers.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final fm = familyMembers[index];


                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${AppText.familyMember} -${index+1}"),
                    SizedBox(height: 10,),
                    DetailRow(label: AppText.name, value: Helper.safeValueForField(fm.name)),
                    DetailRow(label: AppText.dateOfBirth, value: Helper.formatDateTimeLoan(fm.birthDate)),
                    DetailRow(label: AppText.gender, value: Helper.safeValueForField(fm.gender)),
                    DetailRow(label: AppText.relWithAppl, value: Helper.safeValueForField(fm.relationWithApplicant)),
                    DetailRow(label: AppText.dependent, value: Helper.safeValueForBoolYesNo(fm.dependent)),
                    DetailRow(label: AppText.monthlyIncome, value: Helper.safeValueForNum(fm.monthlyIncome)),
                    DetailRow(label: AppText.EmployedWith, value: Helper.safeValueForField(fm.employedWith)),

                  ],
                );

              },
            )

          ],
              Icons.money_rounded

          ),

          ///refeence

          buildCard(AppText.references, [

            ListView.builder(
              itemCount: referenceDetails.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final rf = referenceDetails[index];


                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${AppText.references} -${index+1}"),
                    SizedBox(height: 10,),
                    DetailRow(label: AppText.name, value: Helper.safeValueForField(rf.name)),
                    DetailRow(label: AppText.address, value: Helper.safeValueForField(rf.address)),
                    DetailRow(label: AppText.phoneNo, value: Helper.safeValueForField(rf.phone)),
                    DetailRow(label: AppText.mobileNumber, value: Helper.safeValueForField(rf.mobile)),
                    DetailRow(label: AppText.relWithAppl, value: Helper.safeValueForField(rf.relationWithApplicant)),
                    DetailRow(label: AppText.city, value: Helper.safeValueForField(rf.city)),
                    DetailRow(label: AppText.state, value: Helper.safeValueForField(rf.state)),
                    DetailRow(label: AppText.district, value: Helper.safeValueForField(rf.district)),
                    DetailRow(label: AppText.pinCode, value: Helper.safeValueForField(rf.pinCode)),


                  ],
                );

              },
            )

          ],
              Icons.money_rounded

          ),

          ///credit

          buildCard(AppText.creditCard, [

            ListView.builder(
              itemCount: creditCards.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final cc = creditCards[index];


                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${AppText.creditCard} -${index+1}"),
                    SizedBox(height: 10,),
                    DetailRow(label: AppText.companyBank, value: Helper.safeValueForField(cc.companyBank)),
                    DetailRow(label: AppText.cardNumber, value: Helper.safeValueForField(cc.cardNumber)),
                    DetailRow(label: AppText.havingSince, value: Helper.formatDateTimeLoan(cc.havingSince)),
                    DetailRow(label: AppText.avgMonSpencing, value: Helper.safeValueForNum(cc.avgMonthlySpending)),



                  ],
                );

              },
            )

          ],
              Icons.money_rounded

          ),

          ///Charge Details


          buildCard(AppText.chargeDetails, [

            DetailRow(label: AppText.processingFeeAgainstLoan, value: Helper.safeValueForNum(chargesDetails?.processingFees)),
            DetailRow(label: AppText.adminFeeAgainstLoan, value: Helper.safeValueForNum(chargesDetails?.adminFeeCharges)),
            DetailRow(label: AppText.foreclosureChargesPO, value: Helper.safeValueForNum(chargesDetails?.foreclosureChargesCharges)),
            DetailRow(label: AppText.stampDutyAgainstLoan, value: Helper.safeValueForNum(chargesDetails?.stampDutyPercentage)),
            DetailRow(label: AppText.legalVettingCharges, value: Helper.safeValueForNum(chargesDetails?.legalVettingCharges)),
            DetailRow(label: AppText.technicalInspectionFee, value: Helper.safeValueForNum(chargesDetails?.technicalInspectionCharges)),
            DetailRow(label: AppText.otherCharges, value: Helper.safeValueForNum(chargesDetails?.otherCharges)),
            DetailRow(label: AppText.tsrCharges, value: Helper.safeValueForNum(chargesDetails?.tsrLegalCharges)),
            DetailRow(label: AppText.valuationCharges, value: Helper.safeValueForNum(chargesDetails?.valuationCharges)),
            DetailRow(label: AppText.processingCharges2, value: Helper.safeValueForNum(chargesDetails?.processingCharges)),


          ],
              Icons.money_rounded

          ),

          Obx(() {
            final data = loanApplicationController.loanApplicationDocumentByLoanIdModel.value?.data ?? [];

            if (loanApplicationController.isloadData.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (data.isEmpty) {
              return Column(
                children: [
                  const SizedBox(height: 10),
                  SizedBox(height: 200, width: 150, child: Lottie.asset(AppImage.nodataCofee)),
                  const Center(child: Text("No documents uploaded yet.")),
                  const SizedBox(height: 10),
                ],
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: [
                      Icon(Icons.list_alt, size: 20),
                      SizedBox(width: 20),
                      Text(
                        AppText.documents,
                        style: TextStyle(
                          color: AppColor.blackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final item = data[index];
                    final imageName = item.imageName ?? '';
                    final imagePathRaw = item.imagePath ?? '';
                    final List<String> images = imagePathRaw.split(',').where((e) => e.trim().isNotEmpty).toList();
                    print("imagePathRaw--->${imagePathRaw}");

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: AppColor.appWhite,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: AppColor.primaryColor,
                            width: 0.5,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: AppColor.primaryColor,
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    imageName,
                                    style: const TextStyle(fontWeight: FontWeight.bold, color: AppColor.grey3),
                                  ),

                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 100,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: images.length,
                                separatorBuilder: (_, __) => const SizedBox(width: 10),
                                itemBuilder: (context, imgIndex) {

                                  final imageUrl = '${BaseUrl.imageBaseUrl}${images[imgIndex]}';

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        imageUrl,
                                        // width: MediaQuery.of(context).size.width * 0.25,
                                        //height: MediaQuery.of(context).size.height * 0.12,
                                        fit: BoxFit.fill,
                                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) return child;
                                          return Center(
                                            child: SizedBox(
                                              //     width: MediaQuery.of(context).size.width * 0.25,
                                              //  height: MediaQuery.of(context).size.height * 0.12,
                                              child: Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2.5,
                                                  value: loadingProgress.expectedTotalBytes != null
                                                      ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                                      : null,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        errorBuilder: (_, __, ___) => Image.asset(
                                          AppImage.noImage,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),

                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          }),

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





