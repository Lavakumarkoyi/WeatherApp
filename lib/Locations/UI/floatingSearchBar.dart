// import 'package:flutter/material.dart';
// import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
// import 'package:weather_app/Locations/repos/searchApi.dart';

// Widget buildFloatingSearchBar(BuildContext context) {
//     final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

//     return FloatingSearchBar(
//       hint: 'Search...',
//       scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
//       transitionDuration: const Duration(milliseconds: 800),
//       transitionCurve: Curves.easeInOut,
//       physics: const BouncingScrollPhysics(),
//       axisAlignment: isPortrait ? 0.0 : -1.0,
//       openAxisAlignment: 0.0,
//       width: isPortrait ? 600 : 500,
//       debounceDelay: const Duration(milliseconds: 500),
//       onQueryChanged: (query) {
//         // print("query Changed..........................................");
//         _getPlaceSuggestions(query);
//       },
//       transition: CircularFloatingSearchBarTransition(),
//       actions: [
//         FloatingSearchBarAction(
//           showIfOpened: false,
//           child: CircularButton(
//             icon: const Icon(Icons.place),
//             onPressed: () {},
//           ),
//         ),
//         FloatingSearchBarAction.searchToClear(
//           showIfClosed: false,
//         ),
//       ],
//       builder: (context, transition) {
//         return ClipRRect(
//           borderRadius: BorderRadius.circular(8),
//           child: Material(
//             color: Colors.white,
//             elevation: 4.0,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: _placeSuggestions.map((place) {
//                 return ListTile(
//                   leading: const Icon(Icons.location_on, color: Colors.blue),
//                   title: Text(place['description'] ?? ''),
//                   onTap: () async {
//                     // Handle the location selection
//                     List<double> coordinates = await _getPlaceDetails(place['place_id']);
//                     // showWeatherBottomSheet(context);
//                     searchBloc.add(BottomSheetIntialEvent(lat: coordinates[0], long: coordinates[1]));
//                   },
//                 );
//               }).toList(),
//             ),
//           ),
//         );
//       },
//     );
//   }
