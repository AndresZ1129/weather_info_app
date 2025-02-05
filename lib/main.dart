import 'dart:math';

import 'package:flutter/material.dart';

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

class WeatherForecast {
  String date;
  String condition;
  double temperature;
  WeatherForecast(this.date, this.condition, this.temperature);
}

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  String cityName = '';
  String weatherCondition = '';
  double temperature = 0.0;
  List<WeatherForecast> forecast = [];

  void fetchWeather() {
    Random random = Random();
    setState(() {
      temperature =
          random.nextInt(15) + 15; // Random temp between 15°C and 30°C
      List<String> conditions = ['Sunny', 'Cloudy', 'Rainy'];
      weatherCondition = conditions[random.nextInt(conditions.length)];
    });
  }

  void fetch7DayWeather() {
    setState(() {
      forecast = List.generate(7, (index) {
        Random random = Random();
        double temp = random.nextInt(15) + 15;
        String cond = ['Sunny', 'Cloudy', 'Rainy'][random.nextInt(3)];
        String date =
            DateTime.now().add(Duration(days: index)).toString().split(' ')[0];
        return WeatherForecast(date, cond, temp);
      });
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
            ElevatedButton(
              onPressed: fetch7DayWeather,
              child: const Text('Fetch 7-Day Forecast'),
            ),
            Text('Weather Info for $cityName'),
            Text('Temperature: $temperature °C'),
            Text('Condition: $weatherCondition'),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Table(
                  border: TableBorder.all(),
                  columnWidths: const <int, TableColumnWidth>{
                    0: FixedColumnWidth(100.0),
                    1: FixedColumnWidth(100.0),
                    2: FixedColumnWidth(100.0),
                  },
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                            child: Center(
                                child: Text('Date',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)))),
                        TableCell(
                            child: Center(
                                child: Text('Temperature',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)))),
                        TableCell(
                            child: Center(
                                child: Text('Condition',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)))),
                      ],
                    ),
                    ...forecast
                        .map((forecast) => TableRow(
                              children: [
                                TableCell(
                                    child: Center(child: Text(forecast.date))),
                                TableCell(
                                    child: Center(
                                        child:
                                            Text('${forecast.temperature}°C'))),
                                TableCell(
                                    child: Center(
                                        child: Text(forecast.condition))),
                              ],
                            ))
                        .toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
