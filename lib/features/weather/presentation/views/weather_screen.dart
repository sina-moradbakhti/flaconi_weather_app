import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/utils/enums.dart';
import 'package:weather_app/core/utils/extensions.dart';
import 'package:weather_app/features/weather/data/datasources/weather_local_datasource.dart';

import '../bloc/weather_bloc.dart';
import '../bloc/weather_events.dart';
import '../bloc/weather_states.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/weather_info_widget.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  City _selectedCity = City.values.first;
  int _selectedWeekDay = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          setState(() {
            if (WeatherLocalDatasource().tempretureUnit ==
                TempretureUnit.imperial) {
              WeatherLocalDatasource().tempretureUnit = TempretureUnit.metric;
            } else {
              WeatherLocalDatasource().tempretureUnit = TempretureUnit.imperial;
            }

            context.read<WeatherBloc>().add(
                  GetWeatherData(_selectedCity),
                );
          });
        },
        child: Text(WeatherLocalDatasource().tempretureUnit.unitSymbol),
      ),
      appBar: WeatherAppbarWidget(
        weekDay: _selectedWeekDay,
        currentCity: _selectedCity,
        onChangedCity: (selectedCity) {
          setState(() => _selectedCity = selectedCity!);
          context.read<WeatherBloc>().add(
                GetWeatherData(_selectedCity),
              );
        },
      ),
      body: BlocListener<WeatherBloc, WeatherState>(
        listener: _listener,
        child: _blocBuilder(context),
      ),
    );
  }

  void _listener(BuildContext context, WeatherState state) => (context, state) {
        if (state is WeatherError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      };

  BlocBuilder<WeatherBloc, WeatherState> _blocBuilder(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoading) {
          return const Center(
            child: SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 3.0,
              ),
            ),
          );
        } else if (state is WeatherLoaded &&
            state.weeklyWeatherData[_selectedWeekDay].weather.isNotEmpty) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 24.0,
              ),
              child: WeatherInfoWidget(
                onChangedWeekDay: (newSelectedWeekDay) => setState(
                  () => _selectedWeekDay = newSelectedWeekDay,
                ),
                selectedWeekDay: _selectedWeekDay,
                weeklyData: state.weeklyWeatherData,
                onPullToRefresh: () => context.read<WeatherBloc>().add(
                      GetWeatherData(_selectedCity),
                    ),
              ),
            ),
          );
        } else if (state is WeatherError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  state.message,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black87,
                      ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () => context.read<WeatherBloc>().add(
                        GetWeatherData(_selectedCity),
                      ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Try again',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return const Center(
          child: Text('No data'),
        );
      },
    );
  }
}
