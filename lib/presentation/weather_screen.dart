import 'package:flutter/material.dart';
import '../application/weather_service.dart';
import '../domain/weather.dart';

class WeatherScreen extends StatefulWidget {
  final WeatherService weatherService;

  const WeatherScreen({super.key, required this.weatherService});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  CurrentWeather? _current;
  List<ForecastDay> _forecast = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final current = await widget.weatherService.loadCurrentWeather();
    final forecast = await widget.weatherService.loadForecast();
    setState(() {
      _current = current;
      _forecast = forecast;
      _loading = false;
    });
  }

  // Presentation-only mapping: WeatherCondition (domain) -> IconData
  // (Flutter). The domain layer deliberately doesn't know this
  // mapping exists.
  IconData _iconFor(WeatherCondition condition) {
    switch (condition) {
      case WeatherCondition.sunny:
        return Icons.wb_sunny_rounded;
      case WeatherCondition.cloudy:
        return Icons.cloud_rounded;
      case WeatherCondition.rainy:
        return Icons.grain_rounded;
      case WeatherCondition.snowy:
        return Icons.ac_unit_rounded;
      case WeatherCondition.windy:
        return Icons.air_rounded;
    }
  }

  String _labelFor(WeatherCondition condition) {
    switch (condition) {
      case WeatherCondition.sunny:
        return 'Sunny';
      case WeatherCondition.cloudy:
        return 'Cloudy';
      case WeatherCondition.rainy:
        return 'Rainy';
      case WeatherCondition.snowy:
        return 'Snowy';
      case WeatherCondition.windy:
        return 'Windy';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF5B9BE0), Color(0xFFAED9F2)],
          ),
        ),
        child: SafeArea(
          child: _loading
              ? const Center(
            child: CircularProgressIndicator(color: Colors.white),
          )
              : _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    final current = _current!;

    return Column(
      children: [
        const SizedBox(height: 16),
        Text(
          current.city,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Icon(_iconFor(current.condition), color: Colors.white, size: 72),
        const SizedBox(height: 8),
        Text(
          '${current.temperatureCelsius.round()}°',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 64,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
        ),
        Text(
          _labelFor(current.condition),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _StatChip(
              icon: Icons.water_drop_rounded,
              label: '${current.humidityPercent}%',
            ),
            const SizedBox(width: 16),
            _StatChip(
              icon: Icons.air_rounded,
              label: '${current.windSpeedKph.round()} km/h',
            ),
          ],
        ),
        const SizedBox(height: 28),
        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '5-Day Forecast',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1C1B1A),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 150,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _forecast.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, i) => _ForecastCard(
                      forecast: _forecast[i],
                      icon: _iconFor(_forecast[i].condition),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _StatChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 13)),
        ],
      ),
    );
  }
}

class _ForecastCard extends StatelessWidget {
  final ForecastDay forecast;
  final IconData icon;

  const _ForecastCard({required this.forecast, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F0EE),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            forecast.day,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6B6864),
            ),
          ),
          const SizedBox(height: 8),
          Icon(icon, color: const Color(0xFF5B9BE0), size: 26),
          const SizedBox(height: 8),
          Text(
            '${forecast.highCelsius.round()}°',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1C1B1A),
            ),
          ),
          Text(
            '${forecast.lowCelsius.round()}°',
            style: const TextStyle(fontSize: 12, color: Color(0xFFA9A6A1)),
          ),
        ],
      ),
    );
  }
}