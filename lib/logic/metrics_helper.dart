class CurrencyHelper {
  var metricData = {'cm': 1.0, 'm': 100.0, 'km': 100000.0};

  double? convertTo(double amount, String? metricFrom, String? metricTo) {
    double? from = metricData[metricFrom];
    double? to = metricData[metricTo];
    double? convertedAmount = (from! / to!) * amount;

    return convertedAmount;
  }
}
