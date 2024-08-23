import 'package:flutter/material.dart';
import 'package:weather_app/Home/Model/otherCitiesdata.dart';
import 'package:weather_app/Home/bloc/home_bloc.dart';

class OtherCitiesCard extends StatefulWidget {
  HomeBloc homeBloc;
  List<OtherCitiesDataModel> cities;
  int index;

  OtherCitiesCard({required this.homeBloc, required this.cities, required this.index});

  @override
  State<OtherCitiesCard> createState() => _OtherCitiesCardState();
}

class _OtherCitiesCardState extends State<OtherCitiesCard> {
  @override
  Widget build(BuildContext context) {
    bool isCurrentCity = widget.cities[widget.index].currentCity;

    return GestureDetector(
      onTap: () {
        widget.homeBloc.add(HomeChangeCityEvent(city: widget.cities[widget.index]));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0), // margin for spacing between cards
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15), // Adjust padding
        decoration: BoxDecoration(
          color: isCurrentCity ? null : Colors.white, // White background for non-current cities
          gradient: isCurrentCity
              ? LinearGradient(
                  colors: [Color(0xFF6F95FF), Color(0xFF003FFE)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.8],
                )
              : null,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Color(0x33003FFE), // 20-25% opacity
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, //  card size flow around the content
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.wb_sunny,
              color: isCurrentCity ? Colors.white : Color(0xCC003FFE), // White icon for current city, blue for others
              size: 30,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Center the text vertically
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.cities[widget.index].locationName,
                    style: TextStyle(
                      fontSize: 16, // Reduced font size
                      color: isCurrentCity
                          ? Colors.white
                          : Color(0xCC003FFE), // White text for current city, blue for others
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.cities[widget.index].weatherDescription,
                    style: TextStyle(
                      fontSize: 14, // Reduced font size
                      color: isCurrentCity
                          ? Colors.white70
                          : Color(0xCC003FFE).withOpacity(0.8), // White text for current city, blue for others
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Text(
              widget.cities[widget.index].currentTemperature.toString() + '°',
              style: TextStyle(
                fontSize: 20, // Reduced font size
                color: isCurrentCity ? Colors.white : Color(0xCC003FFE), // White text for current city, blue for others
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OtherCitiesSlider extends StatefulWidget {
  HomeBloc homeBloc;
  List<OtherCitiesDataModel> cities;

  OtherCitiesSlider({
    required this.homeBloc,
    required this.cities,
  });

  @override
  State<OtherCitiesSlider> createState() => _OtherCitiesSliderState();
}

class _OtherCitiesSliderState extends State<OtherCitiesSlider> {
  late PageController _pageController;
  late int initialPage;

  @override
  void initState() {
    // Intitalize when the app loads.
    super.initState();
    // Find the index of the current city
    initialPage = widget.cities.indexWhere((city) => city.currentCity);
    if (initialPage == -1) {
      initialPage = 0; // Default to the first city if no current city is found
    }

    _pageController = PageController(
      initialPage: initialPage,
      viewportFraction: 0.8,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Other Cities',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xCC003FFE),
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.add,
                color: Color(0xCC003FFE),
              ),
              onPressed: () {
                widget.homeBloc.add(SearchNavigationEvent());
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          // padding: EdgeInsets.symmetric(vertical: 20),
          child: SizedBox(
            child: PageView.builder(
              itemCount: widget.cities.length,
              controller: _pageController,
              itemBuilder: (context, index) {
                return OtherCitiesCard(
                  homeBloc: widget.homeBloc,
                  cities: widget.cities,
                  index: index,
                );
              },
            ),
            height: 80, // Reduceded height to avoid overflow
          ),
        ),
      ],
    );
  }
}
