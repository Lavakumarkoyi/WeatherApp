import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/Home/Model/forecastData.dart';
import 'package:weather_app/Home/Model/otherCitiesdata.dart';
import 'package:weather_app/Home/data/otherCitiesdata.dart';

import 'package:weather_app/Home/Model/currentWeatherdata.dart';
import 'package:weather_app/Home/repos/weatherApi.dart';
import 'package:weather_app/Locations/repos/addCityApi.dart';
import 'package:weather_app/FireStoreService/fireStore.dart';

// import 'package:weather_app/Home/Model/otherCitiesdata.dart';
// import 'package:weather_app/Home/data/otherCitiesdata.dart';

part 'search_event.dart';
part 'search_state.dart';

FirestoreService fireStoreInstance = FirestoreService.instance;

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitialState()) {
    on<SearchIntialEvent>(searchIntitalEvent);
    on<BottomSheetIntialEvent>(bottomSheetIntialEvent);
    on<AddCityEvent>(addCityEvent);
    on<NavigateToHomeEvent>(navigateToHome);
  }

  // To return search success state function when emitting SearchSuccess state.

  Future<SearchSuccessState> allCities() async {
    List<OtherCitiesDataModel> finalCities = [];

    try {
      List currentCities = await WeatherRepo.OtherCities();
      String units = await fireStoreInstance.fetchUnits();

      for (var city in currentCities) {
        if (city['latitude'] != null && city['longitude'] != null) {
          var weatherData = await WeatherRepo.fetchWeatherData(
            city['latitude'],
            city['longitude'],
            units,
          );

          finalCities.add(OtherCitiesDataModel(
            lat: city['latitude'].toString(),
            long: city['longitude'].toString(),
            locationName: weatherData.locationName,
            currentTemperature: weatherData.currentTemperature,
            weatherDescription: weatherData.weatherDescription,
            currentCity: city['currentCity'],
          ));
        }
      }

      return SearchSuccessState(cityData: finalCities);

      // emit(SearchSuccessState(cityData: finalCities));
    } catch (e) {
      print(e);
      return SearchSuccessState(cityData: finalCities);
    }
  }

  // called to Loadint the intial search page

  FutureOr<void> searchIntitalEvent(SearchIntialEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());

    // List currentCities = await WeatherRepo.OtherCities();
    // String units = await fireStoreInstance.fetchUnits();
    // List<OtherCitiesDataModel> finalCities = [];

    emit(await allCities());
  }

  // called to popup the intial bottomsheet

  FutureOr<void> bottomSheetIntialEvent(BottomSheetIntialEvent event, Emitter<SearchState> emit) async {
    emit(BottomSheetIntialState());

    emit(BottomSheetLoadingState());

    double latitude = event.lat;
    double longitude = event.long;

    var client = http.Client();
    List<OtherCitiesDataModel> finalCities = [];
    String units = "fahrenheit";
    CurrentWeatherdataModel currentWeatherData = CurrentWeatherdataModel(
      currentTemperature: 0,
      highTemperature: 0,
      lowTemperature: 0,
      precipitation: 0,
      humidity: 0,
      windspeed: 0,
      weatherDescription: "",
      locationName: "No City Found",
    );
    ForeCastData forecastData = ForeCastData(lat: 0.0, long: 0.0, tempTime: []);

    try {
      // List currentCities = await WeatherRepo.OtherCities();
      String units = await fireStoreInstance.fetchUnits();
      CurrentWeatherdataModel weatherData = await WeatherRepo.fetchWeatherData(
        latitude,
        longitude,
        units,
      );

      ForeCastData forecastData = await WeatherRepo.hourlyForeCast(
        latitude,
        longitude,
        units,
      );

      emit(BottomSheetSuccessState(
          currentWeatherData: weatherData, forecastData: forecastData, lat: latitude, long: longitude));
    } catch (e) {
      print(e);
      emit(BottomSheetSuccessState(
          currentWeatherData: currentWeatherData, forecastData: forecastData, lat: latitude, long: longitude));
    }

    // emit(BottomSheetSuccessState(currentWeatherData: weatherData, lat: latitude, long: longitude));
  }

  // To add New City to the Whishlist

  FutureOr<void> addCityEvent(AddCityEvent event, Emitter<SearchState> emit) async {
    double latitude = event.lat;
    double longitude = event.long;

    await AddCity.addCityToFirebase(latitude, longitude);

    emit(await allCities());
  }

  // To move back to the home when I click on a new city.

  FutureOr<void> navigateToHome(NavigateToHomeEvent event, Emitter<SearchState> emit) async {
    await WeatherRepo.updateFalseCityStatus();
    await WeatherRepo.updateTrueCityStatus(event.latitude, event.longitude);
    emit(NavigateToHomeState());
  }
}
