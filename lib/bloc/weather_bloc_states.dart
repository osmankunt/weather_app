import 'package:equatable/equatable.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/utils/enum_view_status.dart';

class WeatherBlocStates extends Equatable {
  const WeatherBlocStates({this.weather, this.viewStatus = ViewStatus.initial});

  final Weather? weather;

  final ViewStatus viewStatus;

  @override
  List<Object?> get props => [weather, viewStatus];

  WeatherBlocStates copyWith({Weather? weather, ViewStatus? viewStatus}) {
    return WeatherBlocStates(weather: weather ?? this.weather, viewStatus: viewStatus ?? this.viewStatus);
  }
}
