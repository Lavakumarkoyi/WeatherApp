import 'package:flutter/material.dart';

class WeatherDetails extends StatefulWidget {
  // const WeatherDetails({super.key});

  // final homeBloc;
  final weatherData;

  WeatherDetails({required this.weatherData});

  @override
  State<WeatherDetails> createState() => _WeatherDetailsState();
}

class _WeatherDetailsState extends State<WeatherDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color(0x40003FFE), // 25% opacity color
            blurRadius: 20,
            offset: Offset(0, 4),
            spreadRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          WeatherDetailCard(
            icon: Icons.grain,
            value: '${(widget.weatherData.precipitation / 100).floor()}%',
            label: 'Precipitation',
          ),
          WeatherDetailCard(
            icon: Icons.opacity,
            value: '${widget.weatherData.humidity}%',
            label: 'Humidity',
          ),
          WeatherDetailCard(
            icon: Icons.air,
            value: '${widget.weatherData.windspeed} m/h',
            label: 'Wind Speed',
          ),
        ],
      ),
    );
  }
}

class WeatherDetailCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  WeatherDetailCard({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Color(0xCC003FFE), // 80% opacity color
          size: 30,
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            color: Color(0xCC003FFE), // 80% opacity color
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF608DC6), // Text color for label
          ),
        ),
      ],
    );
  }
}
