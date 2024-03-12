import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

void main() {
  runApp(Parte4Page());
}

class Parte4Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicacion del clima',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String _apiKey =
      'e110ced4b97942a6c63bdb044213a372'; // Inserta tu propia API key de OpenWeatherMap
  String _cityName = 'Santo Domingo, DO'; // Nombre de la ciudad en RD
  late String _weatherDescription;
  late double _temperature;
  late String _weatherIcon;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$_cityName&appid=$_apiKey&units=metric'));
    final responseData = json.decode(response.body);

    setState(() {
      _isLoading = false;
      _weatherDescription = responseData['weather'][0]['description'];
      _temperature = responseData['main']['temp'];
      _weatherIcon = responseData['weather'][0]['icon'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clima de $_cityName'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    'http://openweathermap.org/img/w/$_weatherIcon.png',
                    scale: 1.0,
                  ),
                  Text(
                    '$_temperature°C',
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    _weatherDescription,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
    );
  }
}
