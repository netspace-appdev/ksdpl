import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../common/helper.dart';

class RestrictedWebView extends StatefulWidget {
  final String url;
  final String title;

  const RestrictedWebView({Key? key, required this.url, required this.title}) : super(key: key);

  @override
  State<RestrictedWebView> createState() => _RestrictedWebViewState();
}

class _RestrictedWebViewState extends State<RestrictedWebView> {
  final ValueNotifier<bool> isLoading = ValueNotifier(true);

  bool _isPdfUrl(String url) {
    return url.toLowerCase().endsWith('.pdf');
  }

  @override
  Widget build(BuildContext context) {
    String initialUrl = _isPdfUrl(widget.url)
        ? 'https://docs.google.com/gview?embedded=true&url=${Uri.encodeFull(widget.url)}'
        : widget.url;

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColor.appWhite,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          InAppWebView(
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
          // Loader
          ValueListenableBuilder(
            valueListenable: isLoading,
            builder: (context, value, child) {
              return value
                  ? const Center(child: CircularProgressIndicator())
                  : const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
