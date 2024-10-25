import 'package:flutter/material.dart';

class MapBackground extends StatelessWidget {
  const MapBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/map1.png',
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.3),
    );
  }
}
