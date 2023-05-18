import 'package:flutter/material.dart';

import '../utils/log.dart';
import '../views/game/game_view.dart';
import '../views/home/home_view.dart';

class Routes {
  static const home = '/';
  static const game = '/game';

  static final Map<String, Widget Function(Object? arg)> _map = {
    home: (_) => HomeView(),
    game: (arg) => GameView(arg),
  };

  static Widget get(String name, Object? arg) {
    Log.info("Route to '$name'");
    return _map[name]!.call(arg);
  }
}
