import '../domain/weather.dart';
import '../domain/weather_repository.dart';

class WeatherService {
  final WeatherRepository repository;

  WeatherService(this.repository);

  Future<CurrentWeather> loadCurrentWeather() {
    return repository.getCurrentWeather();
  }

  Future<List<ForecastDay>> loadForecast() {
    return repository.getForecast();
  }
}