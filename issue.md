
1. 
```bash
[VERBOSE-2:ui_dart_state.cc(177)] Unhandled Exception: Permission definitions not found in the app's Info.plist. Please make sure to add either NSLocationWhenInUseUsageDescription or NSLocationAlwaysUsageDescription to the app's Info.plist file.
#0      MethodChannelGeolocator._handlePlatformException (package:geolocator_platform_interface/src/implementations/method_channel_geolocator.dart:177:9)
#1      MethodChannelGeolocator.getPositionStream.<anonymous closure> (package:geolocator_platform_interface/src/implementations/method_channel_geolocator.dart:152:11)
#2      _invokeErrorHandler (dart:async/async_error.dart:16:24)
#3      _HandleErrorStream._handleError (dart:async/stream_pipe.dart:282:9)
#4      _ForwardingStreamSubscription._handleError (dart:async/stream_pipe.dart:161:13)
#5      _rootRunBinary (dart:async/zone.dart:1214:47)
#6      _CustomZone.runBinary (dart:async/zone.dart:1107:19)
#7      _CustomZone.runBinaryGuarded (dart:async/zone.dart:1013:7)
#8      _BufferingStreamSubscription.<…>


```

- Solution for 1.
https://github.com/Baseflow/flutter-geolocator/issues/172

https://stackoverflow.com/questions/46193797/nslocationwheninuseusagedescription-warning-but-i-have-already-added-it


add this xml into `info.plist` in `ios/Runner/info.plist`
```xml

<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>...</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>...</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>...</string>
```


2. 

```bash
[VERBOSE-2:ui_dart_state.cc(177)] Unhandled Exception: type 'String' is not a subtype of type 'RxString' in type cast
#0      WeatherController.getWeatherData (package:weather_app_with_getx/controller/weather_controller.dart:78:30)
<asynchronous suspension>
#1      WeatherController.onInit (package:weather_app_with_getx/controller/weather_controller.dart:27:5)
<asynchronous suspension>
#2      DisposableInterface._onStart (package:get/get_state_manager/src/rx_flutter/rx_disposable.dart:24:5)
#3      _InternalFinalCallback.call (package:get/get_instance/src/lifecycle.dart:11:24)
#4      GetInstance._startController (package:get/get_instance/src/get_instance.dart:216:18)
#5      GetInstance._initDependencies (package:get/get_instance/src/get_instance.dart:187:11)
#6      GetInstance.find (package:get/get_instance/src/get_instance.dart:267:17)
#7      GetInstance.put (package:get/get_instance/src/get_instance.dart:95:12)
#8      Inst.put (package:get/get_instance/src/extension_instance.dart:87:12)
#9   <…>
```


3. 
 Remove DiagnosticableMixin in favor of Diagnosticable

Solution:

https://github.com/flutter/flutter/pull/58635


4. GetxController not found
https://github.com/jonataslaw/getx/issues/715

Need to bind it using bind