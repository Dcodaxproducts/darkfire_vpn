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
        return Colors.green;
      case 2:
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  int _calculateActiveBars() {
    // RangeValues bar4 = const RangeValues(0, 120);
    // RangeValues bar3 = const RangeValues(121, 300);
    // RangeValues bar2 = const RangeValues(301, 450);

    // if (bar4.start <= signalStrength && signalStrength <= bar4.end) {
    //   return 4;
    // } else if (bar3.start <= signalStrength && signalStrength <= bar3.end) {
    //   return 3;
    // } else if (bar2.start <= signalStrength && signalStrength <= bar2.end) {
    //   return 2;
    // } else if (signalStrength >= bar2.end) {
    //   return 1;
    // } else {
    //   return 0;
    // }

    // if signalStrength is greater than 300 return 2 bar else 4 bar
    return signalStrength >= 300 ? 2 : 4;
  }
}
