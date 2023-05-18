import 'package:intl/intl.dart';

class Time {
  static final DateFormat _formatterDateTime = DateFormat('dd/MM HH:mm');

  static String nowDateTime() {
    return _formatterDateTime.format(DateTime.now());
  }
}
