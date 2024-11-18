import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather/data/models/weather_model.dart';

abstract class WeatherState extends Equatable {}

class WeatherInitial extends WeatherState {
  @override
  List<Object?> get props => [];
}

class WeatherLoading extends WeatherState {
  @override
  List<Object?> get props => [];
}

class WeatherLoaded extends WeatherState {
  @override
  List<Object?> get props => [weeklyWeatherData];

  final List<WeatherModel> weeklyWeatherData;

  WeatherLoaded(this.weeklyWeatherData);
}

class WeatherError extends WeatherState {
  @override
  List<Object?> get props => [message];

  final String message;

  WeatherError(this.message);
}
