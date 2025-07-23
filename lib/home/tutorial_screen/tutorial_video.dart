import 'dart:ui';

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../common/helper.dart';
import '../../controllers/webController.dart';

class TutorialVideo extends StatefulWidget {
  final String url;
  final String title;

  const TutorialVideo({Key? key, required this.title, required this.url}) : super(key: key);

  @override
  State<TutorialVideo> createState() => _TutorialVideoState();
}

class _TutorialVideoState extends State<TutorialVideo> {
  late BetterPlayerController _betterPlayerController;
  final WebController _webController = Get.find();

  @override
  void initState() {
    super.initState();

    // Lock to landscape on this screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    _betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(
        autoPlay: true,
        aspectRatio: 16 / 9,
        fullScreenByDefault: false,
        autoDetectFullscreenDeviceOrientation: true,
        autoDetectFullscreenAspectRatio: true,
        allowedScreenSleep: false,
        handleLifecycle: true,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          enableFullscreen: true,
          enablePlaybackSpeed: true,
          enableSkips: true,
        ),
      ),
      betterPlayerDataSource: BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        widget.url,
      ),
    );

    _betterPlayerController.addEventsListener((event) {
      if (event.betterPlayerEventType == BetterPlayerEventType.hideFullscreen) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      }
    });
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();

    // Restore to portrait when leaving the screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _showExitConfirmation(context),
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: Stack(
          children: [
            Positioned.fill(child: _videoContainer(context)),
            Container(
              color: AppColor.primaryColor,
              child: Positioned(
                top: MediaQuery.of(context).padding.top + 10, // Keeps it below status bar
                left: 0,
                right: 0,
                child: _header(context, widget.title),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _gradientBackground(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColor.primaryLight, AppColor.primaryDark],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          const SizedBox(height: 30),
          _header(context, widget.title),
        ],
      ),
    );
  }

  Widget _videoContainer(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 1.2,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          color: AppColor.backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(45),
            topRight: Radius.circular(45),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: BetterPlayer(controller: _betterPlayerController),
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () async {
              bool exit = await _showExitConfirmation(context);
              if (exit) {
                Get.back();
              }
            },
            child: Container(
              width: 48,
              height: 48,
              padding: const EdgeInsets.all(12),
              alignment: Alignment.center,
              child: Image.asset(AppImage.arrowLeft, height: 24),
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: AppColor.grey3,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Future<bool> _showExitConfirmation(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Exit Video"),
        content: const Text("Are you sure you want to exit the video?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              _betterPlayerController.pause();
              Navigator.of(context).pop(true);
            },
            child: const Text("Exit"),
          ),
        ],
      ),
    ) ?? false;
  }
}
