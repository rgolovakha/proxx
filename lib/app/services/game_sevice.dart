import '../models/game.dart';
import '../models/cell.dart';
import 'dart:math';

class GameService {
  Game create(int n, int holesCount) {
    List<List<Cell>> board =
        List.generate(n, (y) => List.generate(n, (x) => Cell(x, y)));
    _setRandomHoles(board, holesCount);
    Game game = Game(board);
    return game;
  }

  void _setRandomHoles(List<List<Cell>> board, int holesCount) {
    int n = board.length;
    while (holesCount != 0) {
      int x = Random().nextInt(n);
      int y = Random().nextInt(n);
      Cell cell = board[y][x];
      if (!cell.isHole) {
        cell.isHole = true;
        _calculateHoleTips(cell, board);
        holesCount--;
      }
    }
  }

  void _calculateHoleTips(Cell hole, List<List<Cell>> board) {
    //upper line
    _incWeight(board, hole.x - 1, hole.y + 1);
    _incWeight(board, hole.x, hole.y + 1);
    _incWeight(board, hole.x + 1, hole.y + 1);
    //this line
    _incWeight(board, hole.x - 1, hole.y);
    _incWeight(board, hole.x + 1, hole.y);
    // down line
    _incWeight(board, hole.x - 1, hole.y - 1);
    _incWeight(board, hole.x, hole.y - 1);
    _incWeight(board, hole.x + 1, hole.y - 1);
  }

  void _incWeight(List<List<Cell>> board, x, y) {
    if (y >= 0 && y < board.length && x >= 0 && x < board[0].length) {
      board[y][x].weight++;
    }
  }

  /// Note:
  /// Singleton - yes Single Responsibility is broken here (as part of SOLID).
  /// There is no out of the box solution in flutter like Spring Context and @Autowire
  /// however we can discuss IoC and DI as separate subject
  ///
  /// At the same time - should be not a big problem here because Flutter is
  /// single thread environment
  static final GameService _one = GameService._();
  GameService._();
  factory GameService() => _one;
}
