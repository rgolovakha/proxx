import 'package:flutter/material.dart';

import '../../../models/cell.dart';
import '../../common/circle.dart';

class CellWidget extends StatefulWidget {
  final Cell cell;
  final void Function() onOpen;
  const CellWidget(this.cell, this.onOpen, {super.key});

  @override
  State<CellWidget> createState() => _CellWidgetState();
}

class _CellWidgetState extends State<CellWidget> {
  late bool _isOpen = widget.cell.isOpen;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onCellTap,
      child: Container(
        decoration:
            BoxDecoration(color: Colors.grey.withOpacity(!_isOpen ? 1 : 0.5)),
        child: !_isOpen ? null : _buildOpenedCell(widget.cell),
      ),
    );
  }

  Widget _buildOpenedCell(Cell cell) {
    return cell.isHole ? _buildHole() : _buildTip(cell.weight);
  }

  Widget _buildHole() {
    return const Padding(
      padding: EdgeInsets.all(12),
      child: Circle(5, Colors.black),
    );
  }

  Widget _buildTip(int count) {
    return Center(
        child: Text(count == 0 ? "" : "$count",
            style: const TextStyle(fontSize: 20)));
  }

  void _onCellTap() {
    if (_isOpen) return;
    widget.cell.isOpen = true;
    setState(() => _isOpen = true);
    widget.onOpen();
  }
}
