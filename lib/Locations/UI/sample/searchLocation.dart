// import 'package:flutter/material.dart';
// // import 'package:flutter_google_places/flutter_google_places.dart';
// // import 'package:google_placesflutter'
// // import 'package:google_places_flutter/google_places_flutter.dart';
// // import 'package:google_places_flutter/google_places_flutter.dart';
// // import 'package:google_maps_webservice/places.dart';
// import 'package:weather_app/Locations/UI/cityCard.dart';

// class SearchLocationScreen extends StatefulWidget {
//   @override
//   _SearchLocationScreenState createState() => _SearchLocationScreenState();
// }

// class _SearchLocationScreenState extends State<SearchLocationScreen> {
//   // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//   // GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: 'AIzaSyBJkr9HzDnHTPlvBvV-IcwSkW-YDoOKEAE');

//   // void _handleSearchTap() async {
//   //   try {
//   //     Prediction? p = await PlacesAutocomplete.show(
//   //       context: context,
//   //       apiKey: 'AIzaSyBJkr9HzDnHTPlvBvV-IcwSkW-YDoOKEAE',
//   //       mode: Mode.overlay, // or Mode.fullscreen
//   //       language: "en",
//   //       components: [Component(Component.country, "us")],
//   //     );
//   //     // if (p != null) {
//   //     //   _showBottomSheet(p);
//   //     // }
//   //   } catch (e) {
//   //     print(
//   //         "Error while autoComplete-------------------------------------------------------------------------------- : ${e}");
//   //   }
//   // }

//   // void _showBottomSheet(Prediction p) {
//   //   showModalBottomSheet(
//   //     context: context,
//   //     builder: (context) {
//   //       return Container(
//   //         height: 200,
//   //         padding: const EdgeInsets.all(16.0),
//   //         child: Column(
//   //           crossAxisAlignment: CrossAxisAlignment.start,
//   //           children: [
//   //             const Text(
//   //               "Selected Location",
//   //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//   //             ),
//   //             const SizedBox(height: 10),
//   //             Text(p.description ?? "No description available"),
//   //           ],
//   //         ),
//   //       );
//   //     },
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // key: scaffoldKey,
//       appBar: AppBar(
//         title: const Text(
//           "Weather",
//           style: TextStyle(fontSize: 40, color: Color.fromARGB(255, 55, 105, 255), fontWeight: FontWeight.bold),
//         ),

//         // backgroundColor: const Color(0xFF003FFE),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Search Bar
//             GestureDetector(
//               // onTap: _handleSearchTap,
//               onTap: () {},
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10.0),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 6.0,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   children: const [
//                     Icon(Icons.search, color: Colors.blue),
//                     SizedBox(width: 8.0),
//                     Text("Search for a city"),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             // List of Other Cities
//             const Text(
//               "Other Cities",
//               style: TextStyle(fontSize: 18, color: Color(0xFF003FFE), fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//               child: ListView(
//                 children: [
//                   CityCard(),
//                   CityCard(),
//                   CityCard(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class LocationSearch extends SearchDelegate<String> {
//   List<String> cities = ["Paris", "Berlin", "London", "Delhi", "Chicago"];

//   List<String> recentCities = ["Paris", "Chicago"];
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     // TODO: implement buildActions
//     throw UnimplementedError();
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     // TODO: implement buildLeading
//     throw UnimplementedError();
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     // TODO: implement buildResults
//     throw UnimplementedError();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // TODO: implement buildSuggestions
//     throw UnimplementedError();
//   }
// }
