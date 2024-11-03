import 'package:get/get.dart';
import 'package:open_weather/services/route/route.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    await onNext();

    super.onInit();
  }

  Future<void> onNext() async {
    Future.delayed(const Duration(seconds: 3), () async {
      Get.offAllNamed(weatherView);
      return;
    });
  }
}
