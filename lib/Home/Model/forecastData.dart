// To get the Current Day Weather Forecast data.

import 'dart:convert';
import 'package:intl/intl.dart';

class ForeCastData {
  double lat;
  double long;
  List<Map<String, dynamic>> tempTime;

  ForeCastData({
    required this.lat,
    required this.long,
    required this.tempTime,
  });

  ForeCastData copyWith({
    double? lat,
    double? long,
    List<Map<String, dynamic>>? tempTime,
  }) {
    return ForeCastData(
      lat: lat ?? this.lat,
      long: long ?? this.long,
      tempTime: tempTime ?? this.tempTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lat': lat,
      'long': long,
      'tempTime': tempTime,
    };
  }

  factory ForeCastData.fromMap(Map<String, dynamic> map) {
    return ForeCastData(
      lat: map['lat'] as double,
      long: map['long'] as double,
      tempTime: List<Map<String, dynamic>>.from(
        (map['tempTime'] as List<dynamic>).map<Map<String, dynamic>>(
          (x) => Map<String, dynamic>.from(x as Map),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ForeCastData.fromJson(String source) => ForeCastData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ForeCastData(lat: $lat, long: $long, tempTime: $tempTime)';

  // This factory is used to convert the API response into this particular data model.
  // We can also implement this in the Bloc, But it is preferable to use in data model.

  factory ForeCastData.fromApiResponse(Map<String, dynamic> apiResponse) {
    double latitude = apiResponse['city']['coord']['lat'];
    double longitude = apiResponse['city']['coord']['lon'];

    List<Map<String, dynamic>> tempTime = (apiResponse['list'] as List).take(8).map((forecast) {
      DateTime dateTime = DateTime.parse(forecast['dt_txt']);

      String formattedTime = DateFormat.j().format(dateTime);

      return {
        'temp': forecast['main']['temp'].toInt(),
        'time': formattedTime,
      };
    }).toList();

    return ForeCastData(
      lat: latitude,
      long: longitude,
      tempTime: tempTime,
    );
  }
}
