import 'dart:async';

import 'package:flutter/material.dart';

import '../../common/loading.dart';
import '../../controllers/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashController get _splashController => SplashController.find;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    _splashController.initSharedData();
    _route();
  }

  _route() async {
    Timer(const Duration(seconds: 1), () async {
      // if (_splashController.isFirstTime) {
      //   launchScreen(const OnboardingScreen(), pushAndRemove: true);
      //   return;
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Loading());
  }
}
