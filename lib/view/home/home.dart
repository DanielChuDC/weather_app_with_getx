import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app_with_getx/controller/weather_controller.dart';

class HomeScreen extends GetView<WeatherController> {
  final WeatherController _weatherController = Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid19 Monitoring"),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 8),
        child: Column(
          children: <Widget>[
            _buildLastUpdateItem(),
            _buildSelectedCountryCaseWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildLastUpdateItem() {
    return Container(
      child: Obx(() {
        final status = controller.status.value;
        if (status == Status.loading) return CircularProgressIndicator();
        if (status == Status.error) return Text('Error on connection :(');
        return Text(
            "cityName: ${_weatherController.weather.value.coord.lat} , weatherDescription: ${_weatherController.weather.value.base}, countryDescription: ${_weatherController.weather.value.clouds.all}");
      }),
    );
  }

  Widget _buildSelectedCountryCaseWidget() {
    return Container(
      margin: EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.blue.withOpacity(0.3),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            blurRadius: 8.0,
            spreadRadius: 0.8,
          ),
        ],
      ),
      height: Get.height * 0.3,
      width: Get.width * 1,
    );
  }
}
