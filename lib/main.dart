
import 'package:flutter/material.dart';
import 'application/weather_service.dart';
import 'infrastructure/static_weather_repository.dart';
import 'presentation/weather_screen.dart';

void main() {
  final repository = StaticWeatherRepository();
  final weatherService = WeatherService(repository);
  runApp(WeatherApp(weatherService: weatherService));
}

class WeatherApp extends StatelessWidget {
  final WeatherService weatherService;

  const WeatherApp({super.key, required this.weatherService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: WeatherScreen(weatherService: weatherService),
    );
  }
}