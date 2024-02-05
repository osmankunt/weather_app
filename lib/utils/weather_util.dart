import 'package:weather/weather.dart';

class WeatherUtil {
  static String getAssetsInfo(Weather? weather) {
    switch (weather?.weatherMain) {
      case 'Clear':
        return 'sunny.png';
      case 'Drizzle':
        return 'drizzle.png';
      case 'Snowy':
        return 'snow.png';
      case 'Rainy':
        return 'rain.png';
      case 'Partly Sunny':
        return 'partly_sunny.png';
      case 'Thunderstorm':
        return 'thunderstorm.png';
      case 'Windy':
        return 'windy.png';
      default:
        return '';
    }
  }
}
