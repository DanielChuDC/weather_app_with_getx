import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_with_getx/controller/weather_controller.dart';
import 'package:weather_app_with_getx/view/home/widgets/dateTime.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherScreen extends GetView<WeatherController> {
  final WeatherController _weatherController = Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent[100],
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent[100],
        elevation: 0,
        centerTitle: true,
        title: Text(
          "WEATHER",
          style: TextStyle(color: Colors.white, letterSpacing: 5, fontSize: 35),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child:
            //Start obx
            Obx(
          () {
            final status = controller.status.value;
            if (status == Status.loading) return CircularProgressIndicator();
            if (status == Status.error) return Text('Error on connection :(');
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Top SVG Image
                Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(2),
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: SvgPicture.asset('assets/images/weather2.svg',
                      fit: BoxFit.fitWidth),
                ),
                Column(
                  children: <Widget>[
                    //City Heading
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        controller.weather.value.name,
                        style: TextStyle(fontSize: 35, color: Colors.white),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          // child: Container(
                          // color: Colors.yellow,
                          child: Column(
                            children: <Widget>[
                              Container(
                                // margin: EdgeInsets.all(2),
                                height:
                                    MediaQuery.of(context).size.height * 0.10,
                                width: MediaQuery.of(context).size.width * 0.25,
                                padding: EdgeInsets.all(8),

                                decoration: BoxDecoration(
                                  // color: Colors.red,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        'http://openweathermap.org/img/wn/${controller.weather.value.weather[0].icon}@2x.png'),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  WindIcon(
                                    degree: controller.weather.value.wind.deg,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  AutoSizeText(
                                    controller.weather.value.wind.speed
                                            .toStringAsFixed(0) +
                                        " kmph",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  )
                                ],
                              )
                            ],
                          ),
                          // ),
                        ),

                        //Right side column
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: EdgeInsets.all(4),
                            padding: EdgeInsets.all(4),
                            height: MediaQuery.of(context).size.height * 0.20,
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    BoxedIcon(
                                      WeatherIcons.day_sunny_overcast,
                                      color: Colors.black45,
                                    ),
                                    AutoSizeText(
                                      toBeginningOfSentenceCase(controller
                                          .weather
                                          .value
                                          .weather[0]
                                          .description),
                                      style: TextStyle(color: Colors.white),
                                      maxLines: 1,
                                      minFontSize: 18,
                                      maxFontSize: 25,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    BoxedIcon(
                                      WeatherIcons.thermometer,
                                      color: Colors.black45,
                                    ),
                                    AutoSizeText(
                                      "Temperature: " +
                                          controller.weather.value.main.temp
                                              .toString() +
                                          "° C",
                                      style: TextStyle(color: Colors.white),
                                      maxLines: 1,
                                      maxFontSize: 10,
                                      minFontSize: 5,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    BoxedIcon(
                                      WeatherIcons.humidity,
                                      color: Colors.black45,
                                    ),
                                    AutoSizeText(
                                      "Humidity: " +
                                          controller.weather.value.main.humidity
                                              .toString() +
                                          "% hPa",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        //Sunrise Time
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                BoxedIcon(
                                  WeatherIcons.sunrise,
                                  color: Colors.yellow,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  DateFormat("hh:mm a").format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          controller.weather.value.sys.sunrise *
                                              1000)),
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                        //Divider between the times
                        Container(
                          color: Colors.grey[300],
                          margin: EdgeInsets.all(2),
                          height: MediaQuery.of(context).size.height * 0.04,
                          width: 3,
                        ),

                        //Sunset time
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                BoxedIcon(
                                  WeatherIcons.sunset,
                                  color: Colors.deepOrange,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  //weatherDataModel.weatherSunsetTime.toString(),
                                  DateFormat("hh:mm").format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          controller.weather.value.sys.sunrise *
                                              1000)),
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                DateTimeBar()
              ],
            );
          },
        ),
      ),
    );
  }
}
