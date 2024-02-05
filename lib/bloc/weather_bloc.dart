import 'package:bloc/bloc.dart';
import 'package:weather_app/bloc/weather_bloc_events.dart';
import 'package:weather_app/bloc/weather_bloc_states.dart';

class WeatherBloc extends Bloc<WeatherBlocEvents, WeatherBlocStates> {
  WeatherBloc() : super(WeatherInitialState()) {
    on<FetchWeather>((event, emit) {
      emit(WeatherLoadingState());
      try {
        emit(WeatherSuccessState());
      } catch (e) {
        emit(WeatherFailureState());
      }
    });
  }
}
