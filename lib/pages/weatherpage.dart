import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
// ignore: unused_import
import 'package:weatherapp/main.dart';
import 'package:weatherapp/models/weathermodel.dart';
import 'package:weatherapp/services/weatherservice.dart';
/*
class Weatherpage extends StatefulWidget {
  const Weatherpage({super.key});

  @override
  State<Weatherpage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<Weatherpage> {

    //api key
    final _weatherService = Weatherservice('88f09a46e849953da5bbe054c1e93f6f');
    Weather? _weather;


    //Fethc weather
    _fetchWeather() async {
      //get the current city
      String cityName = await _weatherService.getCurrentCity();



      //get weather for city
      try {
        final weather = await _weatherService.getWeather(cityName);
        setState(() {
          _weather= weather;
        });
      }


      //any errors
      catch(e) {
        print(e);
      }
    }



    //weather animations

    String getWeatherAnimation(String? mainCondition) {
      if (mainCondition == null) return 'assets/sunny.json';

      switch (mainCondition.toLowerCase()) {
        case 'clouds':
          return 'assets/cloudy.json';
        case 'mist':
        case 'smoke':
        case 'haze':
        case 'fog':
          return 'assets/sunnycloudy.json'; 
        case 'rain':
        case 'drizzle':
        case 'shower rain':
          return 'assets/cloudrainsun.json';
        case 'thunderstorm':
          return 'assets/lighting.json';
        case 'clear':
        default:
         return 'assets/sunny.json';
      }

    }

    //initial state

    @override
    void initState() {
      super.initState();

      //fetch weather on startup
      _fetchWeather();
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //City name
          Text(_weather?.cityName ?? "loading city.."),

          //animations
          Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

          //temperature
          Text('${_weather?.temperature.round()}°C'),

          //Condition
          Text(_weather?.mainCondition ?? "")
          
        ],
      )
    )
    );
  }


  Widget _buildWeeklyForecast(List<Weather> forecast) {
  return Container(
    height: 150,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: forecast.length,
      itemBuilder: (context, index) {
        final dailyWeather = forecast[index];
        return Container(
          width: 100,
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${dailyWeather.temperature.round()}°C',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 5),
              Text(dailyWeather.mainCondition),
            ],
          ),
        );
      },
    ),
  );
}
}
*/





class Weatherpage extends StatefulWidget {
  final String selectedLocation;

  const Weatherpage({super.key, required this.selectedLocation});

  @override
  State<Weatherpage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<Weatherpage> {
  final _weatherService = Weatherservice('88f09a46e849953da5bbe054c1e93f6f');
  Weather? _weather;

  // Fetch weather for the provided location
  _fetchWeather(String cityName) async {
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'assets/cloudy.json';
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'fog':
        return 'assets/sunnycloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/cloudrainsun.json';
      case 'thunderstorm':
        return 'assets/lighting.json';
      case 'clear':
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather(widget.selectedLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // City name
          Text(_weather?.cityName ?? "Loading city..."),

          // Animations
          Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

          // Temperature
          Text('${_weather?.temperature.round()}°C'),

          // Condition
          Text(_weather?.mainCondition ?? ""),
        ],
      ),
    );
  }
}
