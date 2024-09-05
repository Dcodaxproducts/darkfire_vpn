import 'package:darkfire_vpn/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Custom Animated Progress Bar Widget
class AnimatedProgressBar extends StatefulWidget {
  final Duration duration;
  final Color color;

  const AnimatedProgressBar({
    Key? key,
    required this.duration,
    this.color = primaryColor, // Default color
  }) : super(key: key);

  @override
  AnimatedProgressBarState createState() => AnimatedProgressBarState();
}

class AnimatedProgressBarState extends State<AnimatedProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration, // Use the duration passed via the widget
    )..repeat(); // Repeat the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return SizedBox(
            height: 6.sp,
            child: LinearProgressIndicator(
              value: _controller.value, // Progress from 0 to 1
              valueColor: AlwaysStoppedAnimation<Color>(
                  widget.color), // Use custom color
              borderRadius: BorderRadius.circular(10.sp),
            ),
          );
        },
      ),
    );
  }
}
