import 'weather.dart';

abstract class WeatherRepository {
  Future<CurrentWeather> getCurrentWeather();
  Future<List<ForecastDay>> getForecast();
}