// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:weather_app/Home/Model/forecastData.dart';
import 'package:weather_app/Home/bloc/home_bloc.dart';

class WeatherForecast extends StatefulWidget {
  // const WeatherForecast({super.key});

  HomeBloc homeBloc;
  ForeCastData foreCastData;
  // String units,
  WeatherForecast({
    Key? key,
    required this.homeBloc,
    required this.foreCastData,
    // required this.units
  }) : super(key: key);

  @override
  State<WeatherForecast> createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Today',
                style:
                    TextStyle(fontSize: 18, color: Color(0xCC003FFE), fontWeight: FontWeight.w600 // 80% opacity color
                        ),
              ),
              GestureDetector(
                onTap: () {
                  widget.homeBloc.add(
                      ForeCastNavigationEvent(latitude: widget.foreCastData.lat, longitude: widget.foreCastData.long));
                },
                child: Text(
                  '7-days Forecast >',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xCC003FFE), // 80% opacity color
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 120, // Adjust the height to fit your cards
          child: PageView.builder(
            controller: PageController(viewportFraction: 0.23),
            itemCount: widget.foreCastData.tempTime.length, // Number of forecast days
            itemBuilder: (context, index) {
              // Replace this with your own logic to determine which card is "current"
              bool isCurrent = false;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ForecastCard(
                  time: widget.foreCastData.tempTime[index]['time'], // Replace with your own logic
                  temperature: '${widget.foreCastData.tempTime[index]['temp']}°',
                  icon: Icons.wb_sunny,
                  isCurrent: isCurrent, // This will apply the gradient and white text
                  // I made it to false to dispaly it in white, if you make it true it will display with gradient.
                  // code in a sense that I might display today weather box with color and rest with white
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ForecastCard extends StatelessWidget {
  final String time;
  final String temperature;
  final IconData icon;
  final bool isCurrent;

  ForecastCard({required this.time, required this.temperature, required this.icon, this.isCurrent = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 40,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: isCurrent
            ? LinearGradient(
                colors: [Color(0xFF003FFE), Color(0xFF6F95FF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 0.8],
              )
            : null,
        color: isCurrent ? null : Colors.white,
        border: Border.all(
          color: Color(0x33396AFE), // Stroke color with 20% opacity
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color(0x401A68FF), // 25% opacity color
            blurRadius: 10,
            offset: Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            time,
            style: TextStyle(
              fontSize: 14,
              color: isCurrent ? Colors.white : Color(0xCC003FFE), // Text color depending on the state
            ),
          ),
          SizedBox(height: 5),
          Icon(
            icon,
            color: isCurrent ? Colors.white : Color(0xCC003FFE), // Icon color depending on the state
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                temperature,
                style: TextStyle(
                  fontSize: 18,
                  color: isCurrent ? Colors.white : Color(0xCC003FFE), // Temperature color depending on the state
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
