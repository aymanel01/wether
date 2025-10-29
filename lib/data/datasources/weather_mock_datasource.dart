import '../models/weather_model.dart';

class WeatherMockDataSource {
  Future<List<WeatherModel>> getWeatherData() async {
    await Future.delayed(const Duration(seconds: 1));
    final List<WeatherModel> weatherList = [];
    final now = DateTime.now();

    for (int i = 0; i < 24; i++) {
      final time = now.add(Duration(hours: i));
      final windVariation = (i % 4) * 1.5;
      final tempVariation = (i % 6) * 2.0;
      final apparentTempVariation = (i % 5) * 1.8;

      weatherList.add(
        WeatherModel(
          windSpeed: 8.0 + (i * 0.3) + windVariation,
          temperature: 18.0 + (i * 0.2) + tempVariation,
          apparentTemperature: 17.0 + (i * 0.25) + apparentTempVariation,
          time: time,
        ),
      );
    }
    return weatherList;
  }
}
