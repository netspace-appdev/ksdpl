import 'package:get/get.dart';

class GreetingController extends GetxController{

  var greetingMsg="".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getGreeting();
  }

  void getGreeting() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour >= 5 && hour < 12) {
      greetingMsg.value= "Good Morning";
    } else if (hour >= 12 && hour < 17) {
      greetingMsg.value= "Good Afternoon";
    } else if (hour >= 17 && hour < 21) {
      greetingMsg.value= "Good Evening";
    } else {
      greetingMsg.value= "Good Night";
    }
  }
}