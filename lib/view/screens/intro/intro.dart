import 'package:darkfire_vpn/view/base/map_background.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          MapBackground(),
        ],
      ),
    );
  }
}
