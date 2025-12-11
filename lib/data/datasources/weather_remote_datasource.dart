import '../../core/network/api_client.dart';

//Mark:: ini seperti declare func ok http(get,post,delete dll disini) declare apiClient pada Native
//Mark:: aku disini menggunakan open api get cuaca di jakarta
class WeatherRemoteDatasource {
  final ApiClient api;
  WeatherRemoteDatasource(this.api);

  //Mark:: aku disini akan call open-meteo full url
  //Mark:: Jakarta-> lat=-6.2 lon=106.8, hourly temperature_2m, timezone=Asia/Jakarta
  Future<Map<String, dynamic>> fetchJakartaHourly() async {
    final url = 'https://api.open-meteo.com/v1/forecast?latitude=-6.2&longitude=106.8&hourly=temperature_2m&timezone=Asia%2FJakarta';
    final res = await api.getFull(url);
    return res;
  }
}