import 'dart:math';

import 'package:darkfire_vpn/common/primary_button.dart';
import 'package:darkfire_vpn/utils/colors.dart';
import 'package:darkfire_vpn/utils/style.dart';
import 'package:darkfire_vpn/view/base/map_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:darkfire_vpn/controllers/speed_test_controller.dart';
import '../../base/appBar.dart';
import 'widgets/progress_indicator.dart';
import 'widgets/speed_meter.dart';
import 'widgets/speed_type.dart';

class SpeedTestScreen extends StatefulWidget {
  const SpeedTestScreen({super.key});

  @override
  State<SpeedTestScreen> createState() => _SpeedTestScreenState();
}

class _SpeedTestScreenState extends State<SpeedTestScreen> {
  @override
  void dispose() {
    SpeedTestController.find.resetData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const MapBackground(),
          GetBuilder<SpeedTestController>(builder: (con) {
            double meterSize = con.speedGuageSize - 70;
            return Column(
              children: [
                CustomAppBar(text: 'speed_test'.tr),
                SizedBox(height: 32.sp),
                Expanded(
                    child: Padding(
                  padding: pagePadding,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Download Speed Meter
                          Expanded(
                            child: SpeedTypeWidget(
                              label: "download".tr,
                              speed: con.downloadSpeed,
                            ),
                          ),
                          SizedBox(width: defaultSpacing),
                          // Upload Speed Meter,
                          Expanded(
                            child: SpeedTypeWidget(
                              label: "upload".tr,
                              speed: con.uploadSpeed,
                              upload: true,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 32.sp),
                      PrimaryLinearProgressIndicator(value: con.testProgress),
                      SizedBox(height: 32.sp),
                      TweenAnimationBuilder<double>(
                        tween:
                            Tween<double>(begin: 0, end: con.calculatingSpeed),
                        duration: const Duration(seconds: 1),
                        builder: (context, value, child) {
                          return SizedBox(
                            width: con.speedGuageSize,
                            height: con.speedGuageSize,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CustomPaint(
                                  size: Size(meterSize, meterSize),
                                  painter: SpeedometerPainter(
                                    progress: (value / 100).clamp(0, 1),
                                    gaugeSize: meterSize,
                                    strokeWidth: 8,
                                  ),
                                ),
                                // Speed display in the middle
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Download',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      value.toStringAsFixed(2),
                                      style: const TextStyle(
                                        color: primaryColor,
                                        fontSize: 48,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      'Mb/s',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                // Speed labels around the arc
                                ..._buildSpeedLabels(
                                  con.speedGuageSize / 2.1,
                                  con.speedGuageSize / 2,
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      //

                      SizedBox(height: 30.sp),

                      // Start or Cancel Button

                      AnimatedSwitcher(
                        duration: const Duration(seconds: 1),
                        child: SizedBox(
                          width: 200.sp,
                          key: ValueKey(con.isTesting),
                          child: con.isTesting
                              ? PrimaryButton(
                                  text: 'cancel'.tr,
                                  onPressed: con.cancelTesting,
                                  color: primaryColor.withOpacity(0.1),
                                  textColor: primaryColor,
                                )
                              : PrimaryOutlineButton(
                                  text: 'start_test'.tr,
                                  onPressed: con.startTesting,
                                ),
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            );
          }),
        ],
      ),
    );
  }

  List<Widget> _buildSpeedLabels(double radius, double center) {
    List<Widget> labels = [];

    // Define the labels and their corresponding angles (in degrees)
    Map<String, double> labelAngles = {
      '0': 136.36,
      '10': 162.36,
      '20': 188.36,
      '30': 214.36,
      '40': 240.36,
      '50': 266.36, // Midpoint of the arc
      '60': 292.36,
      '70': 318.36,
      '80': 344.36,
      '90': 10.36, // Near the end of the arc
      '100': 36.36, // End at the far right of the arc
    };

    labelAngles.forEach((label, angle) {
      // check if index is after half of list
      double radian = (pi / 180) * (angle + 3.8); // Convert degrees to radians
      double x = center + radius * cos(radian); // Calculate X position
      double y = center + radius * sin(radian); // Calculate Y position

      // Adjust offset based on the angle
      double xOffset = -8;
      double yOffset = -8;

      labels.add(Positioned(
        left: x + xOffset,
        top: y + yOffset,
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      ));
    });

    return labels;
  }
}
