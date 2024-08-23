// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class SearchIntialEvent extends SearchEvent {}

// called when the bottom sheet to be loaded

class BottomSheetIntialEvent extends SearchEvent {
  double lat;
  double long;
  BottomSheetIntialEvent({
    required this.lat,
    required this.long,
  });
}

// called to add the city to the whishlist

class AddCityEvent extends SearchEvent {
  double lat;
  double long;
  AddCityEvent({
    required this.lat,
    required this.long,
  });
}

// called when I click on any of the city cards in search page.

class NavigateToHomeEvent extends SearchEvent {
  double latitude;
  double longitude;
  NavigateToHomeEvent({
    required this.latitude,
    required this.longitude,
  });
}
