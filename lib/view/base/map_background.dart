import 'package:darkfire_vpn/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:particles_fly/particles_fly.dart';

class MapBackground extends StatelessWidget {
  const MapBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return ParticlesFly(
      height: Get.height,
      width: Get.width,
      connectDots: true,
      numberOfParticles: 100,
      particleColor: particleColor,
      lineColor: particleColor,
      speedOfParticles: 0.3,
      awayRadius: 100.sp,
    );
  }

  Color get particleColor => primaryColor.withOpacity(0.04);
}
