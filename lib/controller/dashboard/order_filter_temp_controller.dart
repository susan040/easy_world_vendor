import 'package:get/get.dart';

enum FilterOption { last1Month, last3Months, last6Months, custom }

class OrderFilterTempController extends GetxController {
  FilterOption? selectedOption;
  DateTime? customStart;
  DateTime? customEnd;

  void selectOption(FilterOption option) {
    selectedOption = option;
    if (option != FilterOption.custom &&
        selectedOption != FilterOption.custom) {
      customStart = null;
      customEnd = null;
    }

    update();
  }

  void setCustomStartDate(DateTime start) {
    customStart = start;
    selectedOption = FilterOption.custom;
    update();
  }

  void setCustomEndDate(DateTime end) {
    customEnd = end;
    selectedOption = FilterOption.custom;
    update();
  }

  void clear() {
    selectedOption = null;
    customStart = null;
    customEnd = null;
    update();
  }
}
