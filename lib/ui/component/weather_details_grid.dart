import 'package:flutter/material.dart';
import 'weather_detail_item.dart';

class WeatherDetailsGrid extends StatelessWidget {
  final dynamic data;
  final bool isXml;

  const WeatherDetailsGrid({
    super.key,
    required this.data,
    required this.isXml,
  });

  @override
  Widget build(BuildContext context) {
    final details = [
      {
        'icon': Icons.thermostat,
        'title': 'Humidity',
        'value': '${isXml ? data.humidity : data.main.humidity}%',
      },
      {
        'icon': Icons.visibility,
        'title': 'Visibility',
        'value':
            '${((isXml ? data.visibility : data.visibility) / 1000).toStringAsFixed(1)} km',
      },
      {
        'icon': Icons.compress,
        'title': 'Pressure',
        'value': '${isXml ? data.pressure : data.main.pressure} hPa',
      },
      {
        'icon': Icons.cloud,
        'title': 'Clouds',
        'value': '${isXml ? data.clouds : data.clouds.all}%',
      },
    ];

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: constraints.maxWidth > 500 ? 4 : 2,
                childAspectRatio: 1.5,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: details.length,
              itemBuilder: (context, index) {
                final detail = details[index];
                return DetailItem(
                  icon: detail['icon'] as IconData,
                  title: detail['title'] as String,
                  value: detail['value'] as String,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
