
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../common/helper.dart';

class RestrictedWebView extends StatefulWidget {
  final String url;
  final String title;

  const RestrictedWebView({
    Key? key,
    required this.url,
    required this.title,
  }) : super(key: key);

  @override
  State<RestrictedWebView> createState() => _RestrictedWebViewState();
}

class _RestrictedWebViewState extends State<RestrictedWebView> {
  final ValueNotifier<bool> isLoading = ValueNotifier(true);
  late final WebViewController controller;

  bool _isPdfUrl(String url) {
    return url.toLowerCase().endsWith('.pdf');
  }

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            isLoading.value = true;
          },
          onPageFinished: (url) {
            isLoading.value = false;
          },
          onWebResourceError: (error) {
            isLoading.value = false;
            Get.snackbar("Error", "Failed to load page.");
          },
          onNavigationRequest: (request) {
            print("request--->${request}");
            final requestedUrl = request.url;
            if (requestedUrl.endsWith(".pdf") &&
                !requestedUrl.contains("docs.google.com")) {
              Get.snackbar("Blocked", "PDF downloads are not allowed.");
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  Widget build(BuildContext context) {
    String initialUrl = _isPdfUrl(widget.url)
        ? 'https://docs.google.com/gview?embedded=true&url=${Uri.encodeFull(widget.url)}'
        : widget.url;

    controller.loadRequest(Uri.parse(initialUrl));

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
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
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