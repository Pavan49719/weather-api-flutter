import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_weather_bg/flutter_weather_bg.dart';

const apiKey = '6ad152db52dbc110edd759caad0650cf';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

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

Widget getAnimation(int condition) {
  if (condition < 300) {
    return WeatherBg(
        weatherType: WeatherType.cloudyNight, width: 400, height: 800);
  } else if (condition < 400) {
    return WeatherBg(
        weatherType: WeatherType.lightRainy, width: 400, height: 800);
  } else if (condition < 600) {
    return WeatherBg(
        weatherType: WeatherType.heavyRainy, width: 400, height: 800);
  } else if (condition < 700) {
    return WeatherBg(
        weatherType: WeatherType.heavySnow, width: 400, height: 800);
  } else if (condition < 800) {
    return WeatherBg(weatherType: WeatherType.foggy, width: 400, height: 800);
  } else if (condition == 800) {
    return WeatherBg(weatherType: WeatherType.sunny, width: 400, height: 800);
  } else if (condition <= 804) {
    return WeatherBg(weatherType: WeatherType.cloudy, width: 400, height: 800);
  } else {
    return WeatherBg(weatherType: WeatherType.dusty, width: 400, height: 800);
  }
}
