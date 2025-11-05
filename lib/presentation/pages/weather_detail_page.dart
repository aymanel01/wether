import 'package:flutter/material.dart';
import '../../data/models/weather_model.dart';

class WeatherDetailPage extends StatelessWidget {
  final WeatherModel weatherData;

  const WeatherDetailPage({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    final time = weatherData.time;

    return Scaffold(
      appBar: AppBar(
        title: Text('${time.day}/${time.month}/${time.year}'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTimeCard(),
            const SizedBox(height: 16),
            _buildTemperatureCard(),
            const SizedBox(height: 16),
            _buildWindCard(),
            const SizedBox(height: 16),
            _buildApparentTemperatureCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeCard() {
    final t = weatherData.time;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.access_time, color: Colors.blue[600]),
                const SizedBox(width: 8),
                Text(
                  'Heure',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              '${t.hour}:${t.minute.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              '${t.day}/${t.month}/${t.year}',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTemperatureCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.thermostat, color: Colors.orange[600]),
                const SizedBox(width: 8),
                Text(
                  'Température',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              '${weatherData.temperature.toStringAsFixed(1)}°C',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.orange[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _getTemperatureDescription(weatherData.temperature),
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWindCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.air, color: Colors.green[600]),
                const SizedBox(width: 8),
                Text(
                  'Vent',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              '${weatherData.windSpeed.toStringAsFixed(1)} km/h',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.green[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _getWindDescription(weatherData.windSpeed),
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApparentTemperatureCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.thermostat_outlined, color: Colors.blue[600]),
                const SizedBox(width: 8),
                Text(
                  'Température Ressentie',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              '${weatherData.apparentTemperature.toStringAsFixed(1)}°C',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blue[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _getApparentTemperatureDescription(
                weatherData.temperature,
                weatherData.apparentTemperature,
              ),
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  String _getTemperatureDescription(double temp) {
    if (temp < 0) return 'Très froid';
    if (temp < 10) return 'Froid';
    if (temp < 20) return 'Frais';
    if (temp < 30) return 'Agréable';
    return 'Chaud';
  }

  String _getWindDescription(double speed) {
    if (speed < 5) return 'Calme';
    if (speed < 15) return 'Léger';
    if (speed < 30) return 'Modéré';
    if (speed < 50) return 'Fort';
    return 'Très fort';
  }

  String _getApparentTemperatureDescription(double temp, double apparent) {
    final diff = apparent - temp;
    if (diff.abs() < 1) return 'Ressenti identique à la température réelle';
    if (diff > 0) return 'Ressenti plus chaud de ${diff.toStringAsFixed(1)}°C';
    return 'Ressenti plus froid de ${(-diff).toStringAsFixed(1)}°C';
  }
}
