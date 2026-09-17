import '../domain/weather.dart';
import '../domain/weather_repository.dart';

class StaticWeatherRepository implements WeatherRepository {
  @override
  Future<CurrentWeather> getCurrentWeather() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return CurrentWeather(
      city: 'Amman',
      temperatureCelsius: 27,
      condition: WeatherCondition.sunny,
      humidityPercent: 40,
      windSpeedKph: 12,
    );
  }

  @override
  Future<List<ForecastDay>> getForecast() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return [
      ForecastDay(day: 'Fri', highCelsius: 29, lowCelsius: 19, condition: WeatherCondition.sunny),
      ForecastDay(day: 'Sat', highCelsius: 26, lowCelsius: 18, condition: WeatherCondition.cloudy),
      ForecastDay(day: 'Sun', highCelsius: 24, lowCelsius: 17, condition: WeatherCondition.rainy),
      ForecastDay(day: 'Mon', highCelsius: 28, lowCelsius: 19, condition: WeatherCondition.sunny),
      ForecastDay(day: 'Tue', highCelsius: 30, lowCelsius: 20, condition: WeatherCondition.windy),
    ];
  }
}