import 'package:intl/intl.dart';

class MyFormatter {
  static String formatDate(String date) {
    final DateTime parsedDate = DateTime.parse(date).toLocal();
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(parsedDate);
  }

  static String formatDateTime(DateTime date) {
    date = date.toLocal();
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }

  static String formatCurrency(int amout) {
    var formatter = NumberFormat('#,###,###');
    var t = NumberFormat.currency(locale: "vi");
    return "${formatter.format(amout)} ${t.currencySymbol}";
  }

  static String formatDouble(double number) {
    if (number == number.toInt()) {
      return number.toInt().toString();
    } else {
      return number.toString();
    }
  }
}
