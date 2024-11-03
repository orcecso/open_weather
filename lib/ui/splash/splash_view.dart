import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_weather/gen/assets.gen.dart';
import 'package:open_weather/ui/splash/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          Assets.logo.splashviewLogo.path,
          height: 250,
          width: 250,
        ),
      ),
    );
  }
}
