import 'package:get/get.dart';
import 'package:weather_app_with_getx/controller/weather_controller.dart';

class SampleBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WeatherController>(() => WeatherController());
  }
}
