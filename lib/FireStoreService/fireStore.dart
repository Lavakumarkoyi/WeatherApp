import 'package:cloud_firestore/cloud_firestore.dart';

// Singleton class to access the firestore instance anywhere in the applicaiton, this how database connections are created in API's using singleton desing pattern.please visit Repos folder for API implementation.

class FirestoreService {
  FirestoreService._privateConstructor();

  static final FirestoreService _instance = FirestoreService._privateConstructor();

  static FirestoreService get instance => _instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseFirestore get firestore => _firestore;

  Future<List<Map<String, dynamic>>> fetchAllCities() async {
    QuerySnapshot querySnapshot = await _firestore.collection("savedCities").get();
    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  Future<String> fetchUnits() async {
    DocumentReference<Map<String, dynamic>> documentSnapshot =
        await _firestore.collection("settings").doc("settingsDoc");

    DocumentSnapshot docSnapshot = await documentSnapshot.get();
    String currentMetric = docSnapshot.get('metric');

    if (currentMetric.isNotEmpty) {
      return currentMetric;
    } else {
      return 'fahrenheit';
    }

    // String metric = documentSnapshot.get('metric');
  }
}
