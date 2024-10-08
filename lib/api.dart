import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wheather_app/forcast.dart';

class Api {
  static String key = '4af8ed0ae63f48d9908194016242309';
  Api();
  static Future<Forcast> fetchForcast(String city) async {
      final response = await http.get(Uri.parse(
        'https://api.weatherapi.com/v1/forecast.json?key=$key&q=$city&days=1&aqi=no&alerts=no'));
    if (response.statusCode == 200) {

    return Forcast.refresh(jsonDecode(response.body) as Map<String, dynamic>);
  } else {

    throw Exception('Failed to load from api');
  }
  }
}
