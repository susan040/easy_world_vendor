import 'package:easy_world_vendor/controller/dashboard/home_screen_controller.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GraphWidget extends StatelessWidget {
  const GraphWidget({super.key, required this.isDark, required this.c});

  final bool isDark;
  final HomeScreenController c;

  @override
  Widget build(BuildContext context) {
    final tabs = ['Bar Chart', 'Line Chart'];

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
          // Toggle Buttons
          Obx(() {
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[800] : Colors.grey[100],
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: ToggleButtons(
                borderRadius: BorderRadius.circular(5),
                fillColor: AppColors.primaryColor,
                selectedColor: AppColors.extraWhite,
                color: isDark ? Colors.white70 : Colors.black87,
                constraints: const BoxConstraints(minHeight: 37, minWidth: 142),
                isSelected: List.generate(
                  tabs.length,
                  (i) => i == c.chartTypeIndex.value,
                ),
                onPressed: c.updateChartType,
                children:
                    tabs
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
            );
          }),
          const SizedBox(height: 8),
          Obx(() {
            final totalSales =
                double.tryParse(c.earningDetails.value?.totalSales ?? '0') ?? 0;
            final totalCommission =
                double.tryParse(
                  c.earningDetails.value?.totalCommission ?? '0',
                ) ??
                0;
            final netEarnings =
                double.tryParse(c.earningDetails.value?.netEarnings ?? '0') ??
                0;

            final maxY =
                [
                  totalSales,
                  totalCommission,
                  netEarnings,
                ].reduce((a, b) => a > b ? a : b) *
                1.3;

            if (c.chartTypeIndex.value == 0) {
              // Bar Chart
              return Container(
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[800] : Colors.grey[100],
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.only(
                  left: 14,
                  right: 14,
                  top: 14,
                  bottom: 14,
                ),
                child: AspectRatio(
                  aspectRatio: 1.45,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: maxY,
                      barTouchData: BarTouchData(enabled: true),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            interval: maxY / 5,
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
                            getTitlesWidget: (value, meta) {
                              switch (value.toInt()) {
                                case 0:
                                  return buildBottomTitle(
                                    'Total Sales',
                                    isDark,
                                  );
                                case 1:
                                  return buildBottomTitle('Commission', isDark);
                                case 2:
                                  return buildBottomTitle(
                                    'Net Earnings',
                                    isDark,
                                  );
                                default:
                                  return const SizedBox.shrink();
                              }
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
                      gridData: FlGridData(
                        show: true,
                        horizontalInterval: maxY / 5,
                      ),
                      borderData: FlBorderData(show: false),
                      barGroups: [
                        BarChartGroupData(
                          x: 0,
                          barsSpace: 4,
                          barRods: [
                            BarChartRodData(
                              toY: totalSales,
                              color: Color(0xFF375A7F), // Dark Slate Blue
                              width: 40,
                              borderRadius: BorderRadius.circular(8),
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                toY: maxY,
                                color: Color(0xFF375A7F).withOpacity(0.25),
                              ),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 1,
                          barsSpace: 4,
                          barRods: [
                            BarChartRodData(
                              toY: totalCommission,
                              color: Color(0xFFAA6F73), // Dusty Rose
                              width: 40,
                              borderRadius: BorderRadius.circular(8),
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                toY: maxY,
                                color: Color(0xFFAA6F73).withOpacity(0.25),
                              ),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 2,
                          barsSpace: 4,
                          barRods: [
                            BarChartRodData(
                              toY: netEarnings,
                              color: Color(
                                0xFF8F7352,
                              ), // Muted Olive (darker than pale yellow)
                              width: 40,
                              borderRadius: BorderRadius.circular(8),
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                toY: maxY,
                                color: Color(0xFF8F7352).withOpacity(0.25),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              final values = [
                double.tryParse(c.earningDetails.value?.totalSales ?? '0') ?? 0,
                double.tryParse(
                      c.earningDetails.value?.totalCommission ?? '0',
                    ) ??
                    0,
                double.tryParse(c.earningDetails.value?.netEarnings ?? '0') ??
                    0,
              ];

              final legendTitles = [
                'Total Sales',
                'Commission',
                'Net Earnings',
              ];
              final colors = [
                Color(0xFFB39DDB), // Lavender Purple
                Color(0xFFFFABAB), // Light Coral
                Color(0xFFFFE066), // Warm Pastel Yellow
              ];

              return Obx(() {
                final touched = c.touchedIndex.value;

                final pieSections = List.generate(3, (i) {
                  final isTouched = i == touched;
                  final radius = isTouched ? 70.0 : 60.0;
                  final value = values[i];
                  return PieChartSectionData(
                    value: value,
                    color: colors[i],
                    borderSide: BorderSide.none,
                    radius: radius,
                    title: isTouched ? '\$${value.toStringAsFixed(2)}' : '',
                    titleStyle: CustomTextStyles.f12W500(
                      color:
                          isDark ? AppColors.extraWhite : AppColors.blackColor,
                    ),
                    titlePositionPercentageOffset: 0.5,
                  );
                });

                return Container(
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[800] : Colors.grey[100],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AspectRatio(
                        aspectRatio: 1.7,
                        child: PieChart(
                          PieChartData(
                            sectionsSpace: 0,
                            sections: pieSections,
                            centerSpaceRadius: 25,
                            borderData: FlBorderData(show: false),
                            pieTouchData: PieTouchData(
                              touchCallback: (event, response) {
                                if (!event.isInterestedForInteractions ||
                                    response == null ||
                                    response.touchedSection == null) {
                                  c.updateTouchedIndex(null);
                                  return;
                                }
                                c.updateTouchedIndex(
                                  response.touchedSection!.touchedSectionIndex,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 16,
                        runSpacing: 8,
                        alignment: WrapAlignment.center,
                        children: List.generate(legendTitles.length, (i) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: colors[i],
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                legendTitles[i],
                                style: CustomTextStyles.f11W500(
                                  color:
                                      isDark
                                          ? AppColors.extraWhite
                                          : AppColors.blackColor,
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                );
              });
            }
          }),
        ],
      ),
    );
  }

  Widget buildBottomTitle(String text, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Text(
        text,
        style: CustomTextStyles.f11W500(
          color: isDark ? AppColors.extraWhite : AppColors.blackColor,
        ),
      ),
    );
  }
}
