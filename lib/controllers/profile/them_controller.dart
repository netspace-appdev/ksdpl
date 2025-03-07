import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ksdpl/common/helper.dart';
import 'package:ksdpl/common/storage_service.dart';

class ThemeController extends GetxController {


  // Observable theme mode
  var themeMode = ThemeMode.system.obs;

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  // Load saved theme from storage
  void _loadTheme() {
    String? savedTheme = StorageService.get(StorageService.THEME_MODE);
    if (savedTheme == AppText.lightTheme) {
      themeMode.value = ThemeMode.light;
    } else if (savedTheme == AppText.darkTheme) {
      themeMode.value = ThemeMode.dark;
    } else {
      themeMode.value = ThemeMode.light;
    }
  }

  // Change theme & save selection
  void changeTheme(ThemeMode mode) {
    themeMode.value = mode;
    Get.changeThemeMode(mode);

    if (mode == ThemeMode.light) {
      StorageService.put(StorageService.THEME_MODE, AppText.lightTheme);
    } else if (mode == ThemeMode.dark) {
      StorageService.put(StorageService.THEME_MODE, AppText.darkTheme);
    } else {
      StorageService.put(StorageService.THEME_MODE, AppText.systemTheme);
    }
  }
}
