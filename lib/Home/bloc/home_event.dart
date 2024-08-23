// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

// class HomeActionEvent extends HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeChangeCityEvent extends HomeEvent {
  OtherCitiesDataModel city;
  HomeChangeCityEvent({
    required this.city,
  });
}

class HomeMetricChangeEvent extends HomeEvent {
  String units;
  HomeMetricChangeEvent({
    required this.units,
  });
}

class SearchNavigationEvent extends HomeEvent {}

class ForeCastNavigationEvent extends HomeEvent {
  double latitude;
  double longitude;
  ForeCastNavigationEvent({
    required this.latitude,
    required this.longitude,
  });
}

// To handle the metrics 5 forecast page.

class FutureForeCastMetricChangeEvent extends HomeEvent {
  String units;
  double latitude;
  double longitude;
  FutureForeCastMetricChangeEvent({
    required this.units,
    required this.latitude,
    required this.longitude,
  });
}

class BackToHomePage extends HomeEvent {}
