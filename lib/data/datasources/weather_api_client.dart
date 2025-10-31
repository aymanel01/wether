import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'weather_api_client.g.dart';

@RestApi(baseUrl: 'http://10.0.2.2:3000')
abstract class WeatherApiClient {
  factory WeatherApiClient(Dio dio, {String baseUrl}) = _WeatherApiClient;

  @GET('/weather')
  Future<dynamic> getWeatherRaw();
}
