import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common/helper.dart';
import '../common/skelton.dart';
import '../controllers/payoutController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common/helper.dart';
import '../common/skelton.dart';
import '../controllers/payoutController.dart';

class InterestedLeadsPayoutPage extends StatelessWidget {
  PayoutController payoutController = Get.find();

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
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColor.primaryLight, AppColor.primaryDark],
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        header(context),
                      ],
                    ),
                  ),

                  // White Container
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
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Obx(() {
                            if (payoutController.isLoadingMainScreen.value) {
                              return Center(
                                child: CustomSkelton.productShimmerList(context),
                              );
                            }

                            final data = payoutController.interestedPayoutModel.value?.data;

                            if (data == null || data.isEmpty) {
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

                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final data1 = data[index];

                                // Generate Receipt URL
                                final invoiceUrl = 'https://devsales.kanchaneshver.com/#/invoice/${data1.leadId}/${data1.packageId}/${data1.id}';
                                final receiptUrl = 'https://devsales.kanchaneshver.com/#/receipt-preview/${data1.leadId}/${data1.packageId}/${data1.id}';
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    buildCard("${index + 1}", [
                                      DetailRow(
                                        label: AppText.packageName,
                                        value: data1.packageName?.toString() ?? '',
                                      ),
                                      DetailRow(
                                        label: AppText.packageAmount,
                                        value: data1.amount?.toString() ?? '',
                                      ),
                                      DetailRow(
                                        label: AppText.paymentStatus,
                                        value: data1.txnStatus?.toString() ?? '',
                                        valueColor: _getStatusColor(data1.txnStatus),
                                      ),
                                      DetailRow(
                                        label: AppText.ReceiptPdf,
                                        value: (data1.id != null && data1.leadId != null && data1.packageId != null)
                                            ? 'View Invoice'
                                            : 'Invoice Not Generated',
                                        valueColor: (data1.id != null && data1.leadId != null && data1.packageId != null)
                                            ? AppColor.primaryColor
                                            : Colors.black,
                                        onTap: (data1.id != null && data1.leadId != null && data1.packageId != null)
                                            ?() => _openUrl(receiptUrl) : null

                                      ),
                                      DetailRow(
                                        label: AppText.invoicePdf,
                                        value: (data1.id != null && data1.leadId != null && data1.packageId != null)
                                            ? 'View Receipt'
                                            : 'Receipt Not Generated',
                                        valueColor: (data1.id != null && data1.leadId != null && data1.packageId != null)
                                            ? AppColor.primaryColor
                                            : Colors.black,
                                        onTap: (data1.id != null && data1.leadId != null && data1.packageId != null)
                                            ? () => _openUrl(invoiceUrl)
                                            : null,
                                      ),
                                    ], Icons.info_outline),
                                    const SizedBox(height: 20),
                                  ],
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

  Color _getStatusColor(String? status) {
    switch (status?.toUpperCase()) {
      case 'ACCEPT':
      case 'SUCCESS':
        return AppColor.greenColor;
      case 'REFUND_FAILED':
        return AppColor.redColor;
      default:
        return Colors.black;
    }
  }

  Widget header(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => Get.back(),
            child: Image.asset(AppImage.arrowLeft, height: 24),
          ),
          const Text(
            AppText.Payout,
            style: TextStyle(
              fontSize: 20,
              color: AppColor.grey3,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox()
        ],
      ),
    );
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
      margin: const EdgeInsets.only(bottom: 20),
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
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openUrl(String url) async {
    print('url__${url}');
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      Get.snackbar(
        'Error',
        'Could not open link',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}

class DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final VoidCallback? onTap;

  const DetailRow({
    Key? key,
    required this.label,
    required this.value,
    this.valueColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool showDash = value == "null" || value == AppText.customdash || value.isEmpty;

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
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppColor.primaryColor,
            ),
          ),
          const SizedBox(height: 4),
          showDash
              ? const Icon(Icons.horizontal_rule, size: 15)
              : InkWell(
            onTap: onTap,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: valueColor ?? Colors.black,
                decoration: onTap != null ? TextDecoration.underline : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
