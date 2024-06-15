// import 'dart:async';

// import 'package:Keron_Sensors_Finalexam/accelerometer_dashboard.dart';
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:sensors_plus/sensors_plus.dart';

// class AccelerometerChart extends StatefulWidget {
//   @override
//   _AccelerometerChartState createState() => _AccelerometerChartState();
// }

// class _AccelerometerChartState extends State<AccelerometerChart> {
//   late List<double> _accelerometerValues;
//   late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;
//   List<FlSpot> _lineChartSpots = [];

//   @override
//   void initState() {
//     super.initState();
//     _accelerometerValues = [0.0, 0.0,];
//     _accelerometerSubscription =
//         accelerometerEvents.listen((AccelerometerEvent event) {
//       setState(() {
//         _accelerometerValues = [event.x, event.y, event.z];
//         _addAccelerometerValuesToChart();
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _accelerometerSubscription.cancel();
//     super.dispose();
//   }

//   void _addAccelerometerValuesToChart() {
//     final time = DateTime.now().millisecondsSinceEpoch.toDouble();
//     _lineChartSpots.add(FlSpot(time, _accelerometerValues[0]));
//     if (_lineChartSpots.length > 100) {
//       _lineChartSpots.removeAt(0); // Keep only the latest 100 points
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LineChart(
//       LineChartData(
//         lineBarsData: [
//           LineChartBarData(
//             spots: _lineChartSpots,
//             isCurved: true,
//             color: Colors.blue,
//             barWidth: 2,
//             belowBarData: BarAreaData(show: false),
//           ),
//         ],
//         titlesData: FlTitlesData(
//           leftTitles: AxisTitles(
//             sideTitles: SideTitles(showTitles: true),
//           ),
//           bottomTitles: AxisTitles(
//             sideTitles: SideTitles(showTitles: false),
//           ),
//         ),
//         borderData: FlBorderData(show: true),
//       ),
//     );
//   }
// }

// class MotionDetectorCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       child: Padding(
//         padding: EdgeInsets.all(8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Motion Detector',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 4),
//             SizedBox(
//               width: double.infinity,
//               height: 200, // Adjust height as needed
//               child: AccelerometerChart(), // Your accelerometer chart widget
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:sensors_plus/sensors_plus.dart';

// class AccelerometerChart extends StatefulWidget {
//   @override
//   _AccelerometerChartState createState() => _AccelerometerChartState();
// }

// class _AccelerometerChartState extends State<AccelerometerChart> {
//   late List<double> _accelerometerValues;
//   late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;
//   List<FlSpot> _lineChartSpots = [];
//   late Timer _timer;
//   double _lastXValue = 0.0;

//   @override
//   void initState() {
//     super.initState();
//     _accelerometerValues = [0.0, 0.0, 0.0];
//     _accelerometerSubscription =
//         accelerometerEvents.listen((AccelerometerEvent event) {
//       _accelerometerValues = [event.x, event.y, event.z];
//     });
//     _startTimer();
//   }

//   void _startTimer() {
//     _timer = Timer.periodic(Duration(milliseconds: 500), (Timer timer) {
//       setState(() {
//         _addAccelerometerValuesToChart();
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _accelerometerSubscription.cancel();
//     _timer.cancel();
//     super.dispose();
//   }

//   void _addAccelerometerValuesToChart() {
//     _lastXValue += 0.5; // Increment x-axis value by 0.5 for each update
//     _lineChartSpots.add(FlSpot(_lastXValue, _accelerometerValues[0]));
//     if (_lineChartSpots.length > 100) {
//       _lineChartSpots.removeAt(0); // Keep only the latest 100 points
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LineChart(
//       LineChartData(
//         lineBarsData: [
//           LineChartBarData(
//             spots: _lineChartSpots,
//             isCurved: true,
//             color: Colors.blue,
//             barWidth: 2,
//             belowBarData: BarAreaData(show: false),
//           ),
//         ],
//         titlesData: FlTitlesData(
//           leftTitles: AxisTitles(
//             sideTitles: SideTitles(showTitles: true),
//           ),
//           bottomTitles: AxisTitles(
//             sideTitles: SideTitles(showTitles: false),
//           ),
//         ),
//         borderData: FlBorderData(show: true),
//       ),
//     );
//   }
// }

// class MotionDetectorCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       child: Padding(
//         padding: EdgeInsets.all(8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Motion Detector',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 4),
//             SizedBox(
//               width: double.infinity,
//               height: 250, // Adjust height as needed
//               child: AccelerometerChart(), // Your accelerometer chart widget
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }













// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:sensors_plus/sensors_plus.dart';

// class AccelerometerChart extends StatefulWidget {
//   @override
//   _AccelerometerChartState createState() => _AccelerometerChartState();
// }

// class _AccelerometerChartState extends State<AccelerometerChart> {
//   late List<double> _accelerometerValues;
//   late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;
//   List<FlSpot> _lineChartSpots = [];
//   late Timer _timer;
//   double _time = 0.0;

//   final double _minX = 0;
//   final double _maxX = 50;
//   final double _minY = -10;
//   final double _maxY = 20;

//   @override
//   void initState() {
//     super.initState();
//     _accelerometerValues = [0.0, 0.0, 0.0];
//     _accelerometerSubscription =
//         accelerometerEvents.listen((AccelerometerEvent event) {
//       _accelerometerValues = [event.x, event.y, event.z];
//     });
//     _startTimer();
//   }

//   void _startTimer() {
//     _timer = Timer.periodic(Duration(milliseconds: 500), (Timer timer) {
//       setState(() {
//         _addAccelerometerValuesToChart();
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _accelerometerSubscription.cancel();
//     _timer.cancel();
//     super.dispose();
//   }

//   void _addAccelerometerValuesToChart() {
//     if (_time >= _maxX) {
//       _time = _minX;
//       _lineChartSpots.clear();
//     } else {
//       _time += 0.5;
//     }
//     _lineChartSpots.add(FlSpot(_time, _accelerometerValues[0]));
//     if (_lineChartSpots.length > 100) {
//       _lineChartSpots.removeAt(0); // Keep only the latest 100 points
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LineChart(
//       LineChartData(
//         lineBarsData: [
//           LineChartBarData(
//             spots: _lineChartSpots,
//             isCurved: true,
//             color: Colors.blue,
//             barWidth: 3,
//             dotData: FlDotData(show: false),
//             belowBarData: BarAreaData(
//               show: true,
//               color: Colors.blue.withOpacity(0.3),
//             ),
//           ),
//         ],
//         titlesData: FlTitlesData(
//           leftTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               interval: 5,
//               reservedSize: 40,
//               getTitlesWidget: (value, meta) {
//                 return Padding(
//                   padding: const EdgeInsets.only(right: 8.0),
//                   child: Text(
//                     value.toStringAsFixed(1),
//                     style: TextStyle(color: Colors.black, fontSize: 12),
//                   ),
//                 );
//               },
//             ),
//           ),
//           bottomTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               interval: 10,
//               reservedSize: 40,
//               getTitlesWidget: (value, meta) {
//                 return Padding(
//                   padding: const EdgeInsets.only(top: 8.0),
//                   child: Text(
//                     value.toStringAsFixed(1),
//                     style: TextStyle(color: Colors.black, fontSize: 12),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//         borderData: FlBorderData(
//           show: true,
//           border: Border.all(color: Colors.grey, width: 1),
//         ),
//         minX: _minX,
//         maxX: _maxX,
//         minY: _minY,
//         maxY: _maxY,
//         gridData: FlGridData(
//           show: true,
//           drawVerticalLine: true,
//           getDrawingHorizontalLine: (value) {
//             return FlLine(
//               color: Colors.grey.withOpacity(0.5),
//               strokeWidth: 1,
//             );
//           },
//           getDrawingVerticalLine: (value) {
//             return FlLine(
//               color: Colors.grey.withOpacity(0.5),
//               strokeWidth: 1,
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class MotionDetectorCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       child: Padding(
//         padding: EdgeInsets.all(8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Motion Detector',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 4),
//             SizedBox(
//               width: double.infinity,
//               height: 250, // Adjust height as needed
//               child: AccelerometerChart(), // Your accelerometer chart widget
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'dart:async';
import 'dart:math'; // Importing dart:math for sqrt function
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sensors_plus/sensors_plus.dart';

class AccelerometerChart extends StatefulWidget {
  @override
  _AccelerometerChartState createState() => _AccelerometerChartState();
}

class _AccelerometerChartState extends State<AccelerometerChart> {
  late List<double> _accelerometerValues;
  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;
  List<FlSpot> _lineChartSpots = [];
  late Timer _timer;
  double _time = 0.0;

  final double _minX = 0;
  final double _maxX = 50;
  final double _minY = -10;
  final double _maxY = 20;

  @override
  void initState() {
    super.initState();
    _accelerometerValues = [0.0, 0.0, 0.0];
    _accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues = [event.x, event.y, event.z];
        _checkMotionStatus();
      });
    });
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 500), (Timer timer) {
      setState(() {
        _addAccelerometerValuesToChart();
      });
    });
  }

  @override
  void dispose() {
    _accelerometerSubscription.cancel();
    _timer.cancel();
    super.dispose();
  }

  void _addAccelerometerValuesToChart() {
    if (_time >= _maxX) {
      _time = _minX;
      _lineChartSpots.clear();
    } else {
      _time += 0.5;
    }
    _lineChartSpots.add(FlSpot(_time, _accelerometerValues[0]));
    if (_lineChartSpots.length > 100) {
      _lineChartSpots.removeAt(0); // Keep only the latest 100 points
    }
  }

  void _checkMotionStatus() {
    double x = _accelerometerValues[0];
    double y = _accelerometerValues[1];
    double z = _accelerometerValues[2];

    // Example thresholds, you may need to adjust these based on your requirements
    double motionThreshold = 5.0;
    double slowMotionThreshold = 1.0;

    double magnitude = sqrt(x * x + y * y + z * z); // Using sqrt function

    if (magnitude > motionThreshold) {
      _showNotification(context, 'Device is in motion');
    } else if (magnitude < slowMotionThreshold) {
      _showNotification(context, 'Device is in slow motion');
    }
  }

  void _showNotification(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: _lineChartSpots,
            isCurved: true,
            color: Colors.blue,
            barWidth: 3,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.blue.withOpacity(0.3),
            ),
          ),
        ],
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 5,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    value.toStringAsFixed(1),
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 10,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    value.toStringAsFixed(1),
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.grey, width: 1),
        ),
        minX: _minX,
        maxX: _maxX,
        minY: _minY,
        maxY: _maxY,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey.withOpacity(0.5),
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: Colors.grey.withOpacity(0.5),
              strokeWidth: 1,
            );
          },
        ),
      ),
    );
  }
}

class MotionDetectorCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Motion Detector',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            SizedBox(
              width: double.infinity,
              height: 250, // Adjust height as needed
              child: AccelerometerChart(), // Your accelerometer chart widget
            ),
          ],
        ),
      ),
    );
  }
}

