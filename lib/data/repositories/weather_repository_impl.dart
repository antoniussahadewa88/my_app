import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_remote_datasource.dart';

class WeatherRepositoryImpl implements WeatherRepository{
  final WeatherRemoteDatasource remote;
  WeatherRepositoryImpl(this.remote);

  @override
  Future<Map<String, dynamic>> getJakartaHourly(){
    return remote.fetchJakartaHourly();
  }
}