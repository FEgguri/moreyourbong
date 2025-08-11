import 'package:intl/intl.dart';

class DateTimeUtils {
  // DataeTimeUtils().format
  // DataeTimeUtils.formatString
  static String formatString(DateTime oldTime, DateTime newTime) {
    final diff = newTime.difference(oldTime);

    if (diff.inMinutes < 1) {
      // 1분 이내
      return "";
    } else {
      return newTime.toString();
    }
  }
}
