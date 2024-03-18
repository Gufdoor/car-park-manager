import "package:intl/intl.dart";

abstract class TimestampHelper {
  static int oneDayMilliseconds = 86400000;

  static String getDateTimeStringFromTimestamp(int timestamp) {
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
      timestamp,
    );

    return DateFormat("dd/MM/yyyy HH:mm").format(dateTime);
  }

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
