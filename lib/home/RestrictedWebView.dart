import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../common/helper.dart';

class RestrictedWebView extends StatelessWidget {
  final String url;
  final String title;

  const RestrictedWebView({Key? key, required this.title, required this.url}) : super(key: key);

  bool _isPdfUrl(String url) {
    return url.toLowerCase().endsWith('.pdf');
  }

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isLoading = ValueNotifier(true);

    final String initialUrl = _isPdfUrl(url)
        ? 'https://docs.google.com/gview?embedded=true&url=${Uri.encodeFull(url)}'
        : url;

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Stack(
        children: [
          // Gradient Background
          Container(
            height: MediaQuery.of(context).size.height * 0.9,
            decoration:  BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColor.primaryLight, AppColor.primaryDark],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 5),
            child:Column(
              children: [
                 SizedBox(
                  height: 30,
                ),
                header(context,title),
              ],
            ),
          ),
          // White Container
          Align(
            alignment: Alignment.topCenter,  // Centers it
            child: Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Container(
                margin:  EdgeInsets.only(
                    top:90 // MediaQuery.of(context).size.height * 0.22
                ), // <-- Moves it 30px from top
                width: double.infinity,
                height: MediaQuery.of(context).size.height/1.2,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: const BoxDecoration(
                  color: AppColor.backgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  ),

                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min, // Prevents extra spacing
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.9,
                        child: InAppWebView(
                          initialUrlRequest: URLRequest(url: Uri.parse(initialUrl)),
                          onWebViewCreated: (controller) {},
                          onLoadStart: (controller, url) {
                            isLoading.value = true;
                          },
                          onLoadStop: (controller, url) async {
                            isLoading.value = false;
                          },
                          onLoadError: (controller, url, code, message) {
                            isLoading.value = false;
                            Get.snackbar("Error", "Failed to load page.");
                          },
                          shouldOverrideUrlLoading: (controller, action) async {
                            final requestedUrl = action.request.url.toString();
                            if (requestedUrl.endsWith(".pdf") && !requestedUrl.contains("docs.google.com")) {
                              Get.snackbar("Blocked", "PDF downloads are not allowed.");
                              return NavigationActionPolicy.CANCEL;
                            }
                            return NavigationActionPolicy.ALLOW;
                          },
                          onDownloadStartRequest: (controller, request) {
                            Get.snackbar("Download Blocked", "Downloads are not allowed.");
                          },
                          androidOnPermissionRequest: (controller, origin, resources) async {
                            return PermissionRequestResponse(
                              resources: resources,
                              action: PermissionRequestResponseAction.DENY,
                            );
                          },
                        ),
                      ),
                      // Loader
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: ValueListenableBuilder<bool>(
              valueListenable: isLoading,
              builder: (context, value, child) {
                return value
                    ? const Center(child: CircularProgressIndicator())
                    : const SizedBox.shrink();
              },
            ),
          ),


        ],
      ),
    );
  }

  Widget header(context, String title){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(8), // for ripple effect
            onTap: () {
              Get.back();
            },
            child: Container(
              width: 48,
              height: 48,
              padding: const EdgeInsets.all(12), // optional internal padding
              alignment: Alignment.center,
              child: Image.asset(
                AppImage.arrowLeft,
                height: 24,
              ),
            ),
          ),

           Text(
            title??'',
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
              child: Center(child: Icon(Icons.filter_alt_outlined, color: Colors.transparent,),),
            ),
          )

        ],
      ),
    );
  }
}
