import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

sealed class WeatherBlocEvents extends Equatable {
  const WeatherBlocEvents();

  @override
  List<Object> get props => [];
}

class FetchWeather extends WeatherBlocEvents {
  final Position position;

  const FetchWeather(this.position);

  @override
  List<Object> get props => [position];
}
