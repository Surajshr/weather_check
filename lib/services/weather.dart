import 'package:weather_check/services/networking.dart';
import '../services/location.dart';

const apiKey = "00f2f5b85d1ad2d8b1a081ffc873199b";
const openWeatherMapURL ="https://api.openweathermap.org/data/2.5/weather";

class WeatherModel {

  Future<dynamic>getCityWeather(String cityName)async{
    NetworkHelper networkHelper =  NetworkHelper(
      '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric'
    );
    var weatherData = await networkHelper.getData();
    return weatherData;
  }


  Future<dynamic> getLocationWeather() async {
    location newLocation = location();
    await newLocation.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${newLocation.latitude}&lon=${newLocation.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
