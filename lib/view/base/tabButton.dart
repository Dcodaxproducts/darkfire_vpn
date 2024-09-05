import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/colors.dart';

class AnimatedTabButton extends StatelessWidget {
  final String text;
  final bool selected;
  final Function()? onTap;
  final Color? color;
  const AnimatedTabButton(
      {required this.text,
      this.onTap,
      this.selected = false,
      this.color,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 8.sp),
        duration: const Duration(milliseconds: 300),
        height: 45.sp,
        decoration: BoxDecoration(
          color: selected ? primaryColor : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(32.sp),
        ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: selected ? Colors.white : color),
          ),
        ),
      ),
    );
  }
}
