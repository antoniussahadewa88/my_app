import '../repositories/weather_repository.dart';

//Mark :: Ini seperti Usecase pada Native Code.
class FetchWeatherUsecase {
  final WeatherRepository repo;
  FetchWeatherUsecase(this.repo);

  Future<Map<String, dynamic>> call() {
    return repo.getJakartaHourly();
  }
}
