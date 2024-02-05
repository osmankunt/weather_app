import 'package:bloc/bloc.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/bloc/weather_bloc_events.dart';
import 'package:weather_app/bloc/weather_bloc_states.dart';
import 'package:weather_app/constant/constants.dart';

class WeatherBloc extends Bloc<WeatherBlocEvents, WeatherBlocStates> {
  WeatherBloc() : super(WeatherInitialState()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoadingState());
      try {
        WeatherFactory weatherFactory = WeatherFactory(Constants.apiKey, language: Language.ENGLISH);
        Weather weather = await weatherFactory.currentWeatherByLocation(event.position.latitude, event.position.altitude);
        print(weather);
        emit(WeatherSuccessState(weather));
      } catch (e) {
        emit(WeatherFailureState());
      }
    });
  }
}
