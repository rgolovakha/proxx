import 'package:flutter/material.dart';

class Screen {
  static void set(BuildContext context, String route, [Object? arg]) {
    Navigator.pushReplacementNamed(context, route, arguments: arg);
  }

  static Future<T?> top<T>(BuildContext context, String route,
      [Object? arg]) async {
    return Navigator.pushNamed(context, route, arguments: arg);
  }

  static void pop(BuildContext context, [Object? result]) {
    Navigator.pop(context, result);
  }
}
