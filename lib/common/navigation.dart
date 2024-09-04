import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> launchScreen(Widget child,
    {bool pushAndRemove = false, bool replace = false}) async {
  const Duration duration = Duration(seconds: 1);
  if (pushAndRemove) {
    return Get.offAll(() => child, duration: duration);
  } else if (replace) {
    return Get.off(() => child, duration: duration);
  } else {
    return Get.to(() => child, duration: duration);
  }
}

void pop() => Get.back();
