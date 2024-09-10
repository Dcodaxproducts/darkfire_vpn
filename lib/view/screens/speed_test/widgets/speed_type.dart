import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class SpeedTypeWidget extends StatelessWidget {
  final String label;
  final double speed;
  final bool upload;
  const SpeedTypeWidget(
      {required this.label,
      required this.speed,
      this.upload = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              upload ? Iconsax.arrow_up_1 : Iconsax.arrow_down_2,
              color: upload ? Colors.purple : Colors.blue,
              size: 20.sp,
            ),
            SizedBox(width: 8.sp),
            Text(
              label.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              ' Mbps',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Theme.of(context).hintColor),
            ),
          ],
        ),
        SizedBox(height: 8.sp),
        Text(
          speed == 0 ? '--' : speed.toStringAsFixed(2),
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: 32.sp,
              ),
        ),
      ],
    );
  }
}
