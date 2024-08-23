import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/Home/UI/FutureWeatherForecast.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:weather_app/Counter/bloc/counter_bloc.dart';
import 'package:weather_app/Home/UI/WeatherScreen.dart';
import 'package:weather_app/Locations/UI/searchBar.dart';
// import 'package:weather_app/Locations/UI/sample/searchLocation.dart';
import 'package:weather_app/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Checking if any cities are added previously, if any added redirect to weather screen, or to search screen.

  try {
    bool hasCurrentCity = await checkIfCurrentCityExists();
    runApp(MaterialApp(
      title: 'WeatherApp',
      home: hasCurrentCity ? WeatherScreen() : SampleSearch(),
      debugShowCheckedModeBanner: false,
    ));
  } catch (e) {
    runApp(MaterialApp(title: 'WeatherApp', home: Text("App got Crashed")));
  }
}

// Checking in firebase if any city exitst.

Future<bool> checkIfCurrentCityExists() async {
  try {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('savedCities').where('currentCity', isEqualTo: true).get();
    return querySnapshot.docs.isNotEmpty;
  } catch (e) {
    print("Error checking Firestore: $e");
    return false;
  }
}

// class WeatherApp extends StatelessWidget {
//   const WeatherApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: WeatherScreen(),
//     );
//   }
// }
