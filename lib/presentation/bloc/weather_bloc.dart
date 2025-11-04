import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/weather_repository.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({required this.weatherRepository})
    : super(const WeatherState.initial()) {
    on<LoadWeatherData>(_onLoadWeatherData);
    on<RefreshWeatherData>(_onLoadWeatherData);
  }

  Future<void> _onLoadWeatherData(
    WeatherEvent event,
    Emitter<WeatherState> emit,
  ) async {
    emit(const WeatherState.loading());
    try {
      final weatherData = await weatherRepository.getWeatherData();
      emit(WeatherState.loaded(weatherData));
    } catch (error) {
      emit(WeatherState.error(error.toString()));
    }
  }
}
