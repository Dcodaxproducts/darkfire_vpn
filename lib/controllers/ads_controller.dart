import 'dart:async';
import 'dart:developer';
import 'package:darkfire_vpn/controllers/subscription_controller.dart';
import 'package:darkfire_vpn/utils/app_constants.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

const String interstitialAdUnitID = "ca-app-pub-3940256099942544/1033173712";
const String bannerAdUnitID = "ca-app-pub-3940256099942544/6300978111";
const String interstitialRewardAdUnitID =
    "ca-app-pub-3940256099942544/5354046379";
const String openAdUnitID = "ca-app-pub-3940256099942544/9257395921";

///All ad's functions related
class AdsController extends GetxController implements GetxService {
  static AdsController get find => Get.find<AdsController>();

  ///Initialize context, so you can access context inside the provider
  ///without passing it manually through params
  void initialize() {
    final params = ConsentRequestParameters();
    ConsentInformation.instance.requestConsentInfoUpdate(params, () {
      ConsentInformation.instance.isConsentFormAvailable().then((value) {
        loadForm();
      });
    }, (error) {});
  }

  ///Load consent form for ads
  void loadForm() {
    ConsentForm.loadConsentForm((consentForm) async {
      if (await ConsentInformation.instance.getConsentStatus() ==
          ConsentStatus.required) {
        consentForm.show((formError) {});
      }
    }, (formError) {});
  }

  ///Initialize and load interstitial ad,
  ///it will return [InterstitialAd] that you can use to show interstitial ad
  ///
  ///[null] if it fail to fetch
  Future<InterstitialAd?> loadInterstitial(String unitId) async {
    if (SubscriptionController.find.isPro) return null;
    Completer<InterstitialAd?> completer = Completer();
    InterstitialAd.load(
      adUnitId: unitId,
      request: AppConstants.adRequest,
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          if (!completer.isCompleted) {
            completer.complete(ad);
            FirebaseAnalytics.instance.logAdImpression();
          }
        },
        onAdFailedToLoad: (error) {
          if (!completer.isCompleted) {
            completer.complete();
          }
        },
      ),
    );

    // Wait for ad to load or timeout (whichever happens first)
    try {
      return await completer.future.timeout(
        const Duration(seconds: 4),
        onTimeout: () {
          log('Interstitial ad load timeout');
          if (!completer.isCompleted) {
            completer.complete();
          }
          return null;
        },
      );
    } catch (e) {
      log('Interstitial ad load error: $e');
      return null;
    }
  }

  ///Initialize and load open app ad,
  ///it will return [OpenAppAd] that you can use to show open app ad
  ///
  ///[null] if it fail to fetch
  Future<AppOpenAd?> loadOpenAd(String unitId) async {
    if (SubscriptionController.find.isPro) return null;
    Completer<AppOpenAd?> completer = Completer();
    AppOpenAd.load(
      adUnitId: unitId,
      request: AppConstants.adRequest,
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          if (!completer.isCompleted) {
            completer.complete(ad);
            FirebaseAnalytics.instance.logAdImpression();
          }
        },
        onAdFailedToLoad: (error) {
          if (!completer.isCompleted) {
            completer.complete();
          }
        },
      ),
    );
    // Use Future.timeout to enforce a 5-second limit
    try {
      return await completer.future.timeout(const Duration(seconds: 4),
          onTimeout: () {
        if (!completer.isCompleted) {
          completer.complete(); // Complete with null if timeout occurs
        }
        return null; // Return null on timeout
      });
    } catch (e) {
      return null; // Return null in case of any unexpected errors
    }
  }

  ///Initialize and load reward ad,
  ///it will return [RewardedInterstitialAd] that you can use to show reward ad
  ///
  ///[null] if it fail to fetch
  Future<RewardedInterstitialAd?> loadRewardAd(String unitId) async {
    Completer<RewardedInterstitialAd?> completer = Completer();
    RewardedInterstitialAd.load(
      adUnitId: unitId,
      request: AppConstants.adRequest,
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          if (!completer.isCompleted) {
            completer.complete(ad);
            FirebaseAnalytics.instance.logAdImpression();
          }
        },
        onAdFailedToLoad: (error) {
          if (!completer.isCompleted) {
            completer.complete();
          }
        },
      ),
    );
    // Wait for ad to load or timeout (whichever happens first)
    try {
      return await completer.future.timeout(
        const Duration(seconds: 4),
        onTimeout: () {
          if (!completer.isCompleted) {
            completer.complete(); // Complete with null on timeout
          }
          return null; // Return null on timeout
        },
      );
    } catch (e) {
      return null; // Return null on error
    }
  }

  ///Its banner static's functions
  ///
  ///It will load and fetch banner ad and show it as Widget
  ///return [SizedBox] if fail to fetch
  static Widget bannerAd(String unitId, {AdSize adsize = AdSize.banner}) {
    var banner = BannerAd(
      adUnitId: unitId,
      size: adsize,
      listener: BannerAdListener(
        onAdImpression: (ad) {
          FirebaseAnalytics.instance.logAdImpression();
        },
      ),
      request: AppConstants.adRequest,
    );
    return GetBuilder<SubscriptionController>(
      builder: (con) => con.isPro
          ? const SizedBox.shrink()
          : SizedBox(
              key: Key(unitId),
              height: adsize.height.toDouble(),
              width: adsize.width.toDouble(),
              child: FutureBuilder(
                future: banner.load(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return AdWidget(ad: banner);
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
    );
  }
}
