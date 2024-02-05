import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/bloc/weather_bloc_states.dart';
import 'package:weather_app/constant/constants.dart';

class WeatherBloc extends Cubit<WeatherBlocStates> {
  WeatherBloc(Position position) : super(WeatherBlocStates()) {
    fetchWeather(position);
  }

  void fetchWeather(Position position) async {
    emit(state.copyWith(viewStatus: "loading"));
    WeatherFactory weatherFactory = WeatherFactory(Constants.apiKey, language: Language.ENGLISH);
    Weather weather = await weatherFactory.currentWeatherByLocation(position.latitude, position.altitude);
    emit(state.copyWith(weather: weather, viewStatus: "success"));
  }
}
