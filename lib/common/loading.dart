import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart';

class Loading extends StatelessWidget {
  final Color? color;
  final double? size;
  const Loading({this.color, this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: (size ?? 27).sp,
        width: (size ?? 27).sp,
        child: CircularProgressIndicator(color: color ?? primaryColor),
      ),
    );
  }
}
