import 'package:flutter/material.dart';
import '../model/weather.dart';

class WeatherInfo extends StatelessWidget {
  const WeatherInfo({required this.weather});

  final Weather? weather;

  Widget myText({
    required String info,
    required double fontSize,
  }) {
    return FittedBox(
      child: Text(
        info,
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 200,
      padding: const EdgeInsets.all(5),
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
          myText(
            info: '${weather!.currentLocation}, ${weather!.country}',
            fontSize: 20,
          ),
          myText(
            info: '${double.parse(weather!.tempC).round()}°C',
            fontSize: 50,
          ),
          myText(
            info: weather!.condition,
            fontSize: 20,
          ),
        ],
      ),
    );
  }
}
