
// import 'package:Keron_Sensors_Finalexam/drawer.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:light_sensor/light_sensor.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter_screen_wake/flutter_screen_wake.dart';
// import 'dart:async'; 

// class Light2 extends StatefulWidget {
//   static const routeName = '/light2';
//   @override
//   _LightState createState() => _LightState();
// }

// class _LightState extends State<Light2> {
//   bool _hasSensor = false;
//   double _luxValue = 0.0;
//   DateTime? _lastNotificationTime;
//   final int _notificationCooldownSeconds = 30;
//   double _brightness = 0.0;
//   bool _isManualAdjustment = false;
//   Timer? _manualAdjustmentTimer;

//   @override
//   void initState() {
//     super.initState();
//     _initializeState();
//     getBrightness();
//   }

//   void getBrightness() async {
//     double bright;
//     try {
//       bright = await FlutterScreenWake.brightness;
//     } on PlatformException {
//       bright = 1.0;
//     }
//     if (!mounted) {
//       return;
//     }
//     setState(() {
//       _brightness = bright;
//     });
//   }

//   void setScreenBrightness(double value) {
//     FlutterScreenWake.setBrightness(value);
//           if (!mounted) {
//         return;
//       }
//     setState(() {
//       _brightness = value;
//       _isManualAdjustment = true;
//     });
//     _resetManualAdjustmentFlag();
//   }

//   void _resetManualAdjustmentFlag() {
//     _manualAdjustmentTimer?.cancel();
//     _manualAdjustmentTimer = Timer(Duration(seconds: 3), () {
//             if (!mounted) {
//         return;
//       }
//       setState(() {
//         _isManualAdjustment = false;
//       });
//     });
//   }

//   Future<void> _initializeState() async {
//     await _checkSensorAvailability();
//   }

//   Future<void> _checkSensorAvailability() async {
//     _hasSensor = await LightSensor.hasSensor();
//     print('Light sensor available: $_hasSensor');

//     if (_hasSensor) {
//       _subscribeToLuxUpdates();
//     }
//   }

//   void _subscribeToLuxUpdates() {
//     LightSensor.luxStream().listen((lux) {
//       if (!mounted) {
//         return;
//       }
//       setState(() {
//         _luxValue = lux.toDouble();
//       });
//       if (!_isManualAdjustment) {
//         _automateLighting(_luxValue);
//       }
//     });
//   }

//   bool _canSendNotification() {
//     if (_lastNotificationTime == null) {
//       return true;
//     }
//     return DateTime.now().difference(_lastNotificationTime!).inSeconds >
//         _notificationCooldownSeconds;
//   }

//   void _automateLighting(double luxValue) {
//     const double lowLightThreshold = 50.0;
//     const double highLightThreshold = 300.0;

//     if (luxValue < lowLightThreshold) {
//       _adjustSmartLight(300);
//       if (_canSendNotification()) {
//         _showNotification('It\'s getting dark', 'Turning on the lights.');
//         _lastNotificationTime = DateTime.now();
//       }
//       setScreenBrightness(0.8);
//     } else if (luxValue > highLightThreshold) {
//       _adjustSmartLight(0);
//       if (_canSendNotification()) {
//         _showNotification('It\'s bright enough', 'Turning off the lights.');
//         _lastNotificationTime = DateTime.now();
//       }
//       setScreenBrightness(0.2);
//     }
//   }

//   void _adjustSmartLight(int brightness) {
//     // Placeholder for adjusting smart light brightness
//   }

//   void _showNotification(String title, String body) {
//     AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: DateTime.now().millisecondsSinceEpoch.remainder(1000000),
//         channelKey: 'basic_channel',
//         title: title,
//         body: body,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: Text('Light Sensor'),
//       ),
//       drawer: DrawerScreen(currentScreen: 'Light_Sensor'),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
            
//             SizedBox(height: 20),
//             Container(
//               width: 250,
//               height: 250,
//               child: CircularProgressIndicator(
//                 value: _luxValue / 1000,
//                 strokeWidth: 50,
//                 backgroundColor: Colors.blue,
//                 valueColor: AlwaysStoppedAnimation<Color>(const Color.fromARGB(255, 243, 33, 33)),
//               ),
//             ),
//             SizedBox(height: 40),
//             Text(
//               'Light Sensors Value: $_luxValue',
//               style: TextStyle(fontSize: 25),
//             ),
//             SizedBox(height: 40),
//             Text(
              
//               'Adjust Brightness',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             Slider(
              
