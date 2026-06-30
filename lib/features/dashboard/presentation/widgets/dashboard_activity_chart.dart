import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../core/theme/src/app_colors.dart';

class DashboardActivityChart extends StatelessWidget {
  const DashboardActivityChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: AppColors.systemGroupedBackgroundDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.separatorDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Tren Aktivitas Log (7 Hari Terakhir)",
            style: TextStyle(
              color: AppColors.textColorDark,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 200,
                  getDrawingHorizontalLine: (value) {
                    return const FlLine(
                      color: AppColors.separatorDark,
                      strokeWidth: 1,
                      dashArray: [5, 5],
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        const style = TextStyle(
                          color: AppColors.secondaryTextColorDark,
                          fontSize: 12,
                        );
                        Widget text;
                        switch (value.toInt()) {
                          case 1:
                            text = const Text('Sen', style: style);
                            break;
                          case 2:
                            text = const Text('Sel', style: style);
                            break;
                          case 3:
                            text = const Text('Rab', style: style);
                            break;
                          case 4:
                            text = const Text('Kam', style: style);
                            break;
                          case 5:
                            text = const Text('Jum', style: style);
                            break;
                          case 6:
                            text = const Text('Sab', style: style);
                            break;
                          case 7:
                            text = const Text('Min', style: style);
                            break;
                          default:
                            text = const Text('', style: style);
                            break;
                        }
                        return SideTitleWidget(
                          meta: meta,
                          space: 8.0,
                          child: text,
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 200,
                      reservedSize: 42,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                            color: AppColors.secondaryTextColorDark,
                            fontSize: 12,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minX: 1,
                maxX: 7,
                minY: 0,
                maxY: 1000,
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(1, 300),
                      FlSpot(2, 450),
                      FlSpot(3, 350),
                      FlSpot(4, 700),
                      FlSpot(5, 500),
                      FlSpot(6, 800),
                      FlSpot(7, 650),
                    ],
                    isCurved: true, // Membuat garisnya melengkung elegan
                    color: AppColors.primaryDark,
                    barWidth: 4,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppColors.primaryDark.withValues(alpha: 0.15,
                      ), // Efek gradient di bawah garis
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
