import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:weather_app/Home/UI/WeatherScreen.dart';
import 'package:weather_app/Locations/UI/bottomSheet/bottomSheet.dart';
import 'package:weather_app/Locations/UI/cityCard.dart';
import 'package:weather_app/Locations/bloc/search_bloc.dart';

class SampleSearch extends StatefulWidget {
  const SampleSearch({super.key});

  @override
  State<SampleSearch> createState() => _SampleSearchState();
}

class _SampleSearchState extends State<SampleSearch> {
  SearchBloc searchBloc = SearchBloc();

  @override
  void initState() {
    searchBloc.add(SearchIntialEvent());
    super.initState();
  }

  List<dynamic> _placeSuggestions = [];
  final String _apiKey = 'AIzaSyBJkr9HzDnHTPlvBvV-IcwSkW-YDoOKEAE';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Weather",
          style: TextStyle(fontSize: 40, color: Color.fromARGB(255, 55, 105, 255), fontWeight: FontWeight.bold),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60), // Placeholder space for the floating search bar
                const Text(
                  "Other Cities",
                  style: TextStyle(fontSize: 18, color: Color(0xFF003FFE), fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: BlocConsumer<SearchBloc, SearchState>(
                    bloc: searchBloc,
                    listenWhen: (previous, current) => current is SearchActionState,
                    buildWhen: (previous, current) => current is! SearchActionState,
                    listener: (context, state) {
                      if (state.runtimeType == BottomSheetIntialState) {
                        showWeatherBottomSheet(context, searchBloc);
                      } else if (state.runtimeType == NavigateToHomeState) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => WeatherScreen()));
                      }
                    },
                    builder: (context, state) {
                      if (state is SearchSuccessState) {
                        final successState = state as SearchSuccessState;
                        return ListView(
                          children: successState.cityData
                              .map((e) => CityCard(
                                    city: e,
                                    searchBloc: searchBloc,
                                  ))
                              .toList(),
                          // CityCard(),
                          // CityCard(),
                          // CityCard(),
                        );
                      } else {
                        return Center(
                          child: Text(
                            "No Cities Found",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          buildFloatingSearchBar(context),
        ],
      ),
    );
  }

  Widget buildFloatingSearchBar(context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        // print("query Changed..........................................");
        _getPlaceSuggestions(query);
      },
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: _placeSuggestions.map((place) {
                return ListTile(
                  leading: const Icon(Icons.location_on, color: Colors.blue),
                  title: Text(place['description'] ?? ''),
                  onTap: () async {
                    // Handle the location selection
                    List<double> coordinates = await _getPlaceDetails(place['place_id']);
                    // showWeatherBottomSheet(context);
                    searchBloc.add(BottomSheetIntialEvent(lat: coordinates[0], long: coordinates[1]));
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Future<void> _getPlaceSuggestions(String query) async {
    if (query.isEmpty) {
      setState(() {
        _placeSuggestions = [];
      });
      return;
    }

    final url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=$_apiKey&components=country:us'; // You can adjust the country code or add more parameters as needed.

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      setState(() {
        _placeSuggestions = json['predictions'];
      });
      print(json);
    } else {
      throw Exception('Failed to load place suggestions');
    }
  }

  Future<List<double>> _getPlaceDetails(String placeId) async {
    final url = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$_apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final location = json['result']['geometry']['location'];
      final double latitude = location['lat'];
      final double longitude = location['lng'];

      // Now you have the latitude and longitude
      // print('Latitude: $latitude, Longitude: $longitude');
      return [latitude, longitude];
    } else {
      throw Exception('Failed to load place details');
    }
  }
}
