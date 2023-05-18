import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proxx/app/views/common/height.dart';

import '../../models/game.dart';
import '../../router/routes.dart';
import '../../router/screen.dart';
import '../../services/game_sevice.dart';
import '../../utils/log.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final TextEditingController _nController = TextEditingController();
  final TextEditingController _holesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildTitle(),
            const Height(64),
            _buildInput("Height-Weight", _nController),
            const Height(16),
            _buildInput("Black holes", _holesController),
            const Height(48),
            _buildStartButton(context),
          ],
        ),
      ),
    ));
  }

  Widget _buildTitle() =>
      const Text("P   R   O   X   X", style: TextStyle(fontSize: 32));

  Widget _buildStartButton(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
            onPressed: () => _onGameStart(context),
            child: const Text("START")));
  }

  Widget _buildInput(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(hintText: hint),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(2),
      ],
    );
  }

  void _onGameStart(BuildContext context) {
    Log.debug(
        "Start pressed n=${_nController.text} holes=${_holesController.text}");
    if (_nController.text.isEmpty || _holesController.text.isEmpty) {
      return;
    }
    int n = int.parse(_nController.text);
    int holesCount = int.parse(_holesController.text);
    Game board = GameService().create(n, holesCount);
    Screen.set(context, Routes.game, board);
  }
}
