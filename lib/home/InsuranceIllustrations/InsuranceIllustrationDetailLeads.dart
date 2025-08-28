import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/helper.dart';

class InsuranceIllustrationdetailLeads extends StatelessWidget {
  const InsuranceIllustrationdetailLeads({super.key});

  @override
  Widget build(BuildContext context) {
    // Receive the Data model (one insurance lead item)
   final args = Get.arguments ;
 //   final args = Get.arguments as GetAllInsuranceIllustrationsModel;

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
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColor.primaryLight, AppColor.primaryDark],
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        header(context),
                      ],
                    ),
                  ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(

              margin: const EdgeInsets.only(top: 90),
              width: double.infinity,
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
                children: [
                  const SizedBox(height: 20),
                  // Build sections using model data
                  buildCard("Illustration Detail", [
                    DetailRow(label: "ID", value: "${args.id ?? "-"}"),
                    DetailRow(label: "Policy Holder", value: args.policyHolderName ?? "-"),
                    DetailRow(label: "Age", value: args.age ?? "-"),
                    DetailRow(label: "Gender", value: args.gender ?? "-"),
                    DetailRow(label: "Proposal No", value: args.proposalNo ?? "-"),
                    DetailRow(label: "Product", value: args.nameOfTheProduct ?? "-"),
                    DetailRow(label: "Tagline", value: args.tagLine ?? "-"),
                    DetailRow(label: "Policy Term", value: args.policyTerm ?? "-"),
                    DetailRow(label: "Premium Term", value: args.premiumPaymentTerm ?? "-"),
                    DetailRow(label: "Payment Mode", value: args.premiumPaymentMode ?? "-"),
                    DetailRow(label: "Installment Premium", value: "${args.amntOfInstallmentPremium ?? 0}"),
                    DetailRow(label: "GST Rate", value: "${args.gstrate ?? 0}%"),
                    DetailRow(label: "Total Premium", value: "${args.totalInstallmentPremium ?? 0}"),
                    DetailRow(label: "Sum Assured", value: "${args.sumAssured ?? 0}"),
                    DetailRow(label: "Sum Assured on Death", value: "${args.sumAssuredOnDeath ?? 0}"),
                    DetailRow(label: "Base Plan (With GST)", value: "${args.basePlanWithGst ?? 0}"),
                    DetailRow(label: "Base Plan (Without GST)", value: "${args.basePlanWithoutGst ?? 0}"),
                    DetailRow(label: "Rider (With GST)", value: "${args.riderWithGst ?? 0}"),
                    DetailRow(label: "Rider (Without GST)", value: "${args.riderWithoutGst ?? 0}"),
                    DetailRow(label: "Unique ID", value: args.uniqueIdentificationNo ?? "-"),
                    DetailRow(label: "Unique Lead No", value: args.uniqueLeadNumber ?? "-"),
                    DetailRow(label: "Residential State", value: args.policyHolderResidentialState ?? "-"),
                    DetailRow(label: "Max Life State", value: args.maxLifeState ?? "-"),
                  ], Icons.info_outline),


                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
                  // White Container
            /*      Container(
                    height: MediaQuery.of(context).size.height/1,
                    child: ListView.builder(
                      itemCount: args.length??0,
                      itemBuilder: (BuildContext context, int index) {
                        final item = args.data?[index];
                        return
                      },

                    ),
                  ),*/
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: () => Get.back(),
              child: Image.asset(AppImage.arrowLeft, height: 24)),
          const Text(
            "Illustration Details",
            style: TextStyle(
              fontSize: 20,
              color: AppColor.grey3,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 40), // keeps spacing balance
        ],
      ),
    );
  }

  Widget buildCard(String title, List<Widget> children, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        border: Border.all(color: AppColor.grey4, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: const BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white),
                const SizedBox(width: 5),
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
          // Content
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 3,
              child: Text(label,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: AppColor.grey700))),
          Expanded(
              flex: 2,
              child: Text(value,
                  textAlign: TextAlign.right,
                  style: const TextStyle(color: AppColor.grey2))),
        ],
      ),
    );
  }
}
