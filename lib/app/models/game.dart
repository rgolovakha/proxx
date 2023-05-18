import 'cell.dart';

class Game {
  /// O(1) cell access by coordinates: x and y
  List<List<Cell>> board;

  /// O(1) holes access in case of lose
  List<Cell> holes;

  Game(this.board)
      : holes =
            board.expand((row) => row).where((cell) => cell.isHole).toList();

  Cell cell(int x, int y) => board[y][x];

  int get n => board.length;

  int get total => n * n;

  int get holesCount => holes.length;
}
