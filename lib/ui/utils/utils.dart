import 'package:intl/intl.dart';

class Utils {
  static String formatDate(DateTime date) {
    final df = DateFormat(
      'dd-MMM-yyyy',
    );

    String formatedDate = df.format(date);
    return formatedDate;
  }
}
