import 'package:dio/dio.dart';
import 'package:weather_app/core/datasources/main_remote_datasource.dart';

import '../../../../core/models/custom_exception_model.dart';

class WeatherRemoteDatasource extends MainRemoteDatasource {
  Future<Response> fetchWeather(
    Map<String, dynamic> queryParameters,
  ) async {
    try {
      return await get(
        'forecast',
        queryParameters: queryParameters,
      );
    } catch (e) {
      throw CustomExceptionModel(
          message: 'Failed to fetch Weather data from the server');
    }
  }
}
