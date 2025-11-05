import '../../data/models/weather_model.dart';

abstract class WeatherRepository {
  Future<List<WeatherModel>> getWeatherData();
}
