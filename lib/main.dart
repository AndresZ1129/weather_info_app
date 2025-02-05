import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WeatherApp(),
    );
  }
}

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  String cityName = '';
  String weatherCondition = '';
  double temperature = 0.0;

  void fetchWeather() {
    Random random = Random();
    setState(() {
      temperature = 15 + random.nextDouble()*16; // Random temp between 15°C and 30°C
      List<String> conditions = ['Sunny', 'Cloudy', 'Rainy'];
      weatherCondition = conditions[random.nextInt(conditions.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => cityName = value,
              decoration: const InputDecoration(
                labelText: 'Enter city name',
              ),
            ),
            ElevatedButton(
              onPressed: fetchWeather,
              child: const Text('Fetch Weather'),
            ),
            Text('Weather Info for $cityName'),
            Text('Temperature: $temperature °C'),
            Text('Condition: $weatherCondition'),
          ],
        ),
      ),
    );
  }
}