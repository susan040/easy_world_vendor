import 'dart:developer';
import 'package:easy_world_vendor/controller/core_controller.dart';
import 'package:easy_world_vendor/controller/dashboard/profile_screen_controller.dart';
import 'package:easy_world_vendor/models/exchange_rate.dart';
import 'package:easy_world_vendor/repo/edit_profile_repo.dart';
import 'package:easy_world_vendor/utils/custom_snackbar.dart';
import 'package:easy_world_vendor/utils/storage_keys.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ExchangeRateController extends GetxController {
  final coreController = Get.put(CoreController());
  final profileController = Get.put(ProfileScreenController());
  RxList<String> countryList = <String>[].obs;
  Rxn<ExchangeRateModel> latestRates = Rxn<ExchangeRateModel>();
  var isLoading = true.obs;
  @override
  void onInit() {
    super.onInit();
    setInitialCountry();
    fetchRates();
  }

  final List<Map<String, String>> allCountries = [
    {'name': 'Nepal', 'code': 'NPR', 'flag': 'assets/images/nepal_flag.png'},
    {
      'name': 'Australia',
      'code': 'AUD',
      'flag': 'assets/images/australia_flag.png',
    },
  ];
  RxMap<String, String> selectedCountryData = <String, String>{}.obs;

  void setInitialCountry() {
    final userPreference =
        coreController.currentUser.value?.data?.currencyPreference ?? 'NPR';

    final country = allCountries.firstWhere(
      (e) => e['code'] == userPreference,
      orElse: () => allCountries[0],
    );

    selectedCountryData.value = country;
  }

  void updateSelectedCountry(Map<String, String> newCountry) {
    selectedCountryData.value = newCountry;
  }

  Future<void> fetchRates() async {
    const baseCurrency = 'AUD';
    final url =
        'https://v6.exchangerate-api.com/v6/93c8ff90cc1a9113251e09a4/latest/$baseCurrency';

    final response = await http.get(Uri.parse(url));
    final jsonData = json.decode(response.body);
    // log("Exchange Rate API response: $jsonData");

    latestRates.value = ExchangeRateModel.fromJson(jsonData);
  }

  void editCurrencyPreference() async {
    isLoading.value = true;
    await EditCountryPreferenceRepo.editCountryPreferenceRepo(
      countryPreference: selectedCountryData['code']!,
      onSuccess: (user, token, message) async {
        isLoading.value = false;
        final box = GetStorage();
        final coreController = Get.put(CoreController());
        if (user.token == null) {
          user.token = coreController.currentUser.value?.token;
          log("User token is null, using current user token: ${user.token}");
        }

        await box.write(StorageKeys.USER, json.encode(user.toJson()));
        await box.write(StorageKeys.ACCESS_TOKEN, token);
        coreController.currentUser.value = user;
        profileController.userDetails();
        Get.put(CoreController()).loadCurrentUser();
      },
      onError: (message) {
        isLoading.value = false;
        CustomSnackBar.error(title: "Profile", message: message);
      },
    );
  }

  double convertPriceFromAUD(String? productPriceString) {
    final countryCode = selectedCountryData['code'] ?? 'AUD';
    final rate = latestRates.value?.getRate(countryCode);
    final productPrice = double.tryParse(productPriceString ?? '');
    log(
      "Converting price: $productPriceString, Parsed: $productPrice, Country: $countryCode, Rate: $rate",
    );
    if (rate == null || productPrice == null) return 0.0;
    return productPrice * rate;
  }
}
