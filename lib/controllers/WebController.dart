import 'package:get/get.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebController extends GetxController {
  late InAppWebViewController webViewController;

  final String englishUrl = "https://devksdpl-uploads.s3.ap-south-1.amazonaws.com/PPT/KSDPL+The+Best+Loan%2C+Without+Any+Guesswork.pdf";
  final String hindiUrl =   "https://devksdpl-uploads.s3.ap-south-1.amazonaws.com/PPT/KSDPL+The+Best+Loan%2C+Without+Any+Guesswork+in+hindi.pdf";

  void onDownloadAttempt(DownloadStartRequest request) {
    print("Blocked download from: ${request.url}");
    Get.snackbar("Download Blocked", "Downloads are not allowed.");
  }
}
