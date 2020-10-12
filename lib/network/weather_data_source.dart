import 'package:weather_app_with_getx/network/base_network.dart';

class WeatherDataSource {


  static WeatherDataSource instance = WeatherDataSource();

  Future<Map<String, dynamic>> loadGlobalData(cityName)  {
    return BaseNetwork.get(cityName);
  }

  Future<Map<String, dynamic>> loadCountries() {
    return BaseNetwork.get("countries");
  }

  Future<Map<String, dynamic>> loadSelectedCountry(iso3) {
    return BaseNetwork.get("countries/$iso3");
  }
}
