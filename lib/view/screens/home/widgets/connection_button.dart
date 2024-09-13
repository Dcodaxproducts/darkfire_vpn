import 'dart:async';
import 'dart:developer';
import 'package:darkfire_vpn/controllers/ads_controller.dart';
import 'package:darkfire_vpn/controllers/vpn_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:iconsax/iconsax.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';
import '../../../../utils/colors.dart';
import '../../../base/animated_widget.dart';
import 'package:darkfire_vpn/helper/vpn_helper.dart';

class ConnectionButton extends StatefulWidget {
  const ConnectionButton({super.key});

  @override
  State<ConnectionButton> createState() => _ConnectionButtonState();
}

class _ConnectionButtonState extends State<ConnectionButton> {
  String convertVpnStageToString(String stage) {
    return stage
        .split('_')
        .map((e) => e[0].toUpperCase() + e.substring(1))
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VpnController>(builder: (vpnController) {
      String status = vpnController.vpnStage ?? VPNStage.disconnected.name;
      final text = status != 'connected'
          ? 'you_are_not_protected'.tr
          : 'you_are_now_protected'.tr;
      final color = status != 'connected' ? Colors.grey : primaryColor;
      bool clickEnabled = status == "connected" || status == "disconnected";
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // you are not protected
          Container(
            margin: EdgeInsets.only(bottom: 32.sp),
            padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.sp),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  status != 'connected'
                      ? Iconsax.shield_cross
                      : Iconsax.shield_tick,
                  size: 20.sp,
                  color: color,
                ),
                SizedBox(width: 5.sp),
                Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: color),
                )
              ],
            ),
          ),
          SizedBox(
            width: 190.sp,
            height: 190.sp,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Center(child: ButtonOutlineWidget(status: status)),
                Center(
                  child: GestureDetector(
                    onTap: clickEnabled ? _connectButtonClick : null,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 150.sp,
                      height: 150.sp,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: getConnectionButtonGradient(status),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          if (connectingStatus.contains(status))
                            Center(
                              child: SizedBox(
                                width: 110.sp,
                                height: 110.sp,
                                child: const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                          Center(
                            child: CustomAnimatedWidget(
                              child: Icon(
                                Icons.power_settings_new,
                                size: 50.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.sp),
          Text(
            status == 'disconnected' ? 'tap_to_connect'.tr : status.tr,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: getConnetionColor(status)),
          ),
        ],
      );
    });
  }

  void _connectButtonClick() {
    var vpnProvider = VpnController.find;
    if (vpnProvider.vpnStage?.toLowerCase() !=
        VPNStage.disconnected.name.toLowerCase()) {
      vpnProvider.disconnect((vpnStatus, vpnConfig) {});
      if (vpnProvider.isConnected) {
        _showInterstitialAd();
      }
    } else {
      vpnProvider.connect();
      _showInterstitialAd();
    }
  }

  Future<void> _showInterstitialAd() async {
    final AdsController adsController = AdsController.find;
    final String interstitialAdId = adsController.interstitialAdId;
    bool isAdAvailable = adsController.isAdIdActive(interstitialAdId);
    if (!isAdAvailable) {
      return;
    }
    InterstitialAd? interstitialAd =
        await adsController.loadInterstitial(interstitialAdId);
    log((interstitialAd == null).toString());
    if (interstitialAd != null) {
      await interstitialAd.showIfNotPro();
    }
  }
}

class ButtonOutlineWidget extends StatelessWidget {
  final String status;
  const ButtonOutlineWidget({required this.status, super.key});

  @override
  Widget build(BuildContext context) {
    final BorderSide borderSide =
        BorderSide(color: getConnetionColor(status), width: 0.5);
    return CustomAnimatedWidget(
      begin: 0.62,
      end: 0.35,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        child: Container(
          padding: EdgeInsets.all(10.sp),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border:
                Border(top: borderSide, right: borderSide, left: borderSide),
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: Container(
              padding: EdgeInsets.all(10.sp),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border(
                    bottom: borderSide, left: borderSide, right: borderSide),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
