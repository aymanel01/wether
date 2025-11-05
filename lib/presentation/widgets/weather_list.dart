import 'package:flutter/material.dart';
import '../../data/models/weather_model.dart';
import 'weather_card.dart';

class WeatherList extends StatelessWidget {
  final List<WeatherModel> weatherData;

  const WeatherList({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    if (weatherData.isEmpty) {
      return const Center(child: Text('Aucune donnée météo disponible'));
    }

    return RefreshIndicator(
      onRefresh: () async {},
      child: ListView.builder(
        itemCount: weatherData.length,
        itemBuilder: (_, i) => WeatherCard(weatherData: weatherData[i]),
      ),
    );
  }
}
