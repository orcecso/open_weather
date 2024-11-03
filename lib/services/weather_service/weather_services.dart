import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:open_weather/models/weather_data_model.dart';
import 'package:open_weather/models/weather_data_xml.dart';
import 'package:xml/xml.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class WeatherService extends GetxService {
  final String? baseUrl = dotenv.env['OPENWEATHERMAP_API_URL'];
  final String? apiKey = dotenv.env['OPENWEATHERMAP_API_KEY'];

  Future<WeatherService> init() async {
    // TO DO
    return this;
  }

  Future<WeatherData> getWeatherJson(String city) async {
    final response = await http.get(
      Uri.parse('$baseUrl?q=$city&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      //     print(response.body);
      return WeatherData.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<WeatherDataXml> getWeatherXml(String city) async {
    final response = await http.get(
      Uri.parse('$baseUrl?q=$city&appid=$apiKey&units=metric&mode=xml'),
    );

    if (response.statusCode == 200) {
      final document = XmlDocument.parse(response.body);
      final currentWeather = document.findElements('current').first;
      return WeatherDataXml.fromXmlElement(currentWeather);
    } else {
      throw Exception('Failed to load weather XML data');
    }
  }

  Future<WeatherData> getWeatherByLocation(double lat, double lon) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric',
      ),
    );

    if (response.statusCode == 200) {
      // print(response.body);

      return WeatherData.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<WeatherDataXml> getWeatherByLocationXml(double lat, double lon) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric&mode=xml',
      ),
    );

    if (response.statusCode == 200) {
      // print(response.body);

      final document = XmlDocument.parse(response.body);
      final currentWeather = document.findElements('current').first;
      return WeatherDataXml.fromXmlElement(currentWeather);
    } else {
      throw Exception('Failed to load weather XML data');
    }
  }
}
