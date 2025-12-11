import 'package:flutter/material.dart';
import '../../domain/usecases/fetch_weather_usecase.dart';

//Mark :: Ini seperti ViewModel pada Native Code.
class WeatherProvider extends ChangeNotifier {
  final FetchWeatherUsecase fetchWeatherUsecase;

  bool loading = false;
  String? error;

  List<Map<String, dynamic>> hourly = [];

  WeatherProvider(this.fetchWeatherUsecase);

  Future<void> fetchHourlyJakarta() async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      final res = await fetchWeatherUsecase();

      final hourlyMap = res['hourly'] as Map<String, dynamic>?;
      if (hourlyMap == null) throw Exception('Malformed weather response');

      final times = List<String>.from(hourlyMap['time'] ?? []);
      final tempsDynamic = hourlyMap['temperature_2m'] ?? [];
      final temps = List<dynamic>.from(tempsDynamic);

      final List<Map<String, dynamic>> out = [];

      for (var i = 0; i < times.length && i < temps.length; i++) {
        final t = times[i];
        final temp = double.tryParse(temps[i].toString()) ?? 0.0;
        final formatted = t.replaceAll('T', ' ');
        out.add({'time': formatted, 'temp': temp});
      }

      hourly = out;
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      error = e.toString();
      notifyListeners();
    }
  }
}