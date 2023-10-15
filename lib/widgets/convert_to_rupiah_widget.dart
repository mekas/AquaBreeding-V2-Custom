import 'package:intl/intl.dart';

class ConvertToRupiah {
  static String formatToRupiah(int value) {
    final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: '');
    return formatCurrency.format(value);
  }
}
