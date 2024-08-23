import 'dart:convert';
import 'package:intl/intl.dart';

class FutureForecastData {
  String locationName;
  List<Map<String, dynamic>> dailyWeather; // Map to get the next five days weather data.
  // double latitude;
  // double longitude;

  FutureForecastData({required this.locationName, required this.dailyWeather});

  // To override the normal toString which gives the traditional Instances reference, by using this we get the normal object in String Format.
  @override
  String toString() => 'ForeCastData(locationName : $locationName, dailyWeather: $dailyWeather)';

  factory FutureForecastData.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>> dailyWeather = [];

    for (var i = 0; i < json['list'].length && dailyWeather.length < 5; i += 8) {
      var item = json['list'][i];
      DateTime date = DateTime.parse(item['dt_txt']);
      String day = DateFormat('EEE').format(date); // To Convert the String into First three letter of the day.

      // Map to get the next five days weather data.
      dailyWeather.add({
        'day': day,
        'temp_max': item['main']['temp_max'],
        'temp_min': item['main']['temp_min'],
        'weather_description': item['weather'][0]['description'],
        'precipitation': item['pop'] * 100,
        'humidity': item['main']['humidity'],
        'wind_speed': item['wind']['speed'],
      });
    }

    return FutureForecastData(
      locationName: json['city']['name'],
      dailyWeather: dailyWeather,
    );
  }
}
