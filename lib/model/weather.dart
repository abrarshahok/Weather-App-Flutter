class Weather {
  final String currentLocation;
  final String country;
  final String tempC;
  final String tempF;
  final String condition;
  final String icon;
  final String isDay;
  final String windSpeed;
  final String windDegree;
  final String windDirection;

  const Weather({
    required this.currentLocation,
    required this.country,
    required this.tempC,
    required this.tempF,
    required this.icon,
    required this.condition,
    required this.isDay,
    required this.windDegree,
    required this.windDirection,
    required this.windSpeed,
  });
  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        currentLocation: '${json['currentLocation']}',
        country: '${json['country']}',
        tempC: '${json['currentC']}',
        tempF: '${json['currentF']}',
        condition: '${json['condition']}',
        isDay: '${json['isDay']}' == '1' ? 'Day' : 'Night',
        icon: 'http:${json['icon']}',
        windDegree: '${json['windDegree']}',
        windSpeed: '${json['windSpeed']}',
        windDirection: '${json['windDirection']}',
      );
}
