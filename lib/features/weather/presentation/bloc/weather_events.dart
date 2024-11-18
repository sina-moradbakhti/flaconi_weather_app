import 'package:weather_app/core/utils/enums.dart';

abstract class WeatherEvent {}

class GetWeatherData extends WeatherEvent {
  final City city;

  GetWeatherData(this.city);
}
