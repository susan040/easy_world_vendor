import 'package:get/get.dart';

class CountryController extends GetxController {
  RxString selectedCountry = 'Nepal'.obs;

  final List<Map<String, String>> countries = [
    {'name': 'Nepal', 'code': 'NP', 'flag': 'assets/images/nepal_flag.png'},
    {
      'name': 'Australia',
      'code': 'AU',
      'flag': 'assets/images/australia_flag.png',
    },
  ];

  void chooseCountry(String countryName) {
    selectedCountry.value = countryName;
  }

  Map<String, String> get selectedCountryData =>
      countries.firstWhere((c) => c['name'] == selectedCountry.value);
}
