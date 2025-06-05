import 'package:easy_world_vendor/controller/dashboard/home_screen_controller.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeBarChartWidget extends StatelessWidget {
  const HomeBarChartWidget({super.key, required this.isDark, required this.c});

  final bool isDark;
  final HomeScreenController c;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDark ? AppColors.blackColor : Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : AppColors.lGrey,
            spreadRadius: 2,
            blurRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[800] : AppColors.lGrey,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child: ToggleButtons(
                borderRadius: BorderRadius.circular(5),
                fillColor: AppColors.primaryColor,
                selectedColor: AppColors.extraWhite,
                color: isDark ? Colors.white70 : Colors.black87,
                constraints: const BoxConstraints(minHeight: 37),
                isSelected: List.generate(
                  c.tabs.length,
                  (i) => i == c.selectedTabIndex.value,
                ),
                onPressed: c.updateTab,
                children:
                    c.tabs
                        .map(
                          (tab) => Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 28.5,
                              vertical: 8,
                            ),
                            child: Text(
                              tab,
                              style: CustomTextStyles.f12W500(
                                color:
                                    isDark
                                        ? AppColors.extraWhite
                                        : AppColors.blackColor,
                              ),
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Obx(() {
            int selected = c.selectedTabIndex.value;
            List<double> data = c.chartData[selected];
            List<String> labels = c.bottomLabels[selected];
            double maxY = (data.reduce((a, b) => a > b ? a : b)) * 1.2;

            if (selected == 1) {
              // Monthly - show Line Chart
              return Container(
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[900] : AppColors.lGrey,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: AspectRatio(
                  aspectRatio: 1.5,
                  child: LineChart(
                    LineChartData(
                      maxY: maxY,
                      minY: 0,
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 28,
                            getTitlesWidget:
                                (value, meta) => Text(
                                  value.toInt().toString(),
                                  style: CustomTextStyles.f10W500(
                                    color:
                                        isDark
                                            ? AppColors.extraWhite
                                            : AppColors.blackColor,
                                  ),
                                ),
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              int index = value.toInt();
                              if (index < 0 || index >= labels.length)
                                return const SizedBox.shrink();
                              return Text(
                                labels[index],
                                style: CustomTextStyles.f10W500(
                                  color:
                                      isDark
                                          ? AppColors.extraWhite
                                          : AppColors.blackColor,
                                ),
                              );
                            },
                          ),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      gridData: FlGridData(show: true),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: List.generate(
                            data.length,
                            (index) => FlSpot(index.toDouble(), data[index]),
                          ),
                          isCurved: true,
                          barWidth: 3,
                          color: AppColors.primaryColor,
                          dotData: FlDotData(show: true),
                          belowBarData: BarAreaData(show: false),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              // Weekly or Yearly - show Bar Chart
              return Container(
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[900] : AppColors.lGrey,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: AspectRatio(
                  aspectRatio: 1.5,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: maxY,
                      barTouchData: BarTouchData(enabled: true),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 28,
                            getTitlesWidget:
                                (value, meta) => Text(
                                  value.toInt().toString(),
                                  style: CustomTextStyles.f10W500(
                                    color:
                                        isDark
                                            ? AppColors.extraWhite
                                            : AppColors.blackColor,
                                  ),
                                ),
                          ),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              int index = value.toInt();
                              if (index < 0 || index >= labels.length)
                                return const SizedBox.shrink();
                              return Text(
                                labels[index],
                                style: CustomTextStyles.f10W500(
                                  color:
                                      isDark
                                          ? AppColors.extraWhite
                                          : AppColors.blackColor,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      gridData: FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      barGroups: List.generate(data.length, (index) {
                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: data[index],
                              width: 20,
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(6),
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                toY: maxY,
                                color: AppColors.primaryColor.withOpacity(0.2),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
