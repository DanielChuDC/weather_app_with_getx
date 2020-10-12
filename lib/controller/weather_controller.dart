import 'package:get/get.dart';
import 'package:weather_app_with_getx/model/weather_model.dart';
import 'package:weather_app_with_getx/network/weather_data_source.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

enum Status { loading, success, error }

class WeatherController extends GetxController {

  /// create a reactive WeatherModel. CasesModel().obs has same result
  final weather = Rx<WeatherModel>();

  /// create a reactive status from request with initial value = loading
  final status = Status.loading.obs;

  // Use GetX init
  @override
  Future<void> onInit() async {
    print("GlobalController - onInit");

    fetchDataFromWeatherApi();

    super.onInit();
  }

  @override
  void onReady() {
    ever(weather, (_) async {
      print("onready called , ${weather.value.main.temp}");
    });
    super.onReady();
  }

  // Using GPS to get User location
  Future<String> getUserCityName() async {
    print('getting user position');
    String cityName = '';
    Position position =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    if (position != null) {
      List<Placemark> results =
          await placemarkFromCoordinates(position.latitude, position.longitude)
              .catchError((e, stacktrace) {
        print(e);
        print(stacktrace);
      });

      if (results != null && results.length > 0) {
        Placemark placemark = results[0];
        cityName = placemark.subAdministrativeArea;
      }
    }
    return cityName;
  }

  Future<WeatherModel> getWeather() async {
    try {
      var cityName = await getUserCityName();
      var data = await WeatherDataSource.instance.loadGlobalData(cityName);
      var res = WeatherModel.fromJson(data);
      print(res.timezone);
      return res;
    } on Exception catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }

  /// fetch cases from Api
  Future<void> fetchDataFromWeatherApi() async {
    /// When the repository returns the value, change the status to success,
    /// and fill in <weather>
    return getWeather().then(
      (data) {
        // put the return reactive data into the rxModel <weather>
        weather(data);
        status(Status.success);
        print("The data print out and status is success");
      },

      /// In case of error, print the error and change the status
      /// to Status.error
      onError: (err) {
        print("$err");
        return status(Status.error);
      },
    );
  }
}
