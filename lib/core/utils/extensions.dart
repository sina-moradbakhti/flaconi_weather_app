import 'package:intl/intl.dart';

import '../constants/app_constant.dart';
import 'enums.dart';

extension TempretureUnitExtension on TempretureUnit {
  String get unitSymbol => this == TempretureUnit.imperial ? '°F' : '°C';
  String get toStr => this == TempretureUnit.imperial ? 'imperial' : 'metric';
}

extension TempretureUnitStrExtension on String {
  TempretureUnit get toTempretureUnit =>
      this == 'imperial' ? TempretureUnit.imperial : TempretureUnit.metric;
}

extension DateTimeExtension on DateTime {
  String get nameStr {
    String dayName = DateFormat('EEEE').format(this);
    return dayName;
  }

  String get nameAbbrStr {
    String dayName = DateFormat('EEE').format(this);
    return dayName;
  }
}

extension DateTimeIntExtension on int {
  DateTime get convertToDateTime =>
      DateTime.fromMillisecondsSinceEpoch((this * 1000), isUtc: true);
}

extension CitiesExtension on City {
  String get toStr {
    switch (this) {
      case City.tehran:
        return 'Tehran';
      case City.istanbul:
        return 'Istanbul';
      case City.berlin:
        return 'Berlin';
      case City.paris:
        return 'Paris';
    }
  }
}

extension WeatherIconUrlExtension on String {
  String get toWeatherIconUrl =>
      '${AppConstant.weatherIconBaseUrl}/$this@4x.png';
}
