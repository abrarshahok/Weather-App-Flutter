import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/weather.dart';

class WeatherApiException implements Exception {
  final String message;
  const WeatherApiException(this.message);
}

class WeatherApiClient with ChangeNotifier {
  static const baseUrl =
      'http://api.weatherapi.com/v1/current.json?key=ac7c67ff9e304452a6590234232506&q=';

  Future<String> getLocation(String city) async {
    try {
      final locationUrl = Uri.parse('$baseUrl$city');
      final locationResponse = await http.get(locationUrl);
      if (locationResponse.statusCode != 200) {
        throw WeatherApiException('Error Getting Location ID for city: $city');
      }
      final locationJson = jsonDecode(locationResponse.body);
      if (locationJson.isEmpty) {
        throw WeatherApiException('No Location Found for: $city');
      }
      final currentLocation = locationJson['location']['name'] as String;
      return currentLocation;
    } catch (_) {
      rethrow;
    }
  }

  Future<Weather> fetchWeather(String location) async {
    try {
      final weatherUrl = Uri.parse('$baseUrl$location');
      final weatherResponse = await http.get(weatherUrl);
      if (weatherResponse.statusCode != 200) {
        throw WeatherApiException(
            'Error Getting Weather for location: $location');
      }
      final weatherJson = jsonDecode(weatherResponse.body);

      if (weatherJson.isEmpty) {
        throw WeatherApiException(
            'Weather Data not available for location: $location');
      }
      Map<String, dynamic> weatherMap = {
        'currentLocation': weatherJson['location']['name'],
        'country': weatherJson['location']['country'],
        'currentF': weatherJson['current']['temp_f'],
        'currentC': weatherJson['current']['temp_c'],
        'condition': weatherJson['current']['condition']['text'],
        'icon': weatherJson['current']['condition']['icon'],
        'isDay': weatherJson['current']['is_day'],
        'windSpeed': weatherJson['current']['wind_kph'],
        'windDegree': weatherJson['current']['wind_degree'],
        'windDirection': weatherJson['current']['wind_dir'],
      };

      return Weather.fromJson(weatherMap);
    } catch (_) {
      rethrow;
    }
  }

  Future<Weather> getWeather(String city) async {
    try {
      final confirmCity = await getLocation(city);
      return fetchWeather(confirmCity);
    } catch (_) {
      rethrow;
    }
  }
}
