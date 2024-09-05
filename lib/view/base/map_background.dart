import 'package:darkfire_vpn/utils/colors.dart';
import 'package:flutter/material.dart';
import '../../utils/images.dart';

class MapBackground extends StatelessWidget {
  const MapBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Images.map,
      fit: BoxFit.cover,
      color: primaryColor,
    );
  }
}
