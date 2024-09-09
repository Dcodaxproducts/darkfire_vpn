// ignore_for_file: library_private_types_in_public_api
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:darkfire_vpn/controllers/ads_controller.dart';
import 'package:darkfire_vpn/controllers/iap_controller.dart';
import 'package:darkfire_vpn/controllers/servers_controller.dart';
import 'package:darkfire_vpn/controllers/vpn_controller.dart';
import 'package:darkfire_vpn/view/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'helper/vpn_helper.dart';
import 'view/base/no_internet_dialog.dart';
import 'view/screens/splash/splash.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> with WidgetsBindingObserver {
  bool _ready = false;
  AppOpenAd? _appOpenAd;
  Timer? openAdTimeout;

  DateTime _lastShownTime = DateTime.now();
  StreamSubscription<ConnectivityResult>? _onConnectivityChanged;

  @override
  void initState() {
    initData();
    super.initState();
  }

  Future<void> initData() async {
    _checkInternetConnection();
    VpnController.find.initialize();
    ServerController.find.getAllServers();
    ServerController.find.getAllServersFromCache();
    //
    WidgetsBinding.instance.addObserver(this);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      Future.delayed(const Duration(seconds: 5)).then((value) {
        if (!_ready) {
          _ready = true;
          if (mounted) setState(() {});
        }
      });
      await IAPController.find.initialize().catchError((_) {});
      await loadAppOpenAd()
          .then((value) => _appOpenAd?.showIfNotPro())
          .catchError((_) {});
      Future.delayed(const Duration(seconds: 3), () {
        _ready = true;
        if (mounted) setState(() {});
      });
    });
  }

  _checkInternetConnection() {
    _onConnectivityChanged = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        SmartDialog.show(
          builder: (_) => const NoInternetDialog(),
          backDismiss: false,
        );
      } else {
        SmartDialog.dismiss();
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    openAdTimeout?.cancel();
    _onConnectivityChanged?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (_lastShownTime.difference(DateTime.now()).inMinutes > 5) {
        _appOpenAd?.showIfNotPro();
        _lastShownTime = DateTime.now();
      }
    } else if (state == AppLifecycleState.paused) {
      loadAppOpenAd();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return _ready ? const HomeScreen() : const SplashScreen();
  }

  Future loadAppOpenAd() async {
    openAdTimeout?.cancel();
    return AdsController.find
      ..loadOpenAd(openAdUnitID).then((value) {
        if (value != null) {
          _appOpenAd = value;
          _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              _appOpenAd!.dispose();
              _appOpenAd = null;
              loadAppOpenAd();
            },
          );
        } else {
          openAdTimeout = Timer(const Duration(minutes: 1), loadAppOpenAd);
        }
        return value;
      });
  }
}
