import 'package:get/get.dart';
import 'package:open_weather/ui/weather_screen/weather_screen_controller.dart';

class WeatherScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WeatherScreenController>(
      () => WeatherScreenController(),
    );
  }
}