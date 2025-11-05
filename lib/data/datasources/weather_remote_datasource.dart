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
    final response = await apiClient.getWeatherRaw();
    return _parseWeatherData(response as Map<String, dynamic>);
  }

  List<WeatherModel> _parseWeatherData(Map<String, dynamic> json) {
    final List<WeatherModel> result = [];

    final data = json['data'];
    if (data == null || !data.containsKey('timelines')) return result;

    final timelines = data['timelines'] as List?;
    if (timelines == null || timelines.isEmpty) return result;

    final hourly = timelines.firstWhere(
      (t) => t['timestep'] == '1h',
      orElse: () => timelines.first,
    );

    final intervals = hourly['intervals'] as List?;
    if (intervals == null) return result;

    for (final interval in intervals) {
      final values = interval['values'];
      if (values == null) continue;

      result.add(
        WeatherModel(
          windSpeed: (values['windSpeed'] ?? 0.0).toDouble(),
          temperature: (values['temperature'] ?? 0.0).toDouble(),
          apparentTemperature: (values['apparentTemperature'] ?? 0.0)
              .toDouble(),
          time: DateTime.parse(interval['startTime']),
        ),
      );
    }

    return result;
  }
}
