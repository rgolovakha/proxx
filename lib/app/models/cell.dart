class Cell {
  final int x;
  final int y;
  bool isHole = false;
  int weight = 0;
  bool isOpen = false;

  Cell(this.x, this.y);
}
