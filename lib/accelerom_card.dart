// // import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:sensors_plus/sensors_plus.dart';
// import 'dart:async';

// class AccelerometerChart extends StatefulWidget {
//   @override
//   _AccelerometerChartState createState() => _AccelerometerChartState();
// }

// class _AccelerometerChartState extends State<AccelerometerChart> {
//   late List<double> _accelerometerValues;
//   late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;
//   List<FlSpot> _lineChartSpots = [];
//   Timer? _debounceTimer;

//   @override
//   void initState() {
//     super.initState();
//     _accelerometerValues = [0.0, 0.0, 0.0];
//     _accelerometerSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
//       _handleAccelerometerData(event);
//     });
//   }

//   @override
//   void dispose() {
//     _accelerometerSubscription.cancel();
//     _debounceTimer?.cancel();
//     super.dispose();
//   }

//   void _handleAccelerometerData(AccelerometerEvent event) {
//     // Cancel any existing debounce timer
//     _debounceTimer?.cancel();

//     // Start a new debounce timer
//     _debounceTimer = Timer(Duration(milliseconds: 100), () {
//       // Process accelerometer data after debounce time
//       setState(() {
//         _accelerometerValues = [event.x, event.y, event.z];
//         _addAccelerometerValuesToChart();
//       });
//     });
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
//             colors: [Colors.blue],
//             barWidth: 2,
//             belowBarData: BarAreaData(show: false),
//           ),
//         ],
//         titlesData: FlTitlesData(
//           leftTitles: SideTitles(showTitles: true),
//           bottomTitles: SideTitles(showTitles: false),
//         ),
//         borderData: FlBorderData(show: true),
//       ),
//     );
//   }
// }
