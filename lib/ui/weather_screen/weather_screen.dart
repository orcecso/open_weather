import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_weather/gen/assets.gen.dart';
import 'package:open_weather/ui/component/main_weather_card.dart';
import 'package:open_weather/ui/component/search_bar.dart';
import 'package:open_weather/ui/component/weather_details_grid.dart';
import 'package:open_weather/ui/component/weather_error_widget.dart';
import 'package:open_weather/ui/component/wind_sun_card.dart';
import 'package:open_weather/ui/weather_screen/weather_screen_controller.dart';

class WeatherScreen extends GetView<WeatherScreenController> {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Image.asset(
          Assets.logo.splashviewLogo.path,
          fit: BoxFit.fill,
          height: 50,
          width: 100,
        ),
        actions: [
          Obx(() => GestureDetector(
                onTap: () => controller.toggleDataMode(),
                child: Chip(
                  label: Text(
                    controller.isXmlMode.value ? 'XML' : 'JSON',
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.blue,
                ),
              )),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const WeatherSearchBar(),
              const SizedBox(height: 24),
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.error.value.isNotEmpty) {
                  return WeatherErrorWidget(error: controller.error.value);
                }

                return _buildWeatherContent();
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherContent() {
    final isXml = controller.isXmlMode.value;
    final data =
        isXml ? controller.weatherDataXml.value : controller.weatherData.value;
    if (data == null) return const SizedBox.shrink();

    return Column(
      children: [
        MainWeatherCard(data: data, isXml: isXml),
        const SizedBox(height: 16),
        WeatherDetailsGrid(data: data, isXml: isXml),
        const SizedBox(height: 16),
        WindSunCard(data: data, isXml: isXml),
      ],
    );
  }
}
