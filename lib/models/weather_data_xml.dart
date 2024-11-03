import 'package:xml/xml.dart';

class WeatherDataXml {
  final String cityName;
  final double temperature;
  final double tempMin;
  final double tempMax;
  final double feelsLike;
  final double humidity;
  final String weatherDescription;
  final double windSpeed;
  final int windDirection;
  final String icon;
  final int visibility;
  final double pressure;
  final int clouds;

  // Default Values , i noticed that the api sometimes returns empty values
  static const String defaultCityName = 'Unknown City';
  static const double defaultTemperature = 0.0;
  static const double defaultTempMin = 0.0;
  static const double defaultTempMax = 0.0;
  static const double defaultFeelsLike = 0.0;
  static const double defaultHumidity = 0.0;
  static const String defaultWeatherDescription = 'No weather data';
  static const double defaultWindSpeed = 0.0;
  static const int defaultWindDirection = 0;
  static const String defaultIcon = '01d';
  static const int defaultVisibility = 10000;
  static const double defaultPressure = 1013.25;
  static const int defaultClouds = 0;

  WeatherDataXml({
    this.cityName = defaultCityName,
    this.temperature = defaultTemperature,
    this.tempMin = defaultTempMin,
    this.tempMax = defaultTempMax,
    this.feelsLike = defaultFeelsLike,
    this.humidity = defaultHumidity,
    this.weatherDescription = defaultWeatherDescription,
    this.windSpeed = defaultWindSpeed,
    this.windDirection = defaultWindDirection,
    this.icon = defaultIcon,
    this.visibility = defaultVisibility,
    this.pressure = defaultPressure,
    this.clouds = defaultClouds,
  });

  factory WeatherDataXml.fromXmlElement(XmlElement element) {
    double parseDouble(String? value, double defaultValue) {
      if (value == null || value.isEmpty) return defaultValue;
      try {
        return double.parse(value);
      } catch (e) {
        return defaultValue;
      }
    }

    int parseInt(String? value, int defaultValue) {
      if (value == null || value.isEmpty) return defaultValue;
      try {
        return int.parse(value);
      } catch (e) {
        return defaultValue;
      }
    }

    String getAttributeSafely(
        Iterable<XmlElement> elements, String attribute, String defaultValue) {
      if (elements.isEmpty) return defaultValue;
      final value = elements.first.getAttribute(attribute);
      return (value == null || value.isEmpty) ? defaultValue : value;
    }

    try {
      return WeatherDataXml(
        cityName: getAttributeSafely(
            element.findElements('city'), 'name', defaultCityName),
        temperature: parseDouble(
            element
                .findElements('temperature')
                .firstOrNull
                ?.getAttribute('value'),
            defaultTemperature),
        tempMin: parseDouble(
            element
                .findElements('temperature')
                .firstOrNull
                ?.getAttribute('min'),
            defaultTempMin),
        tempMax: parseDouble(
            element
                .findElements('temperature')
                .firstOrNull
                ?.getAttribute('max'),
            defaultTempMax),
        feelsLike: parseDouble(
            element
                .findElements('feels_like')
                .firstOrNull
                ?.getAttribute('value'),
            defaultFeelsLike),
        humidity: parseDouble(
            element.findElements('humidity').firstOrNull?.getAttribute('value'),
            defaultHumidity),
        weatherDescription: getAttributeSafely(element.findElements('weather'),
            'value', defaultWeatherDescription),
        icon: getAttributeSafely(
            element.findElements('weather'), 'icon', defaultIcon),
        windSpeed: parseDouble(
            element
                .findElements('wind')
                .firstOrNull
                ?.findElements('speed')
                .firstOrNull
                ?.getAttribute('value'),
            defaultWindSpeed),
        windDirection: parseInt(
            element
                .findElements('wind')
                .firstOrNull
                ?.findElements('direction')
                .firstOrNull
                ?.getAttribute('value'),
            defaultWindDirection),
        visibility: parseInt(
            element
                .findElements('visibility')
                .firstOrNull
                ?.getAttribute('value'),
            defaultVisibility),
        pressure: parseDouble(
            element.findElements('pressure').firstOrNull?.getAttribute('value'),
            defaultPressure),
        clouds: parseInt(
            element.findElements('clouds').firstOrNull?.getAttribute('value'),
            defaultClouds),
      );
    } catch (e) {
      return WeatherDataXml();
    }
  }

  // Useful for debugging, leave it as is, i can use it to check issues on api
  @override
  String toString() {
    return '''WeatherDataXml(
      cityName: $cityName,
      temperature: $temperature,
      tempMin: $tempMin,
      tempMax: $tempMax,
      feelsLike: $feelsLike,
      humidity: $humidity,
      weatherDescription: $weatherDescription,
      windSpeed: $windSpeed,
      windDirection: $windDirection,
      icon: $icon,
      visibility: $visibility,
      pressure: $pressure,
      clouds: $clouds
    )''';
  }
}
