import 'package:flutter/material.dart';
import 'package:weather_app_flaconi/core/utils/extensions.dart';
import 'package:weather_app_flaconi/features/weather/data/models/weather_model.dart';

class DailyWidget extends StatelessWidget {
  final WeatherModel data;
  final bool selected;
  final VoidCallback onTapped;

  const DailyWidget({
    super.key,
    required this.data,
    required this.onTapped,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20.0),
      onTap: onTapped,
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              width: 3.0,
              color: selected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.black12,
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              data.dt.convertToDateTime.nameAbbrStr,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: SizedBox(
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    data.weather.first.icon.toWeatherIconUrl,
                    fit: BoxFit.cover,
                    colorBlendMode: BlendMode.screen,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
            Text(
              '${data.main.tempMin.toString()}°/${data.main.tempMax}°',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}
