import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_weather/ui/weather_screen/weather_screen_controller.dart';

class MainWeatherCard extends StatelessWidget {
  final dynamic data;
  final bool isXml;

  const MainWeatherCard({
    super.key,
    required this.data,
    required this.isXml,
  });

  @override
  Widget build(BuildContext context) {
    WeatherScreenController weatherScreenController =
        Get.find<WeatherScreenController>();
    final temp = isXml ? data.temperature : data.main.temp;
    final feelsLike = isXml ? data.feelsLike : data.main.feelsLike;
    final description =
        isXml ? data.weatherDescription : data.weather.first.description;
    final icon = isXml ? data.icon : data.weather.first.icon;
    final cityName = weatherScreenController.cityValue;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$cityName',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${temp.round()}°C',
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Feels like ${feelsLike.round()}°C',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Image.network(
                  'https://openweathermap.org/img/wn/$icon@2x.png',
                  width: 100,
                  height: 100,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description.toString().toUpperCase(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
