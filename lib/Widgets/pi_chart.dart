import 'package:expenz/constant/colors.dart';
import 'package:expenz/constant/constant.dart';
import 'package:expenz/models/expenze_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatefulWidget {
  final Map<ExpenzeCategoaries, double> expenzecategoryTotal;
  final Map<IncomeCatogary, double> incomecategoryTotal;
  final bool isExpenze;

  const Chart({
    super.key,
    required this.expenzecategoryTotal,
    required this.incomecategoryTotal,
    required this.isExpenze,
  });

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  //section data
  List<PieChartSectionData> getSection() {
    if (widget.isExpenze) {
      return [
        PieChartSectionData(
          color: expenzeCategoariesColors[ExpenzeCategoaries.food],
          value: widget.expenzecategoryTotal[ExpenzeCategoaries.food] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: expenzeCategoariesColors[ExpenzeCategoaries.health],
          value: widget.expenzecategoryTotal[ExpenzeCategoaries.health] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: expenzeCategoariesColors[ExpenzeCategoaries.shopping],
          value: widget.expenzecategoryTotal[ExpenzeCategoaries.shopping] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: expenzeCategoariesColors[ExpenzeCategoaries.subscriptions],
          value:
              widget.expenzecategoryTotal[ExpenzeCategoaries.subscriptions] ??
                  0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: expenzeCategoariesColors[ExpenzeCategoaries.transport],
          value: widget.expenzecategoryTotal[ExpenzeCategoaries.transport] ?? 0,
          showTitle: false,
          radius: 60,
        )
      ];
    } else {
      return [
        PieChartSectionData(
          color: incomeCatogaryColor[IncomeCatogary.freelance],
          value: widget.incomecategoryTotal[IncomeCatogary.freelance] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: incomeCatogaryColor[IncomeCatogary.salary],
          value: widget.incomecategoryTotal[IncomeCatogary.salary] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: incomeCatogaryColor[IncomeCatogary.passive],
          value: widget.incomecategoryTotal[IncomeCatogary.passive] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: incomeCatogaryColor[IncomeCatogary.sales],
          value: widget.incomecategoryTotal[IncomeCatogary.sales] ?? 0,
          showTitle: false,
          radius: 60,
        )
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final PieChartData pieChartData = PieChartData(
      sectionsSpace: 0,
      centerSpaceRadius: 70,
      sections: getSection(),
      startDegreeOffset: -90,
      borderData: FlBorderData(show: false),
    );
    return Container(
      height: 250,
      padding: EdgeInsets.all(kdefaultPadding),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(pieChartData),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "70",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: kBlack,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "100",
                style: TextStyle(
                  color: kGrey,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
