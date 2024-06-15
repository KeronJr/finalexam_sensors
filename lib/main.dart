import 'package:Keron_Sensors_Finalexam/accelerometer_dashboard.dart';
import 'package:Keron_Sensors_Finalexam/drawer.dart';
import 'package:Keron_Sensors_Finalexam/geofence_gps.dart';
import 'package:Keron_Sensors_Finalexam/home.dart';
import 'package:Keron_Sensors_Finalexam/light.dart';
import 'package:Keron_Sensors_Finalexam/light2.dart';
import 'package:Keron_Sensors_Finalexam/locationcard.dart';
import 'package:Keron_Sensors_Finalexam/widgets/dashboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification_service.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();

//   NotificationService.initializeNotifications();
//   NotificationService.requestNotificationPermission();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);vs

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         scaffoldBackgroundColor: Color(0xFF15131C),
//         brightness: Brightness.dark,
//       ),
//       // home: const MyHomePage(title: 'Flutter Demo Home Page'),
//       // home: const MainScreen(),
//     );
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('sensors'),
//       ),

//       body: SafeArea(
//         child: Center(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Expanded(
//                 flex: 5,
//                 child: DashboardWidget(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();

//   NotificationService.initializeNotifications();
//   NotificationService.requestNotificationPermission();
//   runApp(MyApp());
// }

void main() async {
  runApp(MyApp());
  await initNotifications();
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) async {
      // Handle notification tap
    },
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var routeName;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sensor App',
            // home: const MainScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(), // Define your main screen route
        Light.routeName: (context) => Light(),
        Light2.routeName: (context) => Light2(),
        AccelerometerDashboard.routeName: (context) => AccelerometerDashboard(),
        GpsTrackerScreen.routeName: (context) => GpsTrackerScreen(),
        // Step.routeName: (context) => Step(content: null, title: null),

        // ProximitySensorWidget.routeName: (context) => ProximitySensorWidget(),
      },
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sensor Assignment'),
//       ),
//       drawer: DrawerScreen(currentScreen: 'Home'),
//       body: Center(
//         // child: DashboardWidget(),
//         child: LocationCard()
//       ),
//     );
//   }
// }
