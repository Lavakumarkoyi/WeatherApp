part of 'search_bloc.dart';

// Action states are bloc listeners,

// Normal state is for bloc builder to listen when rendering a UI

@immutable
sealed class SearchState {}

final class SearchActionState extends SearchState {}

// Below States to load the search page

final class SearchInitialState extends SearchState {}

final class SearchLoadingState extends SearchState {}

final class SearchSuccessState extends SearchState {
  List<OtherCitiesDataModel> cityData;
  SearchSuccessState({
    required this.cityData,
  });
}

final class SearchErrorState extends SearchState {}

// Below states are emitted to load the bottom sheet

final class BottomSheetIntialState extends SearchActionState {}

final class BottomSheetLoadingState extends SearchActionState {}

final class BottomSheetSuccessState extends SearchActionState {
  CurrentWeatherdataModel currentWeatherData;
  ForeCastData forecastData;
  double lat;
  double long;

  BottomSheetSuccessState(
      {required this.currentWeatherData, required this.lat, required this.long, required this.forecastData});
}

// To navigate back to the Home State from FutureForecast page, but it is not called in the app.

final class NavigateToHomeState extends SearchActionState {}
