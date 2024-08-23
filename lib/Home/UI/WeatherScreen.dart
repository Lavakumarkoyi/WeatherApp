import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/Home/UI/FutureWeatherForecast.dart';
import 'package:weather_app/Home/UI/WeatherCard.dart';
import 'package:weather_app/Home/UI/WeatherDetails.dart';
import 'package:weather_app/Home/UI/OtherCitiesCard.dart';
import 'package:weather_app/Home/UI/CurrentWeatherForecast.dart';
import 'package:weather_app/Home/bloc/home_bloc.dart';
import 'package:weather_app/Locations/UI/searchBar.dart';

class WeatherScreen extends StatefulWidget {
  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  HomeBloc homeBloc = HomeBloc();
  String selectedUnit = 'Celsius'; // Default temperature unit

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  void _onMenuItemSelected(String value) {
    setState(() {
      selectedUnit = value;
    });
    // To handle the Item change when Clicked on menubar
    _handleUnitChange(value);
  }

  void _handleUnitChange(String unit) {
    homeBloc.add(HomeMetricChangeEvent(units: unit));

    print('Temperature unit changed to $unit');
    // calling the to change the metric change
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(40),
      //   child: AppBar(
      //     // backgroundColor: Colors.red,
      //     elevation: 0,
      //     actions: [
      //       PopupMenuButton<String>(
      //         icon: Icon(Icons.more_vert, color: Colors.black),
      //         onSelected: _onMenuItemSelected,
      //         itemBuilder: (BuildContext context) {
      //           return {'Kelvin', 'Fahrenheit', 'Celsius'}.map((String choice) {
      //             return PopupMenuItem<String>(
      //               value: choice,
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Text(
      //                     choice,
      //                     style: TextStyle(color: Colors.blue),
      //                   ),
      //                   if (choice == selectedUnit)
      //                     Icon(
      //                       Icons.check,
      //                       color: Colors.blue,
      //                     ),
      //                 ],
      //               ),
      //             );
      //           }).toList();
      //         },
      //         color: Colors.white,
      //         shape: RoundedRectangleBorder(
      //           side: BorderSide(color: Colors.lightBlueAccent, width: 1),
      //           borderRadius: BorderRadius.circular(8),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),

      body: BlocConsumer<HomeBloc, HomeState>(
        bloc: homeBloc,
        listenWhen: (previous, current) => current is HomeActionState,
        buildWhen: (previous, current) => current is! HomeActionState,
        listener: (context, state) {
          if (state is SearchNavigationState) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SampleSearch()));
          } else if (state is NavigateForeCastState) {
            final successState = state as NavigateForeCastState;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FutureForecastScreen(
                          homeBloc: homeBloc,
                          futureForecastData: successState.futureForecastData,
                          units: successState.units,
                          latitude: successState.latitude,
                          longitude: successState.longitude,
                        )));
          } else if (state is BackToHomePageState) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => WeatherScreen()));
          }
        },
        builder: (context, state) {
          if (state.runtimeType == HomeSucessState) {
            final successState = state as HomeSucessState;
            return Column(
              children: [
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      PopupMenuButton<String>(
                        icon: Icon(Icons.more_vert, color: Colors.black),
                        onSelected: _onMenuItemSelected,
                        itemBuilder: (BuildContext context) {
                          return {'kelvin', 'fahrenheit', 'celsius'}.map((String choice) {
                            String value = '';
                            if (choice == "kelvin") {
                              value = "standard";
                            } else if (choice == "fahrenheit") {
                              value = "imperial";
                            } else {
                              value = "metric";
                            }
                            return PopupMenuItem<String>(
                              value: value,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    choice,
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  if (value == successState.units)
                                    Icon(
                                      Icons.check,
                                      color: Colors.blue,
                                    ),
                                ],
                              ),
                            );
                          }).toList();
                        },
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.lightBlueAccent, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                ),
                // const SizedBox(height: 20), // Adjusted to slightly push down

                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 40, right: 40, bottom: 0), // Padding for WeatherMainCard
                  child: WeatherMainCard(
                    homeBloc: homeBloc,
                    weatherData: successState.currentWeatherData,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0), // Padding for WeatherDetails
                  child: WeatherDetails(
                    homeBloc: homeBloc,
                    weatherData: successState.currentWeatherData,
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0.0), // No padding for WeatherForecast, making it full-width
                  child: WeatherForecast(
                    homeBloc: homeBloc,
                    foreCastData: successState.foreCastData,
                    // units : successState.units
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0), // Padding for OtherCitiesCard
                  child: OtherCitiesSlider(
                    homeBloc: homeBloc,
                    cities: successState.otherCities,
                  ),
                ),
              ],
            );
          } else if (state.runtimeType == HomeLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          } else {
            return Center(
              child: Text("App got Crashed"),
            );
          }
        },
      ),
    );
  }
}
