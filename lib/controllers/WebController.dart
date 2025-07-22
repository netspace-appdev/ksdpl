/*
import 'package:get/get.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../common/base_url.dart';

class WebController extends GetxController {
  late InAppWebViewController webViewController;

  final String englishUrl = BaseUrl.imageBaseUrl+"PPT/KSDPL+The+Best+Loan%2C+Without+Any+Guesswork.pdf";
  // final String hindiUrl =   BaseUrl.imageBaseUrl+"PPT/KSDPL+The+Best+Loan%2C+Without+Any+Guesswork+in+hindi.pdf";
  final String hindiUrl =   "https://ksdpl-uploads.s3.ap-south-1.amazonaws.com/PPT/KSDPL+The+Best+Loan%2C+Without+Any+Guesswork+in+hindi.pdf";

  void onDownloadAttempt(DownloadStartRequest request) {
    print("Blocked download from: ${request.url}");
    Get.snackbar("Download Blocked", "Downloads are not allowed.");
  }
}
*/

///new code
import 'package:get/get.dart';
import '../common/base_url.dart';

class WebController extends GetxController {
  // final String englishUrl = BaseUrl.imageBaseUrl + "PPT/KSDPL+The+Best+Loan%2C+Without+Any+Guesswork.pdf";
  final String englishUrl = "https://ksdpl-uploads.s3.ap-south-1.amazonaws.com/PPT/KSDPL+The+Best+Loan%2C+Without+Any+Guesswork.pdf";

  final String hindiUrl =
      "https://ksdpl-uploads.s3.ap-south-1.amazonaws.com/PPT/KSDPL+The+Best+Loan%2C+Without+Any+Guesswork+in+hindi.pdf";

  void onBlockedDownloadAttempt(String url) {
    print("Blocked download from: $url");
    Get.snackbar("Download Blocked", "Downloads are not allowed.");
  }
}
