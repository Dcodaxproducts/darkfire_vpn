import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Widget? icon;
  final Color? color;
  final Color? textColor;
  final double? radius;
  final EdgeInsets? margin;
  const PrimaryButton(
      {required this.text,
      this.onPressed,
      this.icon,
      this.color,
      this.textColor,
      this.margin,
      this.radius,
      super.key});

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = color ?? primaryColor;
    final Color textColor = this.textColor ?? Colors.white;
    return Container(
      margin: margin,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          minimumSize: Size(100.sp, 50.sp),
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 32.sp)),
          disabledBackgroundColor: backgroundColor,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[icon!, SizedBox(width: 8.sp)],
            Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold, color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}

// outline button
class PrimaryOutlineButton extends StatelessWidget {
  final String? text;
  final void Function()? onPressed;
  final Widget? icon;
  final double? radius;
  final Color? textColor;
  final double? width;
  const PrimaryOutlineButton(
      {required this.onPressed,
      this.text,
      this.icon,
      this.radius,
      this.textColor,
      this.width,
      super.key});

  @override
  Widget build(BuildContext context) {
    final Color textColor = this.textColor ?? primaryColor;
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: Size((width ?? 100).sp, 50.sp),
        side: BorderSide(color: Theme.of(context).dividerColor),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular((radius ?? 32).sp)),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[icon!, SizedBox(width: 8.sp)],
          if (text != null)
            Text(
              text!,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold, color: textColor),
            ),
        ],
      ),
    );
  }
}
