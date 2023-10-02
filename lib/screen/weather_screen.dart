import 'package:flutter/material.dart';

import '../model/weather.dart';
import '../widget/additional_weather_info.dart';
import '../widget/weather_info.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({required this.futureWeather});

  final Weather? futureWeather;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        WeatherInfo(weather: futureWeather),
        const SizedBox(height: 40),
        AdditionalWeatherInfo(weather: futureWeather),
      ],
    );
  }
}
