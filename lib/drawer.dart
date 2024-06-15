import 'package:Keron_Sensors_Finalexam/accelerom_card.dart';
import 'package:Keron_Sensors_Finalexam/accelerometer_dashboard.dart';
import 'package:Keron_Sensors_Finalexam/geofence_gps.dart';
import 'package:Keron_Sensors_Finalexam/home.dart';
import 'package:Keron_Sensors_Finalexam/light.dart';
import 'package:Keron_Sensors_Finalexam/light2.dart';
// import 'package:Keron_Sensors_Finalexam/steps.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  final String currentScreen;

  const DrawerScreen({
    Key? key,
    required this.currentScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Sensor Screens'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
              if (currentScreen != 'Home') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ),
                );
              }
            },
            selected: currentScreen == 'Home',
          ),
          ListTile(
            leading: Icon(Icons.lightbulb),
            title: Text('Light Sensor'),
            onTap: () {
              Navigator.pop(context);
              if (currentScreen != 'Light Sensor') {
                Navigator.pushReplacementNamed(context, Light.routeName);
              }
            },
            selected: currentScreen == 'Light Sensor',
          ),
                   
                    ListTile(
            leading: Icon(Icons.lightbulb),
            title: Text('Light_Sensor'),
            onTap: () {
              Navigator.pop(context);
              if (currentScreen != 'light2') {
                Navigator.pushReplacementNamed(context, Light2.routeName);
              }
            },
            selected: currentScreen == 'light2',
          ),

          ListTile(
            leading: Icon(Icons.directions_walk),
            title: Text('Accelerometer Sensor'),
            onTap: () {
              Navigator.pop(context);
              if (currentScreen != 'Step Counter') {
                Navigator.pushReplacementNamed(
                    context, AccelerometerDashboard.routeName);
              }
            },
            selected: currentScreen == 'Accelerometer Sensor',
          ),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('GPS Tracker with Home Geofence'),
            onTap: () {
              Navigator.pop(context);
              if (currentScreen != 'GPS Tracker') {
                Navigator.pushReplacementNamed(
                    context, GpsTrackerScreen.routeName);
              }
            },
            selected: currentScreen == 'GPS Tracker',
          ),
          //           ListTile(
          //   leading: Icon(Icons.assist_walker),
          //   title: Text('Steps'),
          //   onTap: () {
          //     Navigator.pop(context);
          //     if (currentScreen != 'steps') {
          //       Navigator.pushReplacementNamed(
          //           context, Steps.routeName);
          //     }
          //   },
          //   selected: currentScreen == 'steps',
          // ),
          //  ListTile(
          //   leading: Icon(Icons.lightbulb),
          //   title: Text('micky'),
          //   onTap: () {
          //     Navigator.pop(context);
          //     if (currentScreen != 'micky') {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => LineChartCard(),
          //         ),
          //       );
          //     }
          //   },
          //   selected: currentScreen == 'micky',
          // ),
        ],
      ),
    );
  }
}
