class ExchangeRateModel {
  final String baseCode;
  final Map<String, double> conversionRates;

  ExchangeRateModel({required this.baseCode, required this.conversionRates});

  factory ExchangeRateModel.fromJson(Map<String, dynamic> json) {
    final rawRates = json['conversion_rates'] as Map<String, dynamic>;
    final rates = rawRates.map(
      (key, value) => MapEntry(key, (value as num).toDouble()),
    );

    return ExchangeRateModel(
      baseCode: json['base_code'],
      conversionRates: rates,
    );
  }

  double getRate(String targetCode) {
    return conversionRates[targetCode] ?? 0.0;
  }
}
