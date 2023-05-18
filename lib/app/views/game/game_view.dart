import 'package:flutter/material.dart';
import 'package:proxx/app/views/common/height.dart';

import '../../models/cell.dart';
import '../../models/game.dart';
import '../../router/routes.dart';
import '../../router/screen.dart';
import '../../services/game_sevice.dart';
import '../../utils/log.dart';
import '../common/back.dart';
import '../common/width.dart';
import 'widgets/cell_widget.dart';

class GameView extends StatefulWidget {
  final Game game;
  const GameView(Object? arg, {super.key}) : game = arg as Game;

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  late Game _game = widget.game;
  Key _boardKey = UniqueKey();
  bool _isGameCompleted = false;
  int _openedCellsCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Back(context, Routes.home)),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Height(64),
          _buildBoard(),
          _buildMenu(),
        ],
      ),
    ));
  }

  SizedBox _buildBoard() {
    return SizedBox(
      width: _size,
      height: _size,
      child: GridView.count(
        key: _boardKey,
        crossAxisCount: _game.n,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        children: _game.board
            .expand((row) => row)
            .map((cell) => CellWidget(cell, () => _onCellOpen(cell)))
            .toList(),
      ),
    );
  }

  Widget _buildMenu() {
    return Column(
      children: [
        const Height(64),
        SizedBox(
          height: 50,
          child: !_isGameCompleted
              ? null
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTryAgain(),
                    const Width(40),
                    _buildMainMenu(),
                  ],
                ),
        ),
      ],
    );
  }

  Widget _buildTryAgain() => _button(_onTryAgain, "TRY AGAIN");

  Widget _buildMainMenu() => _button(_onMainMenu, "MAIN MENU");

  Widget _button(void Function() onTap, String text) {
    return SizedBox(
        width: 240,
        height: 50,
        child: ElevatedButton(onPressed: onTap, child: Text(text)));
  }

  double get _size => (_game.n + 4) * 25;

  void _onCellOpen(Cell cell) {
    Log.debug("Opening ${cell.y} ${cell.x} ${cell.isOpen}");
    if (cell.isHole) {
      _onGameLose();
      return;
    }
    _openedCellsCount++;
    if (_isWin) {
      _onGameWin();
      return;
    }
    if (cell.weight == 0) {
      _openNeigbours(cell);
    }
  }

  void _onGameLose() {
    for (var hole in _game.holes) {
      hole.isOpen = true;
      setState(() {
        _boardKey = UniqueKey();
        _isGameCompleted = true;
      });
    }
  }

  bool get _isWin => _game.total - _game.holesCount - _openedCellsCount == 0;

  void _onGameWin() {
    setState(() => _isGameCompleted = true);
  }

  void _onTryAgain() {
    _game = GameService().create(_game.n, _game.holesCount);
    _openedCellsCount = 0;
    setState(() {
      _isGameCompleted = false;
      _boardKey = UniqueKey();
    });
  }

  void _onMainMenu() {
    Screen.set(context, Routes.home);
  }

  void _openNeigbours(Cell cell) {
    //upper line
    _openCell(cell.x - 1, cell.y + 1);
    _openCell(cell.x, cell.y + 1);
    _openCell(cell.x + 1, cell.y + 1);
    //this line
    _openCell(cell.x - 1, cell.y);
    _openCell(cell.x + 1, cell.y);
    // down line
    _openCell(cell.x - 1, cell.y - 1);
    _openCell(cell.x, cell.y - 1);
    _openCell(cell.x + 1, cell.y - 1);
    setState(() => _boardKey = UniqueKey());
  }

  void _openCell(int x, int y) {
    if (y >= 0 && y < _game.n && x >= 0 && x < _game.n) {
      Cell cell = _game.cell(x, y);

      if (!cell.isHole && !cell.isOpen) {
        cell.isOpen = true;
        _onCellOpen(cell);
      }
    }
  }
}
