import 'package:xml/xml.dart';

class WeatherDataXml {
  final String cityName;
  final double temperature;
  final double feelsLike;
  final double humidity;
  final String weatherDescription;
  final double windSpeed;
  final int windDirection;

  WeatherDataXml({
    required this.cityName,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.weatherDescription,
    required this.windSpeed,
    required this.windDirection,
  });

  factory WeatherDataXml.fromXmlElement(XmlElement element) {
    return WeatherDataXml(
      cityName: element.findElements('city').first.getAttribute('name') ?? '',
      temperature: double.parse(
        element.findElements('temperature').first.getAttribute('value') ?? '0',
      ),
      feelsLike: double.parse(
        element.findElements('feels_like').first.getAttribute('value') ?? '0',
      ),
      humidity: double.parse(
        element.findElements('humidity').first.getAttribute('value') ?? '0',
      ),
      weatherDescription:
          element.findElements('weather').first.getAttribute('value') ?? '',
      windSpeed: double.parse(
        element
                .findElements('wind')
                .first
                .findElements('speed')
                .first
                .getAttribute('value') ??
            '0',
      ),
      windDirection: int.parse(
        element
                .findElements('wind')
                .first
                .findElements('direction')
                .first
                .getAttribute('value') ??
            '0',
      ),
    );
  }
}
