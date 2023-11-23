import 'package:intl/intl.dart';

extension DateTimeFormatter on DateTime {
  /// Returns date formatted using the supplied [format]
  /// the default format is like like 31/10/1990
  String readableDate({format = 'dd/MM/yyyy', String? locale}) {
    final DateFormat formatter = DateFormat(
      format,
      locale ?? 'en',
    );
    final String formatted = formatter.format(this);
    return formatted;
  }

  /// Returns time as String formatted using the supplied [format]
  /// the default format is like 05:30 am
  String readableTime({format = 'hh:mm a', String? locale}) {
    final DateFormat formatter = DateFormat(format, locale ?? 'en');
    final String formatted = formatter.format(this);
    return formatted;
  }

  /// Returns date and time formatted using the supplied [format]
  /// the default format is like like 31/10/1990 05:30 am
  String readableDateTime({format = 'dd/MM/yyyy hh:mm a', String? locale}) {
    final DateFormat formatter = DateFormat(format, locale ?? 'en');
    final String formatted = formatter.format(this);
    return formatted;
  }
}
