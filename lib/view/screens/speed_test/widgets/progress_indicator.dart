import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryLinearProgressIndicator extends StatelessWidget {
  final double value;
  const PrimaryLinearProgressIndicator({required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: value),
      duration: const Duration(seconds: 1),
      builder: (context, value, child) {
        return SizedBox(
          height: 3.sp,
          child: LinearProgressIndicator(
            value: value / 100,
            valueColor:
                AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8.sp),
          ),
        );
      },
    );
  }
}
