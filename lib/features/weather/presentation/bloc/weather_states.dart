import 'package:weather_app_flaconi/features/weather/data/models/weather_model.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final List<WeatherModel> weeklyWeatherData;

  WeatherLoaded(this.weeklyWeatherData);
}

class WeatherError extends WeatherState {
  final String message;

  WeatherError(this.message);
}
