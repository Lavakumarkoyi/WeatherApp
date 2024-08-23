// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

// Action states are for bloc listeners,

// Normal state is for bloc builder

// so when a Action state is called a bloc listener is implemented

// When a Normal state(HomeState) is called bloc builder is implemented

@immutable
sealed class HomeState {}

class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeErrorState extends HomeState {}

class HomeSucessState extends HomeState {
  CurrentWeatherdataModel currentWeatherData;
  List<OtherCitiesDataModel> otherCities;
  ForeCastData foreCastData;
  String units;
  HomeSucessState(
      {required this.currentWeatherData, required this.otherCities, required this.foreCastData, required this.units});
}

class SearchNavigationState extends HomeActionState {}

class NavigateForeCastState extends HomeActionState {
  FutureForecastData futureForecastData;
  String units;
  double latitude;
  double longitude;
  NavigateForeCastState(
      {required this.futureForecastData, required this.units, required this.latitude, required this.longitude});
}

class FutureForeCasMetricChangeState extends HomeActionState {}

class BackToHomePageState extends HomeActionState {}
