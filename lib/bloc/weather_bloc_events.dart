import 'package:equatable/equatable.dart';

sealed class WeatherBlocEvents extends Equatable {
  const WeatherBlocEvents();

  @override
  List<Object> get props => [];
}

class FetchWeather extends WeatherBlocEvents {}
