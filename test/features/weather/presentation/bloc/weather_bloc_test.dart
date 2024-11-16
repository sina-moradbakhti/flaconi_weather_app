import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_app_flaconi/core/models/remote_data_failure_model.dart';
import 'package:weather_app_flaconi/core/utils/enums.dart';
import 'package:weather_app_flaconi/core/utils/extensions.dart';
import 'package:weather_app_flaconi/features/weather/data/datasources/weather_local_datasource.dart';
import 'package:weather_app_flaconi/features/weather/data/models/weather_model.dart';
import 'package:weather_app_flaconi/features/weather/domain/repositories/weather_repo.dart';
import 'package:weather_app_flaconi/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_app_flaconi/features/weather/presentation/bloc/weather_events.dart';
import 'package:weather_app_flaconi/features/weather/presentation/bloc/weather_states.dart';

import 'fake_weather_data.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

class MockWeatherLocalDatasource extends Mock
    implements WeatherLocalDatasource {}

void main() {
  late WeatherBloc weatherBloc;
  late MockWeatherRepository mockWeatherRepository;
  late MockWeatherLocalDatasource mockLocalDatasource;
  late List<WeatherModel> tWeatherData;

  setUpAll(() {
    registerFallbackValue(TempretureUnit.metric);
  });

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    mockLocalDatasource = MockWeatherLocalDatasource();
    tWeatherData = FakeWeatherData.weatherList;

    // Setup mock for local datasource
    when(() => mockLocalDatasource.tempretureUnit)
        .thenReturn(TempretureUnit.metric);

    // Setup initial repository response
    when(() => mockWeatherRepository.getWeatherData(
          any<String>(),
          tempretureUnit: any<TempretureUnit>(named: 'tempretureUnit'),
        )).thenAnswer((_) async => Right(tWeatherData));

    weatherBloc = WeatherBloc(mockWeatherRepository);
  });

  tearDown(() {
    weatherBloc.close();
  });

  group('WeatherBloc', () {
    test('initial state should be WeatherInitial', () {
      weatherBloc = WeatherBloc(mockWeatherRepository);
      expect(weatherBloc.state, isA<WeatherInitial>());
    });

    test('should fetch data for first city on initialization', () async {
      weatherBloc = WeatherBloc(mockWeatherRepository);
      await Future.delayed(Duration.zero);
      verify(() => mockWeatherRepository.getWeatherData(
            City.values.first.toStr,
            tempretureUnit: any<TempretureUnit>(named: 'tempretureUnit'),
          )).called(2);

      expect(weatherBloc.state, isA<WeatherLoaded>());
    });

    blocTest<WeatherBloc, WeatherState>(
      'should emit WeatherLoaded when GetWeatherData is added',
      build: () => weatherBloc,
      act: (bloc) => bloc.add(GetWeatherData(City.values.first)),
      expect: () => [
        WeatherLoading(),
        WeatherLoaded(FakeWeatherData.weatherList),
      ],
    );

    blocTest<WeatherBloc, WeatherState>(
      'should emit WeatherError when GetWeatherData is added and error occures',
      build: () {
        when(() => mockWeatherRepository.getWeatherData(
                  any<String>(),
                  tempretureUnit: any<TempretureUnit>(named: 'tempretureUnit'),
                ))
            .thenAnswer(
                (_) async => Left(RemoteDataFailureModel(message: 'error')));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(GetWeatherData(City.values.first)),
      expect: () => [
        WeatherLoading(),
        WeatherError('error'),
      ],
    );
  });
}
