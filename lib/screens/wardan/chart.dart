import 'package:echallan/controller/admin_controller.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:get/get.dart';
import 'chart_data.dart';

class DoughnutChart extends StatelessWidget {
  final double paid;
  final double unPaid;

  const DoughnutChart({
    super.key,
    required this.paid,
    required this.unPaid,
  });

  void _showDetailedFinanceDialog(BuildContext context) {
    final adminController = Get.find<AdminController>();

    double totalAmount = 0;
    double paidAmount = 0;
    double unpaidAmount = 0;

    for (var c in adminController.challanList) {
      double fineVal = double.tryParse(c.fine) ?? 0.0;
      totalAmount += fineVal;
      if (c.paymentStatus == 'paid') {
        paidAmount += fineVal;
      } else if (c.paymentStatus == 'unpaid') {
        unpaidAmount += fineVal;
      }
    }

    final double totalCount = adminController.challanList.length.toDouble();
    final double paidCount = adminController.paidChallans.length.toDouble();
    final double unpaidCount = adminController.unpaidChallans.length.toDouble();

    Get.dialog(
      Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 10,
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Financial Statistics",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A), // Slate 900
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.grey),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
                const Divider(color: Color(0xFFE2E8F0)),
                const SizedBox(height: 12),
                _buildFinanceDetailCard(
                  icon: Icons.payments_rounded,
                  label: "Total Fine Volume",
                  count: "${totalCount.toInt()} Challans",
                  amount: "Rs. ${totalAmount.toStringAsFixed(0)}",
                  color: const Color(0xFF6366F1), // Indigo
                ),
                const SizedBox(height: 10),
                _buildFinanceDetailCard(
                  icon: Icons.check_circle_rounded,
                  label: "Paid Collections",
                  count: "${paidCount.toInt()} Paid",
                  amount: "Rs. ${paidAmount.toStringAsFixed(0)}",
                  color: const Color(0xFF10B981), // Emerald Green
                ),
                const SizedBox(height: 10),
                _buildFinanceDetailCard(
                  icon: Icons.warning_rounded,
                  label: "Unpaid (Outstanding)",
                  count: "${unpaidCount.toInt()} Unpaid",
                  amount: "Rs. ${unpaidAmount.toStringAsFixed(0)}",
                  color: const Color(0xFFEF4444), // Rose Red
                ),
                const SizedBox(height: 20),
                const Text(
                  "Revenue Split",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF334155), // Slate 700
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 200,
                  child: SfCircularChart(
                    legend: const Legend(
                      isVisible: true,
                      position: LegendPosition.bottom,
                      overflowMode: LegendItemOverflowMode.wrap,
                      toggleSeriesVisibility: false,
                      textStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF475569),
                      ),
                    ),
                    series: <CircularSeries>[
                      DoughnutSeries<_RevenueChartData, String>(
                        dataSource: [
                          _RevenueChartData(
                              'Paid Rs', paidAmount, const Color(0xFF10B981)),
                          _RevenueChartData('Unpaid Rs', unpaidAmount,
                              const Color(0xFFEF4444)),
                        ],
                        pointColorMapper: (_RevenueChartData data, _) =>
                            data.color,
                        xValueMapper: (_RevenueChartData data, _) => data.label,
                        yValueMapper: (_RevenueChartData data, _) =>
                            data.amount,
                        dataLabelSettings: DataLabelSettings(
                          isVisible: totalAmount > 0,
                          labelPosition: ChartDataLabelPosition.inside,
                          builder: (dynamic data, dynamic point, dynamic series,
                              int pointIndex, int seriesIndex) {
                            if (totalAmount == 0)
                              return const SizedBox.shrink();
                            double percentage = (point.y / totalAmount) * 100;
                            return Text(
                              '${percentage.toStringAsFixed(0)}%',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                        radius: '85%',
                        innerRadius: '55%',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1467A7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                    ),
                    onPressed: () => Get.back(),
                    child: const Text(
                      "Dismiss",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFinanceDetailCard({
    required IconData icon,
    required String label,
    required String count,
    required String amount,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.15), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF334155),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  count,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double total = paid + unPaid;
    final List<ChartData> chartData = total == 0
        ? [
            ChartData('No Data', 1, Colors.grey.shade300),
          ]
        : [
            ChartData('Paid', paid, const Color(0xFF10B981)), // Emerald Green
            ChartData('Unpaid', unPaid, const Color(0xFFEF4444)), // Rose Red
          ];

    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showDetailedFinanceDialog(context),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Challan Distribution",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B), // Slate 800
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Visual breakdown of paid vs unpaid challans",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
                const Divider(height: 24, color: Colors.black12),
                SizedBox(
                  height: 220,
                  child: SfCircularChart(
                    legend: const Legend(
                      isVisible: true,
                      position: LegendPosition.bottom,
                      overflowMode: LegendItemOverflowMode.wrap,
                      toggleSeriesVisibility: false,
                      textStyle: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF475569), // Slate 600
                      ),
                    ),
                    series: <CircularSeries>[
                      DoughnutSeries<ChartData, String>(
                        dataSource: chartData,
                        pointColorMapper: (ChartData data, _) => data.color,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y,
                        dataLabelSettings: DataLabelSettings(
                          isVisible: total > 0,
                          labelPosition: ChartDataLabelPosition.inside,
                          builder: (dynamic data, dynamic point, dynamic series,
                              int pointIndex, int seriesIndex) {
                            if (total == 0) return const SizedBox.shrink();
                            double percentage = (point.y / total) * 100;
                            return Text(
                              '${percentage.toStringAsFixed(0)}%',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                        radius: '90%',
                        innerRadius: '50%',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RevenueChartData {
  final String label;
  final double amount;
  final Color color;

  _RevenueChartData(this.label, this.amount, this.color);
}
