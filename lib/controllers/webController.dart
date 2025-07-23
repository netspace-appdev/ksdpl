import 'package:get/get.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../common/base_url.dart';

class WebController extends GetxController {
  RxBool isCustomerExpanded = false.obs;

  late InAppWebViewController webViewController;

  final String hindiUrl =   BaseUrl.imageBaseUrl+"PPT/KSDPL+The+Best+Loan%2C+Without+Any+Guesswork+in+hindi.pdf";
  final String englishUrl = BaseUrl.imageBaseUrl+"PPT/KSDPL+The+Best+Loan%2C+Without+Any+Guesswork.pdf";
  final String tutorial_video_Url = BaseUrl.tutorialVideoBaseUrl+"PPT/Banker+CAM+note+Process+Update.mp4";


  void onDownloadAttempt(DownloadStartRequest request) {


    print("Blocked download from: ${request.url}");
    Get.snackbar("Download Blocked", "Downloads are not allowed.");
  }



}
