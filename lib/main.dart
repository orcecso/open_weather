import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:open_weather/services/route/route.dart';
import 'package:open_weather/ui/splash/splash_controller.dart';
import 'package:open_weather/ui/weather_screen/weather_screen_controller.dart';

import 'services/weather_service/weather_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Get.putAsync(() => WeatherService().init());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      ensureScreenSize: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Open Weather Assessment',
          getPages: getRootPage(),
          initialRoute: splashView,
          initialBinding: InitialBinding(),
        );
      },
    );
  }
}

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
    Get.put(WeatherScreenController());
  }
}
