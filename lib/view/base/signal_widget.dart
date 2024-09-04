import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignalBar extends StatelessWidget {
  final int signalStrength;
  const SignalBar({required this.signalStrength, super.key});

  @override
  Widget build(BuildContext context) {
    int activeBars = _calculateActiveBars();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (int i = 0; i < 4; i++)
          Padding(
            padding: EdgeInsets.only(right: 2.sp),
            child: Container(
              width: 3.sp,
              height: (4 * (i + 1)).sp,
              decoration: BoxDecoration(
                color:
                    i < activeBars ? _getSignalColor(activeBars) : Colors.grey,
                borderRadius: BorderRadius.circular(2.sp),
              ),
            ),
          ),
      ],
    );
  }

  Color _getSignalColor(int activeBars) {
    // Customize colors if needed based on the bar index
    switch (activeBars) {
      case 4:
        return Colors.green;
      case 3:
        return Colors.orange;
      case 2:
        return Colors.red;
      default:
        return Colors.red;
    }
  }

  int _calculateActiveBars() {
    if (signalStrength <= 80) {
      return 4;
    } else if (signalStrength <= 150) {
      return 3;
    } else if (signalStrength <= 300) {
      return 2;
    } else {
      return 1;
    }
  }
}
