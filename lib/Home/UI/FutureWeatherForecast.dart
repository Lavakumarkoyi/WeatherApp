// Future Weather Forecast Screen

import 'package:flutter/material.dart';
import 'package:weather_app/Home/Model/futureForecastData.dart';
import 'package:weather_app/Home/UI/WeatherScreen.dart';
import 'package:weather_app/Home/bloc/home_bloc.dart';

class FutureForecastScreen extends StatefulWidget {
  HomeBloc homeBloc;
  FutureForecastData futureForecastData;
  String units;
  double latitude;
  double longitude;
  FutureForecastScreen(
      {required this.homeBloc,
      required this.futureForecastData,
      required this.units,
      required this.latitude,
      required this.longitude});

  @override
  State<FutureForecastScreen> createState() => _FutureForecastScreenState();
}

class _FutureForecastScreenState extends State<FutureForecastScreen> {
  String selectedUnit = 'Celsius';
  void _onMenuItemSelected(String value) {
    setState(() {
      selectedUnit = value;
    });
    // Funciton to update the UI based on the Unit value.
    _handleUnitChange(value);
  }

  void _handleUnitChange(String unit) {
    widget.homeBloc
        .add(FutureForeCastMetricChangeEvent(units: unit, latitude: widget.latitude, longitude: widget.longitude));

    print('Temperature unit changed to $unit');
    // Handling for unit change.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF003FFE)),
          onPressed: () {
            // Navigator.pop(context);
            print("called Back Button");
            // widget.homeBloc.add(BackToHomePage());
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WeatherScreen()),
            );
          },
        ),
        title: Text('5 - Day Forecasts', style: TextStyle(color: Color(0xFF003FFE))),
        centerTitle: true,
        actions: [
          // IconButton(
          //   icon: Icon(Icons.more_vert, color: Colors.blue),
          //   onPressed: () {},
          // ),
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
                      if (value == widget.units)
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          children: [
            // Main Weather Card
            Container(
              // padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF6F95FF),
                    Color.fromARGB(255, 53, 103, 255),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.8],
                ),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Tomorrow',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.wb_sunny, color: Colors.yellowAccent, size: 50),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.futureForecastData.locationName}",
                            // 'CHICAGO',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${widget.futureForecastData.dailyWeather[0]["weather_description"]}',
                            // 'Mostly Sunny',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${widget.futureForecastData.dailyWeather[0]["temp_max"]}°/${widget.futureForecastData.dailyWeather[0]["temp_min"]}°',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.grain, color: Colors.white),
                          SizedBox(height: 5),
                          Text(
                            '${widget.futureForecastData.dailyWeather[0]["precipitation"]}%',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Precipitation',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.water_drop, color: Colors.white),
                          SizedBox(height: 5),
                          Text(
                            '${widget.futureForecastData.dailyWeather[0]["humidity"]}%',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Humidity',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.air, color: Colors.white),
                          SizedBox(height: 5),
                          Text(
                            '${widget.futureForecastData.dailyWeather[0]["wind_speed"]} m/h',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Wind Speed',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Forecast List
            Expanded(
              child: ListView.builder(
                itemCount: widget.futureForecastData.dailyWeather.length,
                itemBuilder: (context, index) {
                  var dayWeather = widget.futureForecastData.dailyWeather[index];
                  return Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      _buildForecastItem(
                          dayWeather['day'],
                          Icons.wb_sunny, // Optionally, choose the icon based on weather data
                          dayWeather['weather_description'],
                          '${dayWeather['temp_max']}°/${dayWeather['temp_min']}°'),
                    ],
                  );
                },
                // sample UI to generate data with Hardcoded values. see top for List view builder for scroll Action.
                // children: [
                //   for(var i=1;i<futureForecastData.dailyWeather.length;i++){
                //     _buildForecastItem('Mon', Icons.wb_sunny, 'Mostly clear', '29°/20°');
                //   }
                // _buildForecastItem('Mon', Icons.wb_sunny, 'Mostly clear', '29°/20°'),
                // _buildForecastItem('Tue', Icons.cloud, 'Thunderstorms', '31°/20°'),
                // _buildForecastItem('Wed', Icons.foggy, 'With Fog', '19°/20°'),
                // _buildForecastItem('Thu', Icons.wb_sunny, 'Mostly clear', '19°/20°'),
                // _buildForecastItem('Fri', Icons.wb_sunny, 'Mostly clear', '19°/20°'),
                // _buildForecastItem('Sat', Icons.wb_sunny, 'Mostly clear', '19°/20°'),
                // _buildForecastItem('Sun', Icons.wb_sunny, 'Mostly clear', '19°/20°'),
                // ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForecastItem(String day, IconData icon, String description, String temperature) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0), // Increased padding between items
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // SizedBox(
          //   height: 20,
          // ),
          Text(day,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 97, 96, 96))),
          Row(
            children: [
              Icon(icon, color: Colors.yellow, size: 18),
              SizedBox(width: 10),
              Text(description, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF474747))),
            ],
          ),
          Text(temperature, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF474747))),
        ],
      ),
    );
  }
}
