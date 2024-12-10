import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
// ignore: unused_import
import 'package:weatherapp/main.dart';
import 'package:weatherapp/models/weathermodel.dart';
import 'package:weatherapp/services/weatherservice.dart';
import 'package:fl_chart/fl_chart.dart';
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
  final bool isMinimalistMode;

  const Weatherpage({
    super.key,
    required this.selectedLocation,
    required this.isMinimalistMode,
  });

  @override
  State<Weatherpage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<Weatherpage> {
  final _weatherService = Weatherservice('88f09a46e849953da5bbe054c1e93f6f');
  Weather? _weather;

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

  @override
  void didUpdateWidget(covariant Weatherpage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedLocation != oldWidget.selectedLocation) {
      _fetchWeather(widget.selectedLocation);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'assets/cloudy.json';
      case 'mist':
        return 'assets/misty.json';
      case 'smoke':
      case 'haze':
      case 'fog':
        return 'assets/sunnymisty.json';
      case 'rain':
        return 'assets/cloudrainsun.json';
      case 'drizzle':
      case 'shower rain':
        return 'assets/cloudrainsun.json';
      case 'thunderstorm':
        return 'assets/lighting.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather(widget.selectedLocation);
  }

  double getValidValue(double? value) {
    if (value == null || value.isNaN || value.isInfinite) {
      return 0.0; // Provide a default value if the data is invalid
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // City name
              Text(
                _weather?.cityName ?? "Loading city...",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              // Weather animation (Lottie animation based on weather condition)
              SizedBox(
                height:
                    200, // Give the animation a fixed height to avoid layout issues
                child:
                    Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
              ),

              // Conditionally show either Minimalist or Detailed Mode
              widget.isMinimalistMode
                  ? MinimalistWeatherLayout(weather: _weather)
                  : DetailedWeatherLayout(weather: _weather),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class MinimalistWeatherLayout extends StatelessWidget {
  final Weather? weather;

  const MinimalistWeatherLayout({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Center(
      // This will center the content horizontally
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Center vertically
        crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
        children: [
          Text('${weather?.temperature.round()}°C',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          Text(weather?.mainCondition ?? "", style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}

class DetailedWeatherLayout extends StatelessWidget {
  final Weather? weather;

  const DetailedWeatherLayout({super.key, required this.weather});

  // Function to safely get weather data or return a default value
  double getValidValue(double? value) {
    if (value == null || value.isNaN || value.isInfinite) {
      return 0.0; // Provide a default value if the data is invalid
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // This will center the entire Column
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, // Center the content vertically
        crossAxisAlignment:
            CrossAxisAlignment.center, // Center the content horizontally
        children: [
          // Left side: LineChart with fixed size
          Container(
            width: 200, // Explicit width constraint for the chart
            height: 200, // Explicit height constraint for the chart
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: true),
                titlesData: FlTitlesData(show: true),
                borderData: FlBorderData(show: true),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, getValidValue(weather?.temperature.toDouble())),
                      FlSpot(1, getValidValue(weather?.humidity.toDouble())),
                      FlSpot(2, getValidValue(weather?.windSpeed.toDouble())),
                    ],
                    isCurved: true,
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.green, Colors.red],
                    ),
                    barWidth: 4,
                    isStrokeCapRound: true,
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20), // Add some space between the chart and details

          // Weather Details (centered below the chart)
          Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center horizontally
            children: [
              Text('${weather?.temperature.round() ?? 0}°C',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              Text(weather?.mainCondition ?? "",
                  style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Humidity: ${weather?.humidity ?? 0}%',
                  style: TextStyle(fontSize: 16)),
              Text('Wind Speed: ${weather?.windSpeed ?? 0} m/s',
                  style: TextStyle(fontSize: 16)),
              Text('Pressure: ${weather?.pressure ?? 0} hPa',
                  style: TextStyle(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }
}
