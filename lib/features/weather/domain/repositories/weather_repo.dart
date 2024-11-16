import 'package:weather_app_flaconi/core/utils/enums.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/models/remote_data_failure_model.dart';
import '../../data/models/weather_model.dart';

abstract class WeatherRepository {
  Future<Either<RemoteDataFailureModel, List<WeatherModel>>> getWeatherData(
    String city, {
    required TempretureUnit tempretureUnit,
  });
}
