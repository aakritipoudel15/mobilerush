import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_rush/model/weather.model.dart';

class WeatherService {
  final String apiUrl = 'https://mr-api-three.vercel.app/weather';

  Future<Weather> fetchWeather() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      print(response.body);
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}

