import 'dart:async';
import 'dart:convert';
import 'package:darkfire_vpn/controllers/subscription_controller.dart';
import 'package:darkfire_vpn/data/model/response/ad_model.dart';
import 'package:darkfire_vpn/data/repository/ad_repo.dart';
import 'package:darkfire_vpn/utils/app_constants.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsController extends GetxController implements GetxService {
  final AdRepo adRepo;
  AdsController({required this.adRepo});
  static AdsController get find => Get.find<AdsController>();

  String _appOpenAdId = AppConstants.appOpenAdID;
  String _rewardVideAdId = AppConstants.rewardAdId;
  String _interstitialAdId = AppConstants.interstitialAdID;
  final Map<String, bool> _adStatus = {};

  String get appOpenAdId => _appOpenAdId;
  String get rewardVideAdId => _rewardVideAdId;
  String get interstitialAdId => _interstitialAdId;
  Map<String, bool> get adStatus => _adStatus;

  set appOpenAdId(String value) {
    _appOpenAdId = value;
    update();
  }

  set rewardVideAdId(String value) {
    _rewardVideAdId = value;
    update();
  }

  set interstitialAdId(String value) {
    _interstitialAdId = value;
    update();
  }

  Future<String> getAdIds() async {
    final response = await adRepo.getAdIds();
    if (response != null) {
      final data = jsonDecode(response.body)['data'];
      List<AdModel> ads = [];
      for (var item in data) {
        ads.add(AdModel.fromJson(item));
      }
      for (var ad in ads) {
        switch (ad.type) {
          case 'app_open':
            appOpenAdId = ad.adId;
            _adStatus[appOpenAdId] = ad.status == 1;
            break;
          case 'reward':
            rewardVideAdId = ad.adId;
            _adStatus[rewardVideAdId] = ad.status == 1;
            break;
          case 'interstitial':
            interstitialAdId = ad.adId;
            _adStatus[interstitialAdId] = ad.status == 1;
            break;
        }
      }
    }
    return 'done';
  }

  bool isAdIdActive(String adId) {
    return _adStatus[adId] ?? false;
  }

  void initialize() {
    final params = ConsentRequestParameters();
    ConsentInformation.instance.requestConsentInfoUpdate(params, () {
      ConsentInformation.instance.isConsentFormAvailable().then((value) {
        loadForm();
      });
    }, (error) {});
  }

  void loadForm() {
    ConsentForm.loadConsentForm((consentForm) async {
      if (await ConsentInformation.instance.getConsentStatus() ==
          ConsentStatus.required) {
        consentForm.show((formError) {});
      }
    }, (formError) {});
  }

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
          if (!completer.isCompleted) {
            completer.complete();
          }
          return null;
        },
      );
    } catch (e) {
      return null;
    }
  }

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
