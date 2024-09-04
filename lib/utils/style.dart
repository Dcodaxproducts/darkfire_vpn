// ignore_for_file: constant_identifier_names, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

EdgeInsets get pagePadding => EdgeInsets.all(16.sp);
double get defaultRadius => 10.sp;
double get defaultSpacing => 10.sp;

List<BoxShadow> get shadow => [
      BoxShadow(
        color: Theme.of(Get.context!).shadowColor.withOpacity(0.2),
        offset: const Offset(0, 0),
        blurRadius: 2,
      )
    ];
