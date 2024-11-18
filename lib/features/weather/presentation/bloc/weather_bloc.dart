import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/utils/extensions.dart';

import '../../../../core/utils/enums.dart';
import '../../data/datasources/weather_local_datasource.dart';
import '../../domain/repositories/weather_repo.dart';
import 'weather_events.dart';
import 'weather_states.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepo;

  WeatherBloc(this.weatherRepo) : super(WeatherInitial()) {
    on<GetWeatherData>(_onGetWeatherData);
    // On initial load call the event
    add(GetWeatherData(City.values.first));
  }

  Future<void> _onGetWeatherData(
      GetWeatherData event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());

    final result = await weatherRepo.getWeatherData(
      event.city.toStr,
      tempretureUnit: WeatherLocalDatasource().tempretureUnit,
    );

    result.fold(
      (failure) => emit(WeatherError(failure.message)),
      (data) => data.isEmpty
          ? emit(WeatherError('No data!'))
          : emit(WeatherLoaded(data)),
    );
  }
}
