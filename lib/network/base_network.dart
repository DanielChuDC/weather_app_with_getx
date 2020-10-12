import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_with_getx/controller/apikey.dart' as apikey;

class BaseNetwork {
  //static final String baseUrl = "https://api.covid19api.com/summary";
  static final String baseUrl =
      "http://api.openweathermap.org/data/2.5/weather";

  static Future<Map<String, dynamic>> get(String searchCity) async {
    final fullUrl =
        baseUrl + "?q=$searchCity&appid=${apikey.apiKey}&units=metric";
    var response;
    debugPrint("BaseNetwork - fullUrl : $fullUrl");
    debugPrint("$searchCity");
    if (searchCity == "") {
      response = await http.get(baseUrl);
    } else {
      response = await http.get(fullUrl);
    }

    debugPrint("BaseNetwork - response : ${response.body}");

    return _processResponse(response);
  }

  static Future<Map<String, dynamic>> _processResponse(
      http.Response response) async {
    final body = response.body ?? "";
    if (body.isNotEmpty) {
      final jsonBody = json.decode(body);
      return jsonBody;
    } else {
      print("processResponse error");
      return {"error": true};
    }
  }
}
