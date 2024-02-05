import 'package:equatable/equatable.dart';
import 'package:weather/weather.dart';

class WeatherBlocStates extends Equatable {
  const WeatherBlocStates({this.weather, this.viewStatus = "init"});

  final Weather? weather;

  final String viewStatus;

  @override
  List<Object?> get props => [weather, viewStatus];

  WeatherBlocStates copyWith({Weather? weather, String? viewStatus}) {
    return WeatherBlocStates(weather: weather ?? this.weather, viewStatus: viewStatus ?? this.viewStatus);
  }
}
