import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:open_weather/models/weather_data_model.dart';
import 'package:open_weather/models/weather_data_xml.dart';
import 'package:open_weather/services/weather_service/weather_services.dart';

class WeatherScreenController extends GetxController {
  final WeatherService _weatherService = Get.find<WeatherService>();

  final Rx<WeatherData?> weatherData = Rx<WeatherData?>(null);
  final Rx<WeatherDataXml?> weatherDataXml = Rx<WeatherDataXml?>(null);
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final RxString cityValue = ''.obs;

  final RxBool isXmlMode = false.obs;

  void toggleDataMode() {
    isXmlMode.value = !isXmlMode.value;
  }

  Future<void> fetchWeatherByCity(String city) async {
    isLoading.value = true;
    error.value = '';
    cityValue.value = city;

    try {
      if (isXmlMode.value) {
        weatherDataXml.value = await _weatherService.getWeatherXml(city);
        weatherData.value = null;
      } else {
        weatherData.value = await _weatherService.getWeatherJson(city);
        weatherDataXml.value = null;
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchWeatherByCurrentLocation() async {
    isLoading.value = true;
    error.value = '';

    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permission denied');
        }
      }

      final position = await Geolocator.getCurrentPosition();

      if (isXmlMode.value) {
        weatherDataXml.value = await _weatherService.getWeatherByLocationXml(
          position.latitude,
          position.longitude,
        );
        weatherData.value = null;
        cityValue.value = weatherDataXml.value?.cityName ?? '';
      } else {
        weatherData.value = await _weatherService.getWeatherByLocation(
          position.latitude,
          position.longitude,
        );
        weatherDataXml.value = null;
        cityValue.value = weatherData.value?.name ?? '';
      }

      // weatherDataXml.value = null;
      // isXmlMode.value = false;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
