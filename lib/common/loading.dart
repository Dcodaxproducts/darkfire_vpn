import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart';

class Loading extends StatelessWidget {
  final Color? color;
  const Loading({this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 27.sp,
        width: 27.sp,
        child: CircularProgressIndicator(color: color ?? primaryColor),
      ),
    );
  }
}
