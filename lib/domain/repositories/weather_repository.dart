//Mark :: jika ada response atau req import dahulu ke repo

abstract class WeatherRepository {
  Future<Map<String, dynamic>> getJakartaHourly();
}