import 'package:intl/intl.dart';

class HumanFormats {

  static String humanReadbleNumber(double number, [int decimals = 0]) {

    final formatterNumber = NumberFormat.compactCurrency(
      decimalDigits: decimals,
      symbol: '',
      locale: 'en' // es
    ).format(number);

    return formatterNumber;
  }

}