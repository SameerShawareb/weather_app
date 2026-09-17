enum WeatherCondition { sunny, cloudy, rainy, snowy, windy }

class CurrentWeather {
  final String city;
  final double temperatureCelsius;
  final WeatherCondition condition;
  final int humidityPercent;
  final double windSpeedKph;

  CurrentWeather({
    required this.city,
    required this.temperatureCelsius,
    required this.condition,
    required this.humidityPercent,
    required this.windSpeedKph,
  });
}

class ForecastDay {
  final String day;
  final double highCelsius;
  final double lowCelsius;
  final WeatherCondition condition;

  ForecastDay({
    required this.day,
    required this.highCelsius,
    required this.lowCelsius,
    required this.condition,
  });
}