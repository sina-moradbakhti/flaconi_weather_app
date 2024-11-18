import 'package:dio/dio.dart';
import 'package:weather_app/core/constants/app_constant.dart';

class MainRemoteDatasource {
  final Dio _remoteService = Dio();

  Future<Response> get(String function,
      {Map<String, dynamic>? queryParameters}) async {
    return await _remoteService.get(
      "${AppConstant.weatherBaseUrl}/$function",
      queryParameters: queryParameters,
    );
  }
}
