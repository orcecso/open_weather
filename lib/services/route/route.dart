import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:open_weather/ui/splash/splash_binding.dart';
import 'package:open_weather/ui/splash/splash_view.dart';
import 'package:open_weather/ui/weather_screen/weather_screen.dart';
import 'package:open_weather/ui/weather_screen/weather_screen_binding.dart';

const String weatherView = "/weatherView";
const String splashView = "/splashView";

List<GetPage> getRootPage() {
  List<GetPage> list = [];

  list.add(GetPage(
    name: weatherView,
    page: () => const WeatherScreen(),
    transition: Transition.fadeIn,
    binding: WeatherScreenBinding(),
  ));

  list.add(GetPage(
    name: splashView,
    page: () => const SplashView(),
    transition: Transition.fadeIn,
    binding: SplashBinding(),
  ));

  return list;
}

goToWeatherView() {
  Get.toNamed(weatherView);
}

goToSplashView() {
  Get.toNamed(splashView);
}
