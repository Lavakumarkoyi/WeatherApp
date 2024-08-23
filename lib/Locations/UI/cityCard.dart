// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:weather_app/Home/Model/otherCitiesdata.dart';
import 'package:weather_app/Locations/bloc/search_bloc.dart';

class CityCard extends StatefulWidget {
  OtherCitiesDataModel city;
  SearchBloc searchBloc;
  CityCard({
    Key? key,
    required this.city,
    required this.searchBloc,
  }) : super(key: key);

  @override
  State<CityCard> createState() => _CityCardState();
}

class _CityCardState extends State<CityCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.searchBloc.add(
            NavigateToHomeEvent(latitude: double.parse(widget.city.lat), longitude: double.parse(widget.city.long)));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            colors: [Color(0xFF6F95FF), Color(0xFF003FFE)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.wb_sunny, color: Colors.white, size: 30),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.city.locationName}",
                    // "City Name"
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${widget.city.weatherDescription}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              // '${widget.city.currentTemperature}',
              "${widget.city.currentTemperature}°",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