//               value: _brightness,
//               min: 0.0,
//               max: 1.0,
//               divisions: 100,
//               label: '${(_brightness * 100).round()}%',
//               onChanged: (value) {
//                 setScreenBrightness(value);
//               },
//             ),
//             Text(
//               'Brightness: ${(_brightness * 100).round()}%',
//               style: TextStyle(fontSize: 20),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




// import 'package:Keron_Sensors_Finalexam/drawer.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:light_sensor/light_sensor.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter_screen_wake/flutter_screen_wake.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'dart:async';

// class Light2 extends StatefulWidget {
//   static const routeName = '/light2';
//   @override
//   _LightState createState() => _LightState();
// }

// class _LightState extends State<Light2> {
//   bool _hasSensor = false;
//   double _luxValue = 0.0;
//   DateTime? _lastNotificationTime;
//   final int _notificationCooldownSeconds = 30;
//   double _brightness = 0.0;
//   bool _isManualAdjustment = false;
//   Timer? _manualAdjustmentTimer;

//   @override
//   void initState() {
//     super.initState();
//     _initializeState();
//     getBrightness();
//   }

//   void getBrightness() async {
//     double bright;
//     try {
//       bright = await FlutterScreenWake.brightness;
//     } on PlatformException {
//       bright = 1.0;
//     }
//     if (!mounted) {
//       return;
//     }
//     setState(() {
//       _brightness = bright;
//     });
//   }

//   void setScreenBrightness(double value) {
//     FlutterScreenWake.setBrightness(value);
//     if (!mounted) {
//       return;
//     }
//     setState(() {
//       _brightness = value;
//       _isManualAdjustment = true;
//     });
//     _resetManualAdjustmentFlag();
//   }

//   void _resetManualAdjustmentFlag() {
//     _manualAdjustmentTimer?.cancel();
//     _manualAdjustmentTimer = Timer(Duration(seconds: 3), () {
//       if (!mounted) {
//         return;
//       }
//       setState(() {
//         _isManualAdjustment = false;
//       });
//     });
//   }

//   Future<void> _initializeState() async {
//     await _checkSensorAvailability();
//   }

//   Future<void> _checkSensorAvailability() async {
//     _hasSensor = await LightSensor.hasSensor();
//     print('Light sensor available: $_hasSensor');

//     if (_hasSensor) {
//       _subscribeToLuxUpdates();
//     }
//   }

//   void _subscribeToLuxUpdates() {
//     LightSensor.luxStream().listen((lux) {
//       if (!mounted) {
//         return;
//       }
//       setState(() {
//         _luxValue = lux.toDouble();
//       });
//       if (!_isManualAdjustment) {
//         _automateLighting(_luxValue);
//       }
//     });
//   }

//   bool _canSendNotification() {
//     if (_lastNotificationTime == null) {
//       return true;
//     }
//     return DateTime.now().difference(_lastNotificationTime!).inSeconds >
//         _notificationCooldownSeconds;
//   }

//   void _automateLighting(double luxValue) {
//     const double lowLightThreshold = 50.0;
//     const double highLightThreshold = 300.0;

//     if (luxValue < lowLightThreshold) {
//       _adjustSmartLight(300);
//       if (_canSendNotification()) {
//         _showNotification('It\'s getting dark', 'Turning on the lights.');
//         _lastNotificationTime = DateTime.now();
//       }
//       setScreenBrightness(0.8);
//     } else if (luxValue > highLightThreshold) {
//       _adjustSmartLight(0);
//       if (_canSendNotification()) {
//         _showNotification('It\'s bright enough', 'Turning off the lights.');
//         _lastNotificationTime = DateTime.now();
//       }
//       setScreenBrightness(0.2);
//     }
//   }

//   void _adjustSmartLight(int brightness) {
//     // Placeholder for adjusting smart light brightness
//   }

//   void _showNotification(String title, String body) {
//     AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: DateTime.now().millisecondsSinceEpoch.remainder(1000000),
//         channelKey: 'basic_channel',
//         title: title,
//         body: body,
//       ),
//     );
//   }

