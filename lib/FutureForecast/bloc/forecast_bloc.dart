import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'forecast_event.dart';
part 'forecast_state.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  ForecastBloc() : super(ForecastInitial()) {
    on<ForecastEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
