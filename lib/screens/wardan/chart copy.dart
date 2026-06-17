import 'package:echallan/constants/constants.dart';
import 'package:echallan/controller/admin_controller.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'chart_data.dart';
import 'package:get/get.dart';

class DoughnutChart extends StatelessWidget {
  final double paid;
  final double unPaid;
  final adminController = Get.find<AdminController>();
  DoughnutChart({super.key, required this.paid, required this.unPaid});

  @override
  Widget build(BuildContext context) {
    print(adminController.paidChallans.length.toDouble());
    print(adminController.unpaidChallans.length.toDouble());
    final List<ChartData> chartData = [
      ChartData('Paid', adminController.paidChallans.length.toDouble(),
          const Color.fromARGB(255, 194, 28, 16)),
      ChartData('UnPaid', adminController.unpaidChallans.length.toDouble(),
          const Color.fromARGB(255, 119, 24, 17)),
    ];

    return Container(
      child: SfCircularChart(
        legend: Legend(
          isVisible: true,
          position: LegendPosition.right,
          overflowMode: LegendItemOverflowMode.wrap,
          textStyle: TextStyle(
            fontSize: 10.0.sp,
          ),
          iconHeight: 20, // Set the icon height
          iconWidth: 20, // Set the icon width
          legendItemBuilder:
              (String name, dynamic series, dynamic point, int index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 8.w, // Custom icon width
                      height: 2.h,
                      // Custom icon height
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.h),
                        shape: BoxShape.rectangle, // Custom shape
                        color: chartData[index].color,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      name,
                      style: TextStyle(
                          fontSize: 13,
                          color: Constants.textColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
        series: <CircularSeries>[
          DoughnutSeries<ChartData, String>(
            dataSource: chartData,
            pointColorMapper: (ChartData data, _) => data.color,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.inside,
              useSeriesColor: true,
              textStyle: TextStyle(
                fontSize: 10.0.sp,
                color: Colors.white,
              ),
              builder: (dynamic data, dynamic point, dynamic series,
                  int pointIndex, int seriesIndex) {
                double percentage = (point.y /
                        chartData.map((e) => e.y).reduce((a, b) => a + b)) *
                    100;
                return Text(
                  ' ${percentage.toStringAsFixed(0)}%',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                );
              },
            ),
            radius: '75%',
            innerRadius:
                '70%', // Adjust inner radius to control doughnut thickness
          ),
        ],
      ),
    );
  }
}
