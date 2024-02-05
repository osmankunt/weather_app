import 'package:equatable/equatable.dart';
import 'package:weather/weather.dart';

class WeatherBlocStates extends Equatable {
  const WeatherBlocStates();

  @override
  List<Object> get props => [];
}

final class WeatherInitialState extends WeatherBlocStates {}

final class WeatherLoadingState extends WeatherBlocStates {}

final class WeatherFailureState extends WeatherBlocStates {}

final class WeatherSuccessState extends WeatherBlocStates {
  Weather weather;

  WeatherSuccessState(this.weather);

  List<Weather> get props => [];
}
