

// ignore: unused_import
import 'package:flutter/material.dart';


/*
class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,


  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather (
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
    );
  }

}
*/


class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;


  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,

  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'] ?? 'Unknown City',
      temperature: json['main']['temp'],
      mainCondition: json['weather'][0]['main'],
  
    );
  }
}
