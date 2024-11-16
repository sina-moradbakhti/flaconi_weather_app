import 'package:weather_app_flaconi/core/utils/enums.dart';

class WeatherLocalDatasource {
  static final WeatherLocalDatasource _singleton =
      WeatherLocalDatasource._internal();
  factory WeatherLocalDatasource() => _singleton;
  WeatherLocalDatasource._internal();

  TempretureUnit tempretureUnit = TempretureUnit.metric;
}
