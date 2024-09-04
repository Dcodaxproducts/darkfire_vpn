import 'package:flutter/material.dart';
import '../../../../utils/style.dart';
import 'connection_button.dart';

class DisconnectedView extends StatelessWidget {
  const DisconnectedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: pagePadding,
      child: const Column(
        children: [ConnectionButton()],
      ),
    );
  }
}
