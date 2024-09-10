import 'package:darkfire_vpn/common/primary_button.dart';
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
                              fit: StackFit.expand,
                              alignment: Alignment.center,
                              children: [
                                CustomPaint(
                                  size: Size(
                                      con.speedGuageSize, con.speedGuageSize),
                                  painter: SpeedometerPainter(
                                    progress: (value / 100).clamp(0, 1),
                                    gaugeSize: con.speedGuageSize,
                                    strokeWidth: 18,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      con.isDownloading
                                          ? "download".tr
                                          : 'upload'.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: Theme.of(context).hintColor,
                                          ),
                                    ),
                                    SizedBox(height: 16.sp),
                                    Text(
                                      value.toStringAsFixed(1),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 46.sp,
                                          ),
                                    ),
                                    SizedBox(height: 5.sp),
                                    Text(
                                      ' mbps',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      //

                      SizedBox(height: 30.sp),

                      // Start or Cancel Button

                      SizedBox(
                        width: 200.sp,
                        child: PrimaryOutlineButton(
                          text: con.isTesting ? 'cancel'.tr : 'start_test'.tr,
                          onPressed: () {
                            if (con.isTesting) {
                              con.cancelTesting();
                            } else {
                              con.startTesting();
                            }
                          },
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
}
