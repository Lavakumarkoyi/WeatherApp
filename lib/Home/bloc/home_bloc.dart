import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/Home/Model/forecastData.dart';
import 'package:weather_app/Home/Model/futureForecastData.dart';
import 'package:weather_app/Home/Model/otherCitiesdata.dart';
import 'package:weather_app/Home/data/otherCitiesdata.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/Home/Model/currentWeatherdata.dart';
import 'package:weather_app/Home/repos/weatherApi.dart';
import 'package:weather_app/FireStoreService/fireStore.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeIntial);
    on<HomeChangeCityEvent>(homeChangeCity);
    on<HomeMetricChangeEvent>(homeMetricChangeEvent);
    on<SearchNavigationEvent>(searchNavigation);
    on<ForeCastNavigationEvent>(foreCastNavigation);
    on<FutureForeCastMetricChangeEvent>(futureForecastMetricChange);
    on<BackToHomePage>(backToHomePage);
  }

  Future<HomeSucessState> HomeFinalData() async {
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
    // FutureForecastData futureForecastData = FutureForecastData(locationName: "", dailyWeather: []);

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

          if (city['currentCity']) {
            currentWeatherData = weatherData;
            forecastData = await WeatherRepo.hourlyForeCast(
              city['latitude'],
              city['longitude'],
              units,
            );
            // futureForecastData = await WeatherRepo.dailyFutureForeCast(city['latitude'], city['longitude'], units);

            // print(futureForecastData);
          }

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

      return HomeSucessState(
          currentWeatherData: currentWeatherData, otherCities: finalCities, foreCastData: forecastData, units: units);
    } catch (e) {
      print(e);
      return HomeSucessState(
          currentWeatherData: currentWeatherData, otherCities: finalCities, foreCastData: forecastData, units: units);
    }
  }

  FutureOr<void> homeIntial(HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());

    emit(await HomeFinalData());
  }

  FutureOr<void> homeChangeCity(HomeChangeCityEvent event, Emitter<HomeState> emit) async {
    double latitude = double.parse(event.city.lat);
    double longitude = double.parse(event.city.long);

    await WeatherRepo.updateFalseCityStatus();

    await WeatherRepo.updateTrueCityStatus(latitude, longitude);

    // emit(HomeSucessState(currentWeatherData: currentWeatherData, otherCities: finalCities, foreCastData: forecastData));

    emit(await HomeFinalData());
  }

  FutureOr<void> homeMetricChangeEvent(HomeMetricChangeEvent event, Emitter<HomeState> emit) async {
    bool changed = await WeatherRepo.changeMetric(event.units);

    if (changed) {
      emit(await HomeFinalData());
    }
  }

  FutureOr<void> searchNavigation(SearchNavigationEvent event, Emitter<HomeState> emit) {
    emit(SearchNavigationState());
  }

  FutureOr<void> foreCastNavigation(ForeCastNavigationEvent event, Emitter<HomeState> emit) async {
    String units = await fireStoreInstance.fetchUnits();
    FutureForecastData futureForecastData =
        await WeatherRepo.dailyFutureForeCast(event.latitude, event.longitude, units);

    print("Future Forecast data$futureForecastData");
    emit(NavigateForeCastState(
        futureForecastData: futureForecastData, units: units, latitude: event.latitude, longitude: event.longitude));
  }

  FutureOr<void> futureForecastMetricChange(FutureForeCastMetricChangeEvent event, Emitter<HomeState> emit) async {
    bool changed = await WeatherRepo.changeMetric(event.units);
    if (changed) {
      String units = await fireStoreInstance.fetchUnits();
      FutureForecastData futureForecastData =
          await WeatherRepo.dailyFutureForeCast(event.latitude, event.longitude, units);

      print("Future Forecast data$futureForecastData");
      emit(NavigateForeCastState(
          futureForecastData: futureForecastData, units: units, latitude: event.latitude, longitude: event.longitude));
      // emit(await HomeFinalData());
    }
  }

  FutureOr<void> backToHomePage(BackToHomePage event, Emitter<HomeState> emit) async {
    print("called back to home page event in bloc");
    emit(BackToHomePageState());
    // emit(HomeLoadingState());

    // emit(await HomeFinalData());
  }
}
