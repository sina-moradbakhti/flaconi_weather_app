import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/weather/data/repositories/weather_repo_impl.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/features/weather/presentation/views/weather_screen.dart';

import 'features/weather/data/datasources/weather_remote_datasource.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WeatherBloc(
        WeatherRepositoryImpl(
          remote: WeatherRemoteDatasource(),
        ),
      ),
      child: const MaterialApp(
        home: WeatherScreen(),
      ),
    );
  }
}
