import 'package:flutter/material.dart';
import 'package:weather_app_flaconi/core/utils/enums.dart';
import 'package:weather_app_flaconi/core/utils/extensions.dart';

class WeatherAppbarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final int weekDay;
  final City currentCity;
  final Function(City? selectedCity)? onChangedCity;

  const WeatherAppbarWidget({
    super.key,
    required this.weekDay,
    required this.currentCity,
    this.onChangedCity,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(DateTime.now().add(Duration(days: weekDay)).nameStr),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DropdownButton(
                items: [
                  for (City city in City.values)
                    DropdownMenuItem(
                      value: city,
                      child: Text(
                        city.toStr,
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                ],
                onChanged: onChangedCity,
                icon: Container(),
                underline: Container(),
                isDense: true,
                disabledHint: null,
                value: currentCity,
                hint: DropdownMenuItem(
                  child: Text(
                    currentCity.toStr,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
