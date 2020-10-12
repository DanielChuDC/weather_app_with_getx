import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app_with_getx/view/home/home.dart';
import 'package:weather_app_with_getx/view/home/weather.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        initialRoute: '/',
        getPages: [
          GetPage(
            name: '/',
            page: () => WeatherScreen(),
          ),
          GetPage(
            name: 'weather',
            page: () => WeatherScreen(),
          )
        ],
        theme: ThemeData.dark());
  }
}
