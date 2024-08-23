import 'dart:convert';
import 'package:flutter/foundation.dart';

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

  @override
  bool operator ==(covariant ForeCastData other) {
    if (identical(this, other)) return true;

    return other.lat == lat && other.long == long && listEquals(other.tempTime, tempTime);
  }

  @override
  int get hashCode => lat.hashCode ^ long.hashCode ^ tempTime.hashCode;

  factory ForeCastData.fromApiResponse(Map<String, dynamic> apiResponse) {
    double latitude = apiResponse['city']['coord']['lat'];
    double longitude = apiResponse['city']['coord']['lon'];

    // Get the first 8 objects from the list (for 24 hours)
    List<Map<String, dynamic>> tempTime = (apiResponse['list'] as List)
        .take(8)
        .map((forecast) => {
              'temp': forecast['main']['temp'],
              'time': forecast['dt_txt'], // Or convert to a more readable format
            })
        .toList();

    return ForeCastData(
      lat: latitude,
      long: longitude,
      tempTime: tempTime,
    );
  }
}