//   Widget buildPieChart() {
//     return PieChart(
//       PieChartData(
//         sections: [
//           PieChartSectionData(
//             value: _luxValue,
//             color: Colors.blue,
//             title: '${_luxValue.toStringAsFixed(1)} lux',
//             radius: 100,
//             titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//           ),
//           PieChartSectionData(
//             value: 1000 - _luxValue,
//             color: Colors.grey,
//             title: '',
//             radius: 100,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildCard() {
//     return Card(
//       elevation: 5,
//       child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               'Light Sensor Value: $_luxValue',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             buildPieChart(),
//             SizedBox(height: 20),
//             Text(
//               'Adjust Brightness',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             Slider(
//               value: _brightness,
//               min: 0.0,
//               max: 1.0,
//               divisions: 100,
//               label: '${(_brightness * 100).round()}%',
//               onChanged: (value) {
//                 setScreenBrightness(value);
//               },
//             ),
//             Text(
//               'Brightness: ${(_brightness * 100).round()}%',
//               style: TextStyle(fontSize: 20),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: Text('Light Sensor'),
//       ),
//       drawer: DrawerScreen(currentScreen: 'light2'),
//       body: Center(
//         child: buildCard(),
//       ),
//     );
//   }
// }










import 'dart:async';

// import 'package:finalexam_sensors/light/brightnessManager.dart';
import 'package:Keron_Sensors_Finalexam/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screen_wake/flutter_screen_wake.dart';
// import 'package:sensors/sensors.dart';
import 'package:sensors_plus/sensors_plus.dart';


class Light2 extends StatefulWidget {
  static const routeName = '/light2';
  Light2({Key? key}) : super(key: key);

  @override
  _LightState createState() => _LightState();
}

class _LightState extends State<Light2> {
  double brightness = 0.0;
  bool toggle = false;
  late StreamSubscription<AccelerometerEvent> _subscription;

  @override
  void initState() {
    super.initState();
    getBrightness();
    proximityListener();
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  void getBrightness() async {
    double bright;
    try {
      bright = await FlutterScreenWake.brightness;
    } on PlatformException {
      bright = 1.0;
    }
    if (!mounted) return;

    setState(() {
      brightness = bright;
    });
    setScreenBrightness(brightness);
    BrightnessManager.instance.setBrightness(brightness);
  }

  void setScreenBrightness(double value) {
    FlutterScreenWake.setBrightness(value);
  }

  void proximityListener() {
    _subscription = accelerometerEvents.listen((AccelerometerEvent event) {
      if (event.z > 8.0) {
        autoAdjustBrightness(0.1);
      } else {
        autoAdjustBrightness(1.0);
      }
    });
  }

  void autoAdjustBrightness(double targetBrightness) {
    final double changeSpeed = 0.001; // Adjusted for slower speed
    double difference = targetBrightness - brightness;
    if (difference.abs() < changeSpeed) {
      setState(() {
        brightness = targetBrightness;
        setScreenBrightness(brightness);
        BrightnessManager.instance.setBrightness(brightness);
      });
    } else {
      Timer.periodic(Duration(milliseconds: 10), (timer) {
        if ((targetBrightness - brightness).abs() < changeSpeed) {
          timer.cancel();
        } else {
          setState(() {
            brightness += difference > 0 ? changeSpeed : -changeSpeed;
            setScreenBrightness(brightness);
            BrightnessManager.instance.setBrightness(brightness);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Light Sensor'),
      ),
      drawer: DrawerScreen(currentScreen: 'Light_Sensor'),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            border: Border.all(color: Colors.black26),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 2,
                blurRadius: 2,
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Brightness:'),
              const SizedBox(height: 10),
              Row(
                children: [
                  // AnimatedCrossFade(
                  //   firstChild: const Icon(Icons.brightness_7, size: 50),
                  //   secondChild: const Icon(Icons.brightness_3, size: 50),
                  //   crossFadeState: toggle
                  //       ? CrossFadeState.showSecond
                  //       : CrossFadeState.showFirst,
                  //   duration: const Duration(seconds: 1),
                  // ),
                  Expanded(
                    child: Slider(
                      value: brightness,
                      onChanged: (value) {
                        setState(() {
                          brightness = value;
                          setScreenBrightness(brightness);
                          BrightnessManager.instance.setBrightness(brightness);
                        });
                      },
                    ),
                  ),
                ],
              ),
              Text(
                brightnessPercentage(),
                style: TextStyle(fontSize: 16.0),
              )
            ],
          ),
        ),
      ),
    );
  }

  String brightnessPercentage() {
    int percentage = (brightness * 100).round();
    return '$percentage%';
  }
}

class BrightnessManager {
  BrightnessManager._privateConstructor();
  static final BrightnessManager _instance = BrightnessManager._privateConstructor();
  static BrightnessManager get instance => _instance;

  double _brightness = 0.0;
  List<void Function(double)> _listeners = [];

