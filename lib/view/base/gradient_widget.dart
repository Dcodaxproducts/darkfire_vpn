import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class GradientWidget extends StatelessWidget {
  final Widget child;
  const GradientWidget({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => primaryGradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: child,
    );
  }
}
