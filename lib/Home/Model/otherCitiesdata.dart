// The bottom UI scroll bar for saved cities, Data model.

import 'dart:convert';

class OtherCitiesDataModel {
  String lat;
  String long;

  String locationName;
  int currentTemperature;
  String weatherDescription;

  bool currentCity;

  OtherCitiesDataModel({
    required this.lat,
    required this.long,
    required this.locationName,
    required this.currentTemperature,
    required this.weatherDescription,
    required this.currentCity,
  });

  @override
  String toString() {
    return 'OtherCitiesDataModel(locatioName: $locationName, currentCity: $currentCity, lat: $lat, long: $long)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lat': lat,
      'long': long,
      'locationName': locationName,
      'currentTemperature': currentTemperature,
      'weatherDescription': weatherDescription,
      'currentCity': currentCity,
    };
  }

  factory OtherCitiesDataModel.fromMap(Map<String, dynamic> map) {
    return OtherCitiesDataModel(
        lat: map['lat'] as String,
        long: map['long'] as String,
        locationName: map['locationName'] as String,
        currentTemperature: map['currentTemperature'] as int,
        weatherDescription: map['weatherDescription'] as String,
        currentCity: map['currentCity'] as bool);
  }

  String toJson() => json.encode(toMap());

  factory OtherCitiesDataModel.fromJson(String source) =>
      OtherCitiesDataModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
