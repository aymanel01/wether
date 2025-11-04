import '../models/weather_model.dart';
import 'weather_api_client.dart';

abstract class WeatherRemoteDataSource {
  Future<List<WeatherModel>> getWeatherData();
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final WeatherApiClient apiClient;

  WeatherRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<WeatherModel>> getWeatherData() async {
    final data = await apiClient.getWeatherRaw();
    return _parseWeatherData(data as Map<String, dynamic>);
  }

  List<WeatherModel> _parseWeatherData(Map<String, dynamic> jsonData) {
    final weatherList = <WeatherModel>[];
    final data = jsonData['data'];
    if (data == null || !data.containsKey('timelines')) {
      return weatherList;
    }

    final timelines = data['timelines'] as List?;
    if (timelines == null || timelines.isEmpty) {
      return weatherList;
    }

    final hourlyData = timelines.firstWhere(
      (timeline) => timeline['timestep'] == '1h',
      orElse: () => timelines.first,
    );

    final intervals = hourlyData['intervals'] as List?;
    if (intervals == null) {
      return weatherList;
    }

    for (final interval in intervals) {
      final values = interval['values'];
      if (values == null) continue;

      weatherList.add(
        WeatherModel(
          windSpeed: (values['windSpeed'] ?? 0.0).toDouble(),
          temperature: (values['temperature'] ?? 0.0).toDouble(),
          apparentTemperature: (values['apparentTemperature'] ?? 0.0)
              .toDouble(),
          time: DateTime.parse(interval['startTime']),
        ),
      );
    }

    return weatherList;
  }
}
