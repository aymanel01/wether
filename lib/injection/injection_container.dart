import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../data/datasources/weather_remote_datasource.dart';
import '../data/datasources/weather_api_client.dart';
import '../domain/repositories/weather_repository.dart';
import '../domain/usecases/get_weather_data_usecase.dart';
import '../data/repositorise/weather_repository_impl.dart';
import '../domain/repositories/bloc/weather_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => WeatherBloc(getWeatherDataUseCase: sl()));
  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(apiClient: sl()),
  );
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton<WeatherApiClient>(() => WeatherApiClient(sl()));

  sl.registerLazySingleton(() => GetWeatherDataUseCase(sl()));
}
