import 'package:flutter/material.dart';

class TranscIcon extends StatelessWidget {
  const TranscIcon({
    super.key,
    this.size = 45,
    required this.icon,
    this.color = Colors.black,
  });
  final double size;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              50,
            ),
            color: Colors.white),
        child: Icon(
          icon,
          size: size * 0.9,
          color: color,
        ));
  }
}
