import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../data/datasources/weather_remote_datasource.dart';
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
    () => WeatherRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton(() => Dio());

  sl.registerLazySingleton(() => GetWeatherDataUseCase(sl()));
}
