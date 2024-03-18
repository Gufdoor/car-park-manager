import "package:intl/intl.dart";

abstract class TimestampHelper {
  static int oneDayMilliseconds = 86400000;

  static String getDateTimeStringFromTimestamp(
    int timestamp, {
    bool isUtc = false,
  }) {
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
      timestamp,
      isUtc: isUtc,
    );

    return DateFormat("dd/MM/yyyy HH:mm").format(dateTime);
  }

  /// This method aims to get the current timestamp and adjust it to a value
  /// equivalent to this day's midnight
  static int getTodayTimestamp() {
    return DateTime.now()
        .subtract(Duration(
          hours: DateTime.now().hour,
          minutes: DateTime.now().minute,
          seconds: DateTime.now().second,
          milliseconds: DateTime.now().millisecond,
        ))
        .millisecondsSinceEpoch;
  }
}
