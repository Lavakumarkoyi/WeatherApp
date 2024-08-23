import 'package:flutter/material.dart';
import 'package:weather_app/Home/Model/currentWeatherdata.dart';
// import 'package:weather_app/Home/bloc/home_bloc.dart';

class WeatherMainCard extends StatefulWidget {
  @override
  State<WeatherMainCard> createState() => _WeatherMainCardState();

  // final HomeBloc homeBloc;
  final CurrentWeatherdataModel weatherData;

  WeatherMainCard({
    // required this.homeBloc,
    required this.weatherData,
  });
}

class _WeatherMainCardState extends State<WeatherMainCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [Color(0xFF6F95FF), Color(0xFF003FFE)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.8],
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x400052F1), // 25% opacity color
            blurRadius: 42,
            offset: Offset(0, 4),
            spreadRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            '${widget.weatherData.locationName}',
            // 'BLOOMINGTON',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.w400, // FontWeight.w400 corresponds to "Regular"
            ),
          ),
          Text(
            '${widget.weatherData.weatherDescription}',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${widget.weatherData.currentTemperature}°',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 48,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    BoxShadow(
                      color: Colors.white, // 25% opacity black
                      blurRadius: 100,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white, // 25% opacity black
                      blurRadius: 80,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.wb_sunny,
                  color: Colors.amber,
                  size: 40,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'H:${widget.weatherData.highTemperature}°',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 20),
              Text(
                'L:${widget.weatherData.lowTemperature}°',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
