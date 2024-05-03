import 'dart:io';

import 'package:intl/intl.dart';

NumberFormat naira() {
  var format =
      NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');

  return format;
}

NumberFormat gbp() {
  var format =
      NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'GBP');

  return format;
}

amountFormatter(double number) {
  final formatted = NumberFormat.decimalPattern().format(number);

  return formatted;
}

//"₦ ${amountFormatter(100000)}",
