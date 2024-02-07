import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/bloc/weather_bloc_states.dart';
import 'package:weather_app/constant/constants.dart';
import 'package:weather_app/utils/enum_view_status.dart';

class WeatherBloc extends Cubit<WeatherBlocStates> {
  WeatherBloc(Position position) : super(const WeatherBlocStates()) {
    fetchWeather(position);
  }

  void fetchWeather(Position position) async {
    emit(state.copyWith(viewStatus: ViewStatus.loading));
    WeatherFactory weatherFactory = WeatherFactory(Constants.apiKey, language: Language.ENGLISH);
    print({position.latitude.toString(), position.altitude.toString()});
    Weather weather = await weatherFactory.currentWeatherByLocation(position.latitude, position.altitude);
    emit(state.copyWith(weather: weather, viewStatus: ViewStatus.success));
  }

  void setLoading() {
    emit(state.copyWith(viewStatus: ViewStatus.loading));
  }

  void setByCityName(String cityName) async {
    emit(state.copyWith(viewStatus: ViewStatus.loading));
    WeatherFactory weatherFactory = WeatherFactory(Constants.apiKey, language: Language.ENGLISH);
    Weather weather = await weatherFactory.currentWeatherByCityName(cityName);
    print(weather);
    emit(state.copyWith(weather: weather, viewStatus: ViewStatus.success));
  }
}
