import 'package:flutter/material.dart';

class WindSunCard extends StatelessWidget {
  final dynamic data;
  final bool isXml;

  const WindSunCard({
    super.key,
    required this.data,
    required this.isXml,
  });

  @override
  Widget build(BuildContext context) {
    final windSpeed = isXml ? data.windSpeed : data.wind.speed;
    final windDeg = isXml ? data.windDirection : data.wind.deg;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Wind Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Icon(Icons.air, size: 32, color: Colors.blue),
                    const SizedBox(height: 8),
                    Text(
                      '$windSpeed m/s',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text('Wind Speed'),
                  ],
                ),
                Column(
                  children: [
                    Transform.rotate(
                      angle: (windDeg * 3.14159) / 180,
                      child: const Icon(Icons.navigation,
                          size: 32, color: Colors.blue),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$windDeg°',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text('Wind Direction'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
