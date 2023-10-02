import 'package:flutter/material.dart';

import '../model/weather.dart';

class AdditionalWeatherInfo extends StatelessWidget {
  const AdditionalWeatherInfo({required this.weather});
  final Weather? weather;

  String get windDirection {
    if (weather!.windDirection == 'N') {
      return 'North';
    }
    if (weather!.windDirection == 'S') {
      return 'South';
    }
    if (weather!.windDirection == 'E') {
      return 'East';
    }
    return 'West';
  }

  Widget myContainer({
    required BuildContext context,
    required String title,
    required String info,
  }) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(15),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            child: Text(
              info,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Additional Info',
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              myContainer(
                context: context,
                title: 'Wind Direction',
                info: windDirection,
              ),
              myContainer(
                context: context,
                title: 'Wind Speed',
                info: '${weather!.windSpeed} K/H',
              ),
              myContainer(
                context: context,
                title: 'Wind Degree',
                info: '${weather!.windDegree}°',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
