import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  final double width;
  final Color color;
  final Widget? child;
  const Circle(this.width, this.color, {this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: child,
    );
  }
}
