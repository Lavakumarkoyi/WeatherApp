// This file is to  Get the current Day, Current City Weather Data Model.
import 'dart:convert';

class CurrentWeatherdataModel {
  int currentTemperature;
  int highTemperature;
  int lowTemperature;

  int precipitation;
  int humidity;
  int windspeed;

  String weatherDescription;
  String locationName;

  // bool currentCity;

  CurrentWeatherdataModel({
    required this.currentTemperature,
    required this.highTemperature,
    required this.lowTemperature,
    required this.precipitation,
    required this.humidity,
    required this.windspeed,
    required this.weatherDescription,
    required this.locationName,
    // required this.currentCity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentTemperature': currentTemperature,
      'highTemperature': highTemperature,
      'lowTemperature': lowTemperature,
      'precipitation': precipitation,
      'humidity': humidity,
      'windspeed': windspeed,
      'weatherDescription': weatherDescription,
      'locationName': locationName,
      // 'currentCity': currentCity,
    };
  }

  factory CurrentWeatherdataModel.fromMap(Map<String, dynamic> map) {
    return CurrentWeatherdataModel(
        currentTemperature: map['main']['temp'].floor() as int,
        highTemperature: map['main']['temp_max'].floor() as int,
        lowTemperature: map['main']['temp_min'].floor() as int,
        precipitation: map['main']['sea_level'].floor() as int,
        humidity: map['main']['humidity'].floor() as int,
        windspeed: map['wind']['speed'].floor() as int,
        weatherDescription: map['weather'][0]['main'] as String,
        locationName: map['name'] as String);
    // currentCity: map['currentCity'] as bool);
  }

  String toJson() => json.encode(toMap());

  factory CurrentWeatherdataModel.fromJson(String source) =>
      CurrentWeatherdataModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
