import 'package:easy_world_vendor/controller/dashboard/order_filter_temp_controller.dart';
import 'package:easy_world_vendor/controller/dashboard/order_screen_controller.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderFilterSheet extends StatelessWidget {
  final Function(DateTime start, DateTime end) onFilterSelected;
  OrderFilterSheet({super.key, required this.onFilterSelected});
  final c = Get.put(OrderScreenController());
  final filterTempController = Get.put(OrderFilterTempController());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GetBuilder<OrderFilterTempController>(
      builder: (controller) {
        return Container(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 20,
            bottom: 30,
          ),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkModeColor : AppColors.extraWhite,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Filter orders',
                  style: CustomTextStyles.f14W600(
                    color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildRangeButton(
                    controller,
                    'Last 1 month',
                    FilterOption.last1Month,
                    context,
                    isDark,
                  ),
                  buildRangeButton(
                    controller,
                    'Last 3 months',
                    FilterOption.last3Months,
                    context,
                    isDark,
                  ),
                  buildRangeButton(
                    controller,
                    'Last 6 months',
                    FilterOption.last6Months,
                    context,
                    isDark,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: buildDatePickerButton(
                      context,
                      controller,
                      isStart: true,
                      isDark: isDark,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      '—',
                      style: CustomTextStyles.f12W500(
                        color:
                            isDark
                                ? AppColors.extraWhite
                                : AppColors.secondaryTextColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: buildDatePickerButton(
                      context,
                      controller,
                      isStart: false,
                      isDark: isDark,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 35),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        controller.clear();
                        c.clearDateFilter();
                        Get.back();
                      },
                      child: Text(
                        'Reset',
                        style: CustomTextStyles.f14W400(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.primaryColor),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final now = DateTime.now();
                        DateTime? start;
                        DateTime end = now;

                        final selectedOption = controller.selectedOption;

                        if (selectedOption == FilterOption.last1Month) {
                          start = DateTime(now.year, now.month - 1, now.day);
                        } else if (selectedOption == FilterOption.last3Months) {
                          start = DateTime(now.year, now.month - 3, now.day);
                        } else if (selectedOption == FilterOption.last6Months) {
                          start = DateTime(now.year, now.month - 6, now.day);
                        } else if (selectedOption == FilterOption.custom &&
                            controller.customStart != null &&
                            controller.customEnd != null) {
                          start = controller.customStart;
                          end = controller.customEnd!;
                        }
                        if (start != null) {
                          Get.back();
                          onFilterSelected(start, end);
                        } else {
                          Get.back();
                          onFilterSelected(DateTime(2000), now);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                      ),
                      child: Text(
                        'Confirm',
                        style: CustomTextStyles.f14W400(
                          color: AppColors.extraWhite,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildRangeButton(
    OrderFilterTempController controller,
    String label,
    FilterOption option,
    BuildContext context,
    bool isDark,
  ) {
    final isSelected = controller.selectedOption == option;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.selectOption(option),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color:
                isSelected
                    ? AppColors.primaryColor.withOpacity(0.2)
                    : isDark
                    ? AppColors.blackColor.withOpacity(0.3)
                    : AppColors.lGrey,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? AppColors.primaryColor : Colors.transparent,
              width: 1.5,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: CustomTextStyles.f12W400(
              color: isDark ? AppColors.extraWhite : AppColors.blackColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDatePickerButton(
    BuildContext context,
    OrderFilterTempController controller, {
    required bool isStart,
    required bool isDark,
  }) {
    String label = isStart ? 'Start date' : 'End date';
    DateTime? date = isStart ? controller.customStart : controller.customEnd;
    return SizedBox(
      height: 40,
      child: OutlinedButton(
        onPressed: () async {
          final now = DateTime.now();
          final initialDate = date ?? now;
          final pickedDate = await showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: DateTime(2023, 1, 1),
            lastDate: now,
            helpText: isStart ? 'Select Start Date' : 'Select End Date',
            cancelText: 'Cancel',
            confirmText: 'OK',
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: AppColors.primaryColor,
                    onPrimary: Colors.white,
                    onSurface: Colors.black,
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primaryColor,
                    ),
                  ),
                ),
                child: child!,
              );
            },
          );

          if (pickedDate == null) return;

          if (isStart) {
            if (controller.customEnd != null &&
                pickedDate.isAfter(controller.customEnd!)) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Start date can't be after end date"),
                ),
              );
              return;
            }
            controller.setCustomStartDate(pickedDate);
          } else {
            if (controller.customStart != null &&
                pickedDate.isBefore(controller.customStart!)) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("End date can't be before start date"),
                ),
              );
              return;
            }
            controller.setCustomEndDate(pickedDate);
          }
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color:
                isDark ? AppColors.borderColor : AppColors.secondaryTextColor,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          date == null ? label : date.toLocal().toString().split(' ')[0],
          style: CustomTextStyles.f12W400(
            color:
                date == null
                    ? AppColors.secondaryTextColor
                    : isDark
                    ? AppColors.extraWhite
                    : AppColors.blackColor,
          ),
        ),
      ),
    );
  }
}
