import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:dashboard_feirapp/constants/style.dart';

class ChartsDrivers extends StatefulWidget {
  String title1;
  double value1;

  String title2;
  double value2;

  String title3;
  double value3;

  String title4;
  double value4;

  ChartsDrivers({
    Key? key,
    required this.title1,
    required this.value1,
    required this.title2,
    required this.value2,
    required this.title3,
    required this.value3,
    required this.title4,
    required this.value4,
  }) : super(key: key);

  @override
  _ChartsDriversState createState() => _ChartsDriversState();
}

class _ChartsDriversState extends State<ChartsDrivers> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      _ChartData(widget.title1, widget.value1),
      _ChartData(widget.title2, widget.value2),
      _ChartData(widget.title3, widget.value3),
      _ChartData(widget.title4, widget.value4)
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: bgBlackMain,
        child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(minimum: 0, maximum: 50, interval: 10),
            tooltipBehavior: _tooltip,
            series: <ChartSeries<_ChartData, String>>[
              ColumnSeries<_ChartData, String>(
                  dataSource: data,
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  color: Color.fromRGBO(8, 142, 255, 1))
            ]));
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
