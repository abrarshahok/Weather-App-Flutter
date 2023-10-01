import 'package:flutter/material.dart';
import '../model/weather.dart';

class WeatherInfo extends StatelessWidget {
  const WeatherInfo({required this.weather});

  final Weather? weather;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 300,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).colorScheme.primary,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                weather!.icon,
                scale: 1.0,
              ),
              Text(
                '${weather!.currentLocation}, ${weather!.country}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              Text(
                '${double.parse(weather!.tempC).round()}°C',
                style: const TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                ),
              ),
              Text(
                weather!.condition,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
