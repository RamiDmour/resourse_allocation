import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:resourse_allocation/utils/PieElement.dart';

import 'indicator.dart';

class MyPieChart extends StatefulWidget {
  final List<PieElement> series;
  MyPieChart({this.series});

  @override
  State<StatefulWidget> createState() => MyPieChartState();
}

class MyPieChartState extends State<MyPieChart> {
  int touchedIndex;

  List<PieElement> get _series => widget.series;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 200,
      child: Row(
        children: <Widget>[
          Flexible(
            child: PieChart(
              PieChartData(
                  pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                    setState(() {
                      if (pieTouchResponse.touchInput is FlLongPressEnd ||
                          pieTouchResponse.touchInput is FlPanEnd) {
                        touchedIndex = -1;
                      } else {
                        touchedIndex = pieTouchResponse.touchedSectionIndex;
                      }
                    });
                  }),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections()),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ..._buildIndicators(),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildIndicators() {
    return _series
        .map((section) => Indicator(
              color: section.color,
              text: section.title,
              isSquare: true,
            ))
        .toList();
  }

  List<PieChartSectionData> showingSections() {
    int sum = _series.fold(0, (curr, next) => curr + next.value);

    print("Sum: $sum");

    return _series.map((section) {
      final isTouched = section.index == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      return PieChartSectionData(
        color: section.color,
        value: section.value.toDouble(),
        title: '${(section.value / sum * 100).toInt()}%',
        radius: radius,
        titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff)),
      );
    }).toList();
  }
}
