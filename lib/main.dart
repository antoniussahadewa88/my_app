import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/domain/repositories/auth_repository.dart';
import 'package:my_app/domain/repositories/weather_repository.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'core/network/api_client.dart';
import 'data/datasources/auth_remote_datasource.dart';
import 'data/datasources/weather_remote_datasource.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/weather_repository_impl.dart';
import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/fetch_weather_usecase.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/providers/weather_provider.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/pages/register_page.dart';
import 'presentation/pages/weather_list_page.dart';

final getIt = GetIt.instance;

//Mark::Menurutku ini seperti Koin pada Android kotlin native

void setup() {
  final client = http.Client();

  // ApiClient mendaftarkan Baseurlnya
  getIt.registerSingleton<ApiClient>(ApiClient(client: client, baseUrl: 'https://dummyjson.com'));

  // tempat regis Data sources
  getIt.registerSingleton<AuthRemoteDatasource>(AuthRemoteDatasource(getIt()));
  getIt.registerSingleton<WeatherRemoteDatasource>(WeatherRemoteDatasource(getIt()));

  // tempat regis Repositories
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl(getIt()));
  getIt.registerSingleton<WeatherRepository>(WeatherRepositoryImpl(getIt()));

  // tempat regis Usecases 
  getIt.registerSingleton<LoginUsecase>(LoginUsecase(getIt()));
  getIt.registerSingleton<FetchWeatherUsecase>(FetchWeatherUsecase(getIt()));

  // tempat regis Storage
  getIt.registerSingleton<FlutterSecureStorage>(FlutterSecureStorage());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginUseCase = getIt<LoginUsecase>();
    final fetchWeatherUseCase = getIt<FetchWeatherUsecase>();
    final storage = getIt<FlutterSecureStorage>();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => AuthProvider(loginUsecase: loginUseCase, storage: storage)
        ),
        ChangeNotifierProvider(
            create: (_) => WeatherProvider(fetchWeatherUseCase)
        ),
      ],
      child: MaterialApp(
        title: 'Auth + Weather Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/login',
        routes: {
          '/login': (_) => LoginPage(),
          '/register': (_) => RegisterPage(),
          '/weather': (_) => WeatherListPage(),
        },
      ),
    );
  }
}

void main() {
  setup();
  runApp(MyApp());
}
