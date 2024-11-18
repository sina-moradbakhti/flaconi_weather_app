import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_app/core/models/custom_exception_model.dart';

import 'package:weather_app/core/models/remote_data_failure_model.dart';

import 'package:weather_app/core/utils/enums.dart';
import 'package:weather_app/core/utils/extensions.dart';
import 'package:weather_app/features/weather/data/datasources/weather_remote_datasource.dart';

import 'package:weather_app/features/weather/data/models/weather_model.dart';

import '../../../../core/constants/app_constant.dart';
import '../../domain/repositories/weather_repo.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDatasource remote;

  WeatherRepositoryImpl({
    required this.remote,
  });

  @override
  Future<Either<RemoteDataFailureModel, List<WeatherModel>>> getWeatherData(
      String city,
      {required TempretureUnit tempretureUnit}) async {
    try {
      final result = await remote.fetchWeather(
        {
          'q': city,
          'appid': AppConstant.weatherAppId,
          'units': tempretureUnit.toStr,
        },
      );

      if (result.data['list'] == null) {
        throw CustomExceptionModel(message: 'Failed to fetch Weather data');
      }

      Map<String, WeatherModel> weathersList = {};

      for (var element in result.data['list']) {
        final weather = WeatherModel.fromJson(element);
        weathersList[weather.dtStr] = weather;
      }

      return Right(weathersList.values.toList());
    } on CustomExceptionModel catch (error) {
      return Left(
        RemoteDataFailureModel(
          message: error.message,
        ),
      );
    } catch (error) {
      if (error is TypeError) {
        debugPrint(error.stackTrace.toString());
      }

      return Left(
        RemoteDataFailureModel(
          message: error.toString(),
        ),
      );
    }
  }
}
