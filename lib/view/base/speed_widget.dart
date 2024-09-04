import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpeedWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final String speed;
  const SpeedWidget(
      {required this.title,
      required this.icon,
      required this.iconColor,
      required this.speed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // title,
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        SizedBox(height: 8.sp),
        // speed,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18.sp, color: iconColor),
            SizedBox(width: 8.sp),
            Text(
              speed,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