  double get brightness => _brightness;

  void setBrightness(double value) {
    _brightness = value;
    for (var listener in _listeners) {
      listener(_brightness);
    }
  }

  void addListener(void Function(double) listener) {
    _listeners.add(listener);
  }

  void removeListener(void Function(double) listener) {
    _listeners.remove(listener);
  }
}




// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screen_wake/flutter_screen_wake.dart';
// import 'package:sensors_plus/sensors_plus.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:Keron_Sensors_Finalexam/drawer.dart';

// class Light2 extends StatefulWidget {
//   static const routeName = '/light2';
//   Light2({Key? key}) : super(key: key);

//   @override
//   _LightState createState() => _LightState();
// }

// class _LightState extends State<Light2> {
//   double brightness = 0.0;
//   late StreamSubscription<AccelerometerEvent> _subscription;

//   @override
//   void initState() {
//     super.initState();
//     getBrightness();
//     proximityListener();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _subscription.cancel();
//   }

//   void getBrightness() async {
//     double bright;
//     try {
//       bright = await FlutterScreenWake.brightness;
//     } on PlatformException {
//       bright = 1.0;
//     }
//     if (!mounted) return;

//     setState(() {
//       brightness = bright;
//     });
//     setScreenBrightness(brightness);
//     BrightnessManager.instance.setBrightness(brightness);
//   }

//   void setScreenBrightness(double value) {
//     FlutterScreenWake.setBrightness(value);
//   }

//   void proximityListener() {
//     _subscription = accelerometerEvents.listen((AccelerometerEvent event) {
//       if (event.z > 8.0) {
//         autoAdjustBrightness(0.1);
//       } else {
//         autoAdjustBrightness(1.0);
//       }
//     });
//   }

//   void autoAdjustBrightness(double targetBrightness) {
//     final double changeSpeed = 0.001;
//     double difference = targetBrightness - brightness;
//     if (difference.abs() < changeSpeed) {
//       setState(() {
//         brightness = targetBrightness;
//         setScreenBrightness(brightness);
//         BrightnessManager.instance.setBrightness(brightness);
//       });
//     } else {
//       Timer.periodic(Duration(milliseconds: 10), (timer) {
//         if ((targetBrightness - brightness).abs() < changeSpeed) {
//           timer.cancel();
//         } else {
//           setState(() {
//             brightness += difference > 0 ? changeSpeed : -changeSpeed;
//             setScreenBrightness(brightness);
//             BrightnessManager.instance.setBrightness(brightness);
//           });
//         }
//       });
//     }
//   }

//   Widget buildPieChart() {
//     return PieChart(
//       PieChartData(
//         sections: [
//           PieChartSectionData(
//             value: brightness * 100,
//             color: Colors.blue,
//             title: '${(brightness * 100).toStringAsFixed(1)}%',
//             radius: 60,
//             titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//           ),
//           PieChartSectionData(
//             value: 100 - (brightness * 100),
//             color: Colors.grey,
//             title: '',
//             radius: 60,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildCard() {
//     return Card(
//       elevation: 5,
//       child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text(
//               'Brightness:',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             buildPieChart(),
//             const SizedBox(height: 20),
//             Slider(
//               value: brightness,
//               onChanged: (value) {
//                 setState(() {
//                   brightness = value;
//                   setScreenBrightness(brightness);
//                   BrightnessManager.instance.setBrightness(brightness);
//                 });
//               },
//             ),
//             Text(
//               brightnessPercentage(),
//               style: TextStyle(fontSize: 16.0),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Light Sensor'),
//       ),
//       drawer: DrawerScreen(currentScreen: 'Light_Sensor'),
//       body: Center(
//         child: buildCard(),
//       ),
//     );
//   }

//   String brightnessPercentage() {
//     int percentage = (brightness * 100).round();
//     return '$percentage%';
//   }
// }

// class BrightnessManager {
//   BrightnessManager._privateConstructor();
//   static final BrightnessManager _instance = BrightnessManager._privateConstructor();
//   static BrightnessManager get instance => _instance;

//   double _brightness = 0.0;
//   List<void Function(double)> _listeners = [];

//   double get brightness => _brightness;

//   void setBrightness(double value) {
//     _brightness = value;
//     for (var listener in _listeners) {
//       listener(_brightness);
//     }
//   }

//   void addListener(void Function(double) listener) {
//     _listeners.add(listener);
//   }

//   void removeListener(void Function(double) listener) {
//     _listeners.remove(listener);
//   }
// }
