import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/weather_model.dart';

part 'weather_state.freezed.dart';

@freezed
class WeatherState with _$WeatherState {
  const factory WeatherState.initial() = WeatherInitial;
  const factory WeatherState.loading() = WeatherLoadingState;
  const factory WeatherState.loaded(List<WeatherModel> weatherData) =
      WeatherLoaded;
  const factory WeatherState.error(String message) = WeatherErrorState;
}
