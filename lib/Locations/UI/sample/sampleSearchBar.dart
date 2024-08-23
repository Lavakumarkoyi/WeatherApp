// import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
// import 'package:flutter/material.dart';
// import 'package:weather_app/Locations/UI/cityCard.dart';

// class SampleSearch extends StatefulWidget {
//   const SampleSearch({super.key});

//   @override
//   State<SampleSearch> createState() => _SampleSearchState();
// }

// class _SampleSearchState extends State<SampleSearch> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Weather",
//           style: TextStyle(fontSize: 40, color: Color.fromARGB(255, 55, 105, 255), fontWeight: FontWeight.bold),
//         ),
//       ),
//       resizeToAvoidBottomInset: false,
//       body: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 60), // Placeholder space for the floating search bar
//                 const Text(
//                   "Other Cities",
//                   style: TextStyle(fontSize: 18, color: Color(0xFF003FFE), fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 10),
//                 Expanded(
//                   child: ListView(
//                     children: [
//                       CityCard(),
//                       CityCard(),
//                       CityCard(),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           buildFloatingSearchBar(),
//         ],
//       ),
//     );
//   }

//   Widget buildFloatingSearchBar() {
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
//         // Call your model, bloc, controller here.
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
//               children: Colors.accents.map((color) {
//                 return Container(height: 112, color: color);
//               }).toList(),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
