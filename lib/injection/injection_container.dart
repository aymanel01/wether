import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../data/datasources/weather_remote_datasource.dart';
import '../data/datasources/weather_api_client.dart';
import '../domain/repositories/weather_repository.dart';
import '../data/repositorise/weather_repository_impl.dart';
import '../presentation/bloc/weather_bloc.dart';
import 'dio_config.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  serviceLocator.registerLazySingleton<Dio>(() => DioConfig().dio);
  serviceLocator.registerLazySingleton<WeatherApiClient>(
    () => WeatherApiClient(serviceLocator<Dio>()),
  );
  serviceLocator.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(apiClient: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(remoteDataSource: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => WeatherBloc(weatherRepository: serviceLocator()),
  );
}
