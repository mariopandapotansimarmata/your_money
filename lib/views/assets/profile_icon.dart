import 'package:flutter/material.dart';

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({
    super.key,
    this.size = 45,
  });
  final double size;

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
        Icons.person,
        size: size * 0.9,
      ),
    );
  }
}
