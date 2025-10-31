import '../models/weather_model.dart';
import 'weather_mock_datasource.dart';
import 'weather_api_client.dart';

abstract class WeatherRemoteDataSource {
  Future<List<WeatherModel>> getWeatherData();
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final WeatherApiClient apiClient;
  final WeatherMockDataSource mockDataSource;

  WeatherRemoteDataSourceImpl({
    required this.apiClient,
    WeatherMockDataSource? mockDataSource,
  }) : mockDataSource = mockDataSource ?? WeatherMockDataSource();

  @override
  Future<List<WeatherModel>> getWeatherData() async {
    try {
      final data = await apiClient.getWeatherRaw();
      return _parseWeatherData(data);
    } catch (e) {
      print('API failed, using mock data: $e');
      return await mockDataSource.getWeatherData();
    }
  }

  List<WeatherModel> _parseWeatherData(Map<String, dynamic> jsonData) {
    final List<WeatherModel> weatherList = [];
    final data = jsonData['data'];
    if (data != null && data.containsKey('timelines')) {
      final timelines = data['timelines'];
      if (timelines is List && timelines.isNotEmpty) {
        final hourlyData = timelines.firstWhere(
          (timeline) => timeline['timestep'] == '1h',
          orElse: () => timelines.first,
        );
        if (hourlyData != null && hourlyData['intervals'] != null) {
          final intervals = hourlyData['intervals'] as List;
          for (var interval in intervals) {
            final values = interval['values'];
            if (values != null) {
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
          }
        }
      }
    }
    return weatherList;
  }
}
