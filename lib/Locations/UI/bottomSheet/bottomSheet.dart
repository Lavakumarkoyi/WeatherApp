import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/Home/Model/currentWeatherdata.dart';
// import 'package:weather_app/Home/UI/CurrentWeatherForecast.dart';
// import 'package:weather_app/Home/UI/WeatherDetails.dart';
import 'package:weather_app/Locations/UI/bottomSheet/weatherCard.dart';
import 'package:weather_app/Locations/UI/bottomSheet/weatherDetails.dart';
import 'package:weather_app/Locations/UI/bottomSheet/weatherForecast.dart';
import 'package:weather_app/Locations/bloc/search_bloc.dart';

void showWeatherBottomSheet(BuildContext context, SearchBloc searchBloc) {
  // CurrentWeatherdataModel weatherData = CurrentWeatherdataModel(
  //   currentTemperature: 20,
  //   highTemperature: 80,
  //   lowTemperature: 60,
  //   precipitation: 60,
  //   humidity: 80,
  //   windspeed: 100,
  //   weatherDescription: "Cloudy",
  //   locationName: "Bloomington",
  //   // required this.currentCity,
  // );
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    builder: (context) {
      return Container(
        // width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.85,
        width: MediaQuery.of(context).size.height * 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: BlocConsumer<SearchBloc, SearchState>(
            bloc: searchBloc,
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state.runtimeType == BottomSheetSuccessState) {
                final successState = state as BottomSheetSuccessState;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Top Row with Add and Cancel
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Call the add function and close the sheet
                            // addFunction();
                            searchBloc.add(AddCityEvent(lat: successState.lat, long: successState.long));
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Add',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Close the bottom sheet
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Weather Info Container
                    // Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(20),
                    //     gradient: LinearGradient(
                    //       colors: [
                    //         Colors.blue.shade400,
                    //         Colors.blue.shade200,
                    //       ],
                    //       begin: Alignment.topCenter,
                    //       end: Alignment.bottomCenter,
                    //     ),
                    //   ),
                    //   padding: EdgeInsets.all(20),
                    //   child: Column(
                    //     children: [
                    //       Text(
                    //         'CHICAGO',
                    //         style: TextStyle(
                    //           color: Colors.white,
                    //           fontSize: 24,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //       Text(
                    //         'Mostly Sunny',
                    //         style: TextStyle(
                    //           color: Colors.white70,
                    //           fontSize: 16,
                    //         ),
                    //       ),
                    //       SizedBox(height: 10),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             '24°',
                    //             style: TextStyle(
                    //               color: Colors.white,
                    //               fontSize: 60,
                    //               fontWeight: FontWeight.bold,
                    //             ),
                    //           ),
                    //           SizedBox(width: 10),
                    //           Icon(
                    //             Icons.wb_sunny,
                    //             color: Colors.yellowAccent,
                    //             size: 50,
                    //           ),
                    //         ],
                    //       ),
                    //       SizedBox(height: 10),
                    //       Text(
                    //         'H:80°   L:62°',
                    //         style: TextStyle(
                    //           color: Colors.white,
                    //           fontSize: 16,
                    //         ),
                    //       ),
                    //       SizedBox(height: 20),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //         children: [
                    //           Column(
                    //             children: [
                    //               Icon(Icons.grain, color: Colors.white),
                    //               SizedBox(height: 5),
                    //               Text(
                    //                 '90%',
                    //                 style: TextStyle(
                    //                   color: Colors.white,
                    //                   fontSize: 16,
                    //                 ),
                    //               ),
                    //               Text(
                    //                 'Precipitation',
                    //                 style: TextStyle(
                    //                   color: Colors.white70,
                    //                   fontSize: 14,
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //           Column(
                    //             children: [
                    //               Icon(Icons.water_drop, color: Colors.white),
                    //               SizedBox(height: 5),
                    //               Text(
                    //                 '90%',
                    //                 style: TextStyle(
                    //                   color: Colors.white,
                    //                   fontSize: 16,
                    //                 ),
                    //               ),
                    //               Text(
                    //                 'Humidity',
                    //                 style: TextStyle(
                    //                   color: Colors.white70,
                    //                   fontSize: 14,
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //           Column(
                    //             children: [
                    //               Icon(Icons.air, color: Colors.white),
                    //               SizedBox(height: 5),
                    //               Text(
                    //                 '12 m/h',
                    //                 style: TextStyle(
                    //                   color: Colors.white,
                    //                   fontSize: 16,
                    //                 ),
                    //               ),
                    //               Text(
                    //                 'Wind Speed',
                    //                 style: TextStyle(
                    //                   color: Colors.white70,
                    //                   fontSize: 14,
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    WeatherMainCard(weatherData: successState.currentWeatherData),
                    SizedBox(height: 20),
                    WeatherDetails(
                      weatherData: successState.currentWeatherData,
                    ),
                    // Today's Forecast
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Today's Forecast",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //     _buildForecastCard('19°', '12 PM'),
                    //     _buildForecastCard('24°', 'Now', isCurrent: true),
                    //     _buildForecastCard('19°', '12 PM'),
                    //     _buildForecastCard('19°', '12 PM'),
                    //   ],
                    // ),
                    WeatherForecast(
                      foreCastData: successState.forecastData,
                    ),
                    SizedBox(height: 20),
                  ],
                );
              } else if (state.runtimeType == BottomSheetLoadingState) {
                return Center(
                  child: (CircularProgressIndicator(
                    color: Colors.blue,
                  )),
                );
              } else {
                return (Center(
                  child: Text(
                    'Error Loading the City',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ));
              }
            },
          ),
        ),
      );
    },
  );
}

Widget _buildForecastCard(String temperature, String time, {bool isCurrent = false}) {
  return Container(
    decoration: BoxDecoration(
      color: isCurrent ? Colors.blue.shade100 : Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    ),
    padding: EdgeInsets.all(10),
    child: Column(
      children: [
        Text(
          temperature,
          style: TextStyle(
            color: isCurrent ? Colors.blue : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          time,
          style: TextStyle(
            color: isCurrent ? Colors.blue : Colors.grey,
            fontSize: 14,
          ),
        ),
      ],
    ),
  );
}
