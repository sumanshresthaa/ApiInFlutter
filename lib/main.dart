import 'package:flutter/material.dart';
import 'package:revisionapp/network_helper.dart';
import 'package:revisionapp/weather_datamodel.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Dashboard(),
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  fetchWeather() async {
    //return await NetworkHelper.fetchWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dasboard'),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: GestureDetector(
            onTap: () async {
              // NetworkHelper networkHelper = NetworkHelper();
              // await networkHelper.fetchWeatherData();
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SecondPage();
              }));
            },
            child: Container(
              color: Colors.blue,
              height: 50,
              width: 200,
              child: Center(child: Text('Get Response')),
            ),
          ),
        )
      ]),
    );
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  Future<WeatherData>? _weatherData;
  int? a;

  @override
  void initState() {
    _weatherData = getWeatherData();
    super.initState();
  }

  Future<WeatherData> getWeatherData() async {
    NetworkHelper networkHelper = NetworkHelper();
    return await networkHelper.fetchWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Weather Page'),
        ),
        // body: Center(
        //   child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        //     Text(
        //       'Kathmandu',
        //       style: TextStyle(fontSize: 24),
        //     ),
        //     Text('30 C', style: TextStyle(fontSize: 18))
        //   ]),
        // ),

        body: FutureBuilder<WeatherData>(
            future: _weatherData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          snapshot.data!.name.toString(),
                          style: TextStyle(fontSize: 24),
                        ),
                        Text("${snapshot.data!.main!.temp.toString()} K",
                            style: TextStyle(fontSize: 18)),
                        Text(snapshot.data!.sys!.sunrise.toString())
                      ]),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
