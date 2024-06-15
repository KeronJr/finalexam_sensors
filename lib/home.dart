// import 'package:Keron_Sensors_Finalexam/accelerom_card.dart';
// import 'package:Keron_Sensors_Finalexam/drawer.dart';
// import 'package:Keron_Sensors_Finalexam/light.dart';
// import 'package:Keron_Sensors_Finalexam/locationcard.dart';
// import 'package:Keron_Sensors_Finalexam/motion.dart';
// import 'package:Keron_Sensors_Finalexam/widgets/dashboard_widget.dart';
// import 'package:fl_chart/fl_chart.dart';


// import 'package:flutter/material.dart';

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sensor Assignment'),
//       ),
//       drawer: DrawerScreen(currentScreen: 'Home'),
//       body: SingleChildScrollView(
//         // child: DashboardWidget(),
//         // child: LocationCard()
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             LocationCard(),
//             // DashboardWidget(),
//             SizedBox(height: 50),
//             MotionDetectorCard(),
//             SizedBox(height: 50),
//             // Light()
            
//             LightCard(
//           brightness: initialBrightness,
//           onBrightnessChanged: (double value) {
//             // Handle brightness change here
//             // For example, you can update the brightness value in the state of this widget
//           },
//         ),
//             // Your other widgets
//             // LineChartCard(),
//             //       LineChartCard(
//             //   accelerometerXData: _accelerometerXData,
//             //   accelerometerYData: _accelerometerYData,
//             //   accelerometerZData: _accelerometerZData,
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:fl_chart/fl_chart.dart';

// class LightCard extends StatelessWidget {
//   final double brightness;
//   final Function(double) onBrightnessChanged;

//   const LightCard({
//     required this.brightness,
//     required this.onBrightnessChanged,
//   });

//   String brightnessPercentage() {
//     int percentage = (brightness * 100).round();
//     return '$percentage%';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       child: Container(
//         padding: EdgeInsets.all(20),
//         width: MediaQuery.of(context).size.width * 0.8,
//         height: 200,
//         child: Column(
//           children: [
//             Text(
//               'Brightness',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Brightness: ${brightnessPercentage()}'),
//                 Slider(
//                   value: brightness,
//                   onChanged: onBrightnessChanged,
//                 ),
//               ],
//             ),
//             Expanded(
//               child: PieChart(
//                 PieChartData(
//                   sections: [
//                     PieChartSectionData(
//                       color: Colors.green,
//                       value: brightness,
//                       title: brightnessPercentage(),
//                       radius: 50,
//                     ),
//                     PieChartSectionData(
//                       color: Colors.grey[300]!,
//                       value: 1 - brightness,
//                       title: '',
//                       radius: 50,
//                     ),
//                   ],
//                   centerSpaceRadius: 40,
//                   sectionsSpace: 0,
//                   startDegreeOffset: -90,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




// // import 'package:fl_chart/fl_chart.dart';
// // import 'package:flutter/material.dart';
// // import 'package:Keron_Sensors_Finalexam/accelerom_card.dart';
// // import 'package:Keron_Sensors_Finalexam/drawer.dart';

// // class MyHomePage extends StatelessWidget {
// //   final List<FlSpot> accelerometerXData;
// //   final List<FlSpot> accelerometerYData;
// //   final List<FlSpot> accelerometerZData;

// //   const MyHomePage({
// //     Key? key,
// //     required this.accelerometerXData,
// //     required this.accelerometerYData,
// //     required this.accelerometerZData,
// //   }) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Sensor Assignment'),
// //       ),
// //       drawer: DrawerScreen(currentScreen: 'Home'),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           crossAxisAlignment: CrossAxisAlignment.center,
// //           children: <Widget>[
// //             // Your other widgets
// //             LineChartCard(
// //               accelerometerXData: accelerometerXData,
// //               accelerometerYData: accelerometerYData,
// //               accelerometerZData: accelerometerZData,
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }


import 'package:Keron_Sensors_Finalexam/drawer.dart';
import 'package:Keron_Sensors_Finalexam/locationcard.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:Keron_Sensors_Finalexam/motion.dart';
import 'package:Keron_Sensors_Finalexam/widgets/dashboard_widget.dart';
import 'package:Keron_Sensors_Finalexam/light.dart'; // Import the LightCard widget

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double brightness = 0.5; // Initial brightness value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sensor Assignment'),
      ),
      drawer: DrawerScreen(currentScreen: 'Home'),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            LocationCard(),
            SizedBox(height: 50),
            MotionDetectorCard(),
            SizedBox(height: 50),
            LightCard(
              brightness: brightness,
              onBrightnessChanged: (double value) {
                setState(() {
                  brightness = value; // Update the brightness value
                });
              },
            ),
            // Your other widgets
          ],
        ),
      ),
    );
  }
}




class LightCard extends StatelessWidget {
  final double brightness;
  final Function(double) onBrightnessChanged;

  const LightCard({
    required this.brightness,
    required this.onBrightnessChanged,
  });

  String brightnessPercentage() {
    int percentage = (brightness * 100).round();
    return '$percentage%';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Brightness',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text('Brightness: ${brightnessPercentage()}'),
                ),
                Expanded(
                  flex: 7,
                  child: Slider(
                    value: brightness,
                    onChanged: onBrightnessChanged,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            AspectRatio(
              aspectRatio: 1.5,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        color: Colors.green,
                        value: brightness,
                        title: brightnessPercentage(),
                        radius: 50,
                      ),
                      PieChartSectionData(
                        color: Colors.grey[300]!,
                        value: 1 - brightness,
                        title: '',
                        radius: 50,
                      ),
                    ],
                    centerSpaceRadius: 40,
                    sectionsSpace: 0,
                    startDegreeOffset: -90,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

