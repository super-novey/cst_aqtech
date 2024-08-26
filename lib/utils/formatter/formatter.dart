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
}
