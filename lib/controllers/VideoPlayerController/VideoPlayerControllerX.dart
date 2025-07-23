import 'package:better_player/better_player.dart';

import 'package:get/get.dart';

class VideoPlayerControllerX extends GetxController {

  late BetterPlayerController betterPlayerController;

  void initializePlayer(String url) {

    BetterPlayerConfiguration betterPlayerConfiguration = BetterPlayerConfiguration(

      autoPlay: true,

      aspectRatio: 16 / 9,

      fullScreenByDefault: true,

      autoDetectFullscreenDeviceOrientation: true,

      autoDetectFullscreenAspectRatio: true,

      allowedScreenSleep: false,

      handleLifecycle: true,

      controlsConfiguration: const BetterPlayerControlsConfiguration(

        enableFullscreen: true,

        enablePlaybackSpeed: true,

        enableSkips: true,

      ),

    );

    BetterPlayerDataSource dataSource = BetterPlayerDataSource(

      BetterPlayerDataSourceType.network,

      url,

    );

    betterPlayerController = BetterPlayerController(betterPlayerConfiguration);

    betterPlayerController.setupDataSource(dataSource);

  }

  @override

  void onClose() {

    betterPlayerController.dispose();

    super.onClose();

  }

}

