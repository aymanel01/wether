import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/weather_repository.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({required this.weatherRepository})
    : super(const WeatherState.initial()) {
    on<LoadWeatherData>(_loadWeather);
    on<RefreshWeatherData>(_loadWeather);
  }

  Future<void> _loadWeather(
    WeatherEvent event,
    Emitter<WeatherState> emit,
  ) async {
    emit(const WeatherState.loading());
    try {
      final data = await weatherRepository.getWeatherData();
      emit(WeatherState.loaded(data));
    } catch (e) {
      emit(WeatherState.error(e.toString()));
    }
  }
}
