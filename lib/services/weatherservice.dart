import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/models/weathermodel.dart';
import 'package:http/http.dart' as http;

/*
class Weatherservice {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  Weatherservice  (this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final respone = await http
        .get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));

    if (respone.statusCode == 200) {
      return Weather.fromJson(jsonDecode(respone.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  
  Future<String> getCurrentCity() async {
    
    //get permission from user
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }


    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );


      List<Placemark> placemarks = 
      await placemarkFromCoordinates(position.latitude, position.longitude);


      String? city = placemarks[0].locality;

      return city ?? "";
      
      
  }

}
*/


class Weatherservice {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  Weatherservice(this.apiKey);

  // Fetch weather for a specific city
  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(
      Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  // Get current city based on user location
  Future<String> getCurrentCity() async {
    // Request location permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // Get user's current position
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );

    // Reverse geocoding to get city name
    List<Placemark> placemarks = 
        await placemarkFromCoordinates(position.latitude, position.longitude);

    String? city = placemarks[0].locality;
    return city ?? "Unknown location";
  }

  // Unified method to get weather based on city or current location
  Future<Weather> getWeatherByLocation(String? selectedLocation) async {
    if (selectedLocation == "Current Location") {
      String currentCity = await getCurrentCity();
      return getWeather(currentCity);
    } else {
      return getWeather(selectedLocation!);
    }
  }
}
