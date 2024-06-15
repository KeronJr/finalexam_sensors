import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

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
        height: 200,
        child: Column(
          children: [
            Text(
              'Brightness',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Brightness: ${brightnessPercentage()}'),
                Slider(
                  value: brightness,
                  onChanged: onBrightnessChanged,
                ),
              ],
            ),
            Expanded(
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
          ],
        ),
      ),
    );
  }
}
