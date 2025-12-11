import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/weather_provider.dart';

class WeatherListPage extends StatefulWidget {
  @override
  State<WeatherListPage> createState() => _WeatherListPageState();
}

//MArk :: Ini seperti SwiftUi atau JpackCompose pada Native Code 
class _WeatherListPageState extends State<WeatherListPage> {
  @override
  void initState() {
    super.initState();
    final wp = Provider.of<WeatherProvider>(context, listen: false);
    wp.fetchHourlyJakarta();
  }

  @override
  Widget build(BuildContext context) {
    final wp = Provider.of<WeatherProvider>(context);
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Perubahan Temperatur di Jakarta'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await auth.logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],
      ),
      body: wp.loading
          ? Center(child: CircularProgressIndicator())
          : wp.error != null
              ? Center(child: Text('Error: ${wp.error}'))
              : RefreshIndicator(
                  onRefresh: () => wp.fetchHourlyJakarta(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (auth.authData != null) ...[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Masuk Sebagai : ${auth.authData!.username}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        Divider(),
                      ],

                      Expanded(
                        child: ListView.builder(
                          itemCount: wp.hourly.length,
                          itemBuilder: (_, i) {
                            final it = wp.hourly[i];
                            return ListTile(
                              leading: Text('${i + 1}'),
                              title: Text('${it['time']}'),
                              trailing: Text('${it['temp']} °C'),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}