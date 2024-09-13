// ignore_for_file: library_private_types_in_public_api
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:darkfire_vpn/controllers/ads_controller.dart';
import 'package:darkfire_vpn/controllers/servers_controller.dart';
import 'package:darkfire_vpn/controllers/subscription_controller.dart';
import 'package:darkfire_vpn/controllers/vpn_controller.dart';
import 'package:darkfire_vpn/view/screens/home/home.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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

  bool _disconnected = false;
  bool get disconnected => _disconnected;
  set disconnected(bool value) {
    _disconnected = value;
    if (mounted) setState(() {});
  }

  DateTime _lastShownTime = DateTime.now();
  StreamSubscription<ConnectivityResult>? _onConnectivityChanged;

  @override
  void initState() {
    initData();
    super.initState();
  }

  Future<void> initData() async {
    final result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      disconnected = true;
    }
    await AdsController.find.getAdIds();
    _checkInternetConnection();
    WidgetsBinding.instance.addObserver(this);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      //
      VpnController.find.initialize();
      ServerController.find.getAllServers();
      ServerController.find.getAllServersFromCache();
      //
      // show add
      await loadAppOpenAd()
          .then((value) async => await _appOpenAd?.showIfNotPro())
          .catchError((e) {
        FirebaseCrashlytics.instance.recordError(e, StackTrace.current);
      });
      //
      Future.delayed(const Duration(seconds: 3)).then((value) {
        _ready = true;
        if (mounted) setState(() {});
      });
      await SubscriptionController.find.initialize().catchError((_) {});
    });
  }

  _checkInternetConnection() {
    _onConnectivityChanged = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        disconnected = true;
      } else {
        disconnected = false;
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
        _appOpenAd?.showIfNotPro().catchError((e) {});
        _lastShownTime = DateTime.now();
      }
    } else if (state == AppLifecycleState.paused) {
      loadAppOpenAd();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    if (disconnected) {
      return const NoInternetDialog();
    } else if (_ready) {
      return const HomeScreen();
    } else {
      return const SplashScreen();
    }
  }

  Future loadAppOpenAd() async {
    openAdTimeout?.cancel();
    final AdsController adsController = AdsController.find;
    final String appOpenAdId = adsController.appOpenAdId;
    bool isAdAvailable = adsController.isAdIdActive(appOpenAdId);
    if (!isAdAvailable) {
      _appOpenAd!.dispose();
      _appOpenAd = null;
      return null;
    }
    return AdsController.find
        .loadOpenAd(AdsController.find.appOpenAdId)
        .then((value) {
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
