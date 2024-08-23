import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weather_app/Home/Model/currentWeatherdata.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/Home/Model/forecastData.dart';
import 'package:weather_app/Home/Model/futureForecastData.dart';
import 'package:weather_app/Home/Model/otherCitiesdata.dart';
import 'package:weather_app/Home/data/otherCitiesdata.dart';
import 'package:weather_app/FireStoreService/fireStore.dart';

// To handle all the firestore instances from FireStoreSerive Singleton Folder.

FirestoreService fireStoreInstance = FirestoreService.instance;
var client = http.Client();

class WeatherRepo {
  static Future<CurrentWeatherdataModel> fetchWeatherData(double latitude, double longitude, String units) async {
    try {
      var response = await client.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/weather?lat=${latitude}&lon=${longitude}&units=${units}&appid=8d2d9698b49ce9ab901fdd9ef70f0745'),
      );
      var newResponse = jsonDecode(response.body);
      // print("Response ${newResponse}");
      CurrentWeatherdataModel weatherData = CurrentWeatherdataModel.fromMap(newResponse);
      return weatherData;
    } catch (e) {
      print(e.toString());
      return CurrentWeatherdataModel(
          currentTemperature: 0,
          highTemperature: 0,
          lowTemperature: 0,
          precipitation: 0,
          humidity: 0,
          windspeed: 0,
          weatherDescription: '',
          locationName: '');
    }
  }

  //To get all the saved other cities for bottom scroll bar

  static Future<List> OtherCities() async {
    try {
      QuerySnapshot querySnapshot = await fireStoreInstance.firestore.collection("savedCities").get();
      final allData = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      return allData;
    } catch (e) {
      print(e);
      return [];
    }
  }

  // To update all the cities to false in firebase, when a new clicked in UI

  static Future<void> updateFalseCityStatus() async {
    CollectionReference cities = fireStoreInstance.firestore.collection("savedCities");
    QuerySnapshot querySnapshot = await cities.where('currentCity', isEqualTo: true).get();
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      await cities.doc(doc.id).update({'currentCity': false});
    }
  }

  // To update new city to true when the UI is clicked.

  static Future<void> updateTrueCityStatus(double latitude, double longitude) async {
    // print("lat and long in main func...... $latitude.........$longitude");
    CollectionReference cities = fireStoreInstance.firestore.collection("savedCities");
    QuerySnapshot querySnapshot =
        await cities.where('latitude', isEqualTo: latitude).where('longitude', isEqualTo: longitude).get();
    if (querySnapshot.docs.isNotEmpty) {
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await cities.doc(doc.id).update({'currentCity': true});
      }
    } else {
      print('No document found with the given latitude and longitude.');
    }
  }

  // To get the hourly forecast data from API call

  static Future<ForeCastData> hourlyForeCast(double latitude, double longitude, String units) async {
    var response = await client.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?lat=${latitude}&lon=${longitude}&appid=8d2d9698b49ce9ab901fdd9ef70f0745&units=${units}'),
    ); // we can additional parameters if requited
    var newResponse = jsonDecode(response.body);

    return ForeCastData.fromApiResponse(newResponse);
  }

  // To the daily future forecast data, same API I called it twice.

  static Future<FutureForecastData> dailyFutureForeCast(double latitude, double longitude, String units) async {
    var response = await client.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?lat=${latitude}&lon=${longitude}&appid=8d2d9698b49ce9ab901fdd9ef70f0745&units=${units}'),
    );
    var newResponse = jsonDecode(response.body);

    return FutureForecastData.fromJson(newResponse);
  }

  static Future<bool> changeMetric(String units) async {
    DocumentReference settingsDoc = fireStoreInstance.firestore.collection('settings').doc('settingsDoc');

    DocumentSnapshot docSnapshot = await settingsDoc.get();
    String? currentMetric = docSnapshot.get('metric');

    if (currentMetric != units) {
      // Update the 'metric' field if it's different
      await settingsDoc.update({'metric': units});
      return true;
    }

    return false;
    // await settings.update({'metric' : units});
  }
}
