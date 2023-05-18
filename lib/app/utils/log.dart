import 'time.dart';

class Log {
  static const int levelErr = 1;
  static const int levelWarn = 2;
  static const int levelInfo = 3;
  static const int levelDebug = 4;

  static const String nameErr = "ERR";
  static const String nameWarn = "WARN";
  static const String nameInfo = "INFO";
  static const String nameDebug = "DEBUG";

  static int? level = levelDebug;

  static err(String msg) => _log(msg, levelErr, nameErr);
  static warn(String msg) => _log(msg, levelWarn, nameWarn);
  static info(String msg) => _log(msg, levelInfo, nameInfo);
  static debug(String msg) => _log(msg, levelDebug, nameDebug);

  static _log(String msg, int level, String name) {
    if (level <= Log.level!) print("${Time.nowDateTime()} $name $msg");
  }
}
