import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weather_app/FireStoreService/fireStore.dart';

FirestoreService fireStoreInstance = FirestoreService.instance;

class AddCity {
  static Future<void> addCityToFirebase(double lat, double long) async {
    try {
      CollectionReference savedCities = fireStoreInstance.firestore.collection('savedCities');

      await savedCities.add({
        'latitude': lat,
        'longitude': long,
        'currentCity': false, // Default value
      });
    } catch (e) {
      print("Failed to Add the city to FireStore");
    }
  }
}
