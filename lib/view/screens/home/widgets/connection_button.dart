import 'dart:async';
import 'package:darkfire_vpn/controllers/ads_controller.dart';
import 'package:darkfire_vpn/controllers/vpn_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:iconsax/iconsax.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/style.dart';
import 'package:darkfire_vpn/helper/vpn_helper.dart';

class ConnectionButton extends StatefulWidget {
  const ConnectionButton({super.key});

  @override
  State<ConnectionButton> createState() => _ConnectionButtonState();
}

class _ConnectionButtonState extends State<ConnectionButton> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<VpnController>(builder: (vpnController) {
      String status = vpnController.vpnStage ?? VPNStage.disconnected.name;
      final text = status != 'connected'
          ? 'you_are_not_protected'.tr
          : 'you_are_now_protected'.tr;
      final color = status != 'connected' ? Colors.grey : primaryColor;
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
          ConnectionButtonWidget(
            onTap: _connectButtonClick,
            status: status,
            disconnected: status == 'disconnected',
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
    if (interstitialAd != null) {
      await interstitialAd.showIfNotPro();
    }
  }
}

class ConnectionButtonWidget extends StatelessWidget {
  final Function() onTap;
  final String status;
  final bool disconnected;

  const ConnectionButtonWidget({
    required this.onTap,
    required this.status,
    required this.disconnected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        padding: EdgeInsets.all(8.sp),
        height: 260,
        width: 130,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(100),
          // boxShadow: boxShadow,
          gradient: LinearGradient(
            colors: [
              Theme.of(context).cardColor,
              Theme.of(context).cardColor.withOpacity(0.5),
            ],
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Icon(
                Icons.keyboard_double_arrow_down_rounded,
                size: 40.sp,
                color: Colors.grey,
              ),
            ),
            Positioned(
              top: 10,
              left: 0,
              right: 0,
              child: Icon(
                Icons.keyboard_double_arrow_up_rounded,
                size: 40.sp,
                color: Colors.grey,
              ),
            ),
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              alignment:
                  disconnected ? Alignment.topCenter : Alignment.bottomCenter,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: EdgeInsets.all(5.sp),
                decoration: BoxDecoration(
                  color: getConnetionColor(status).withOpacity(0.05),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Container(
                  padding: pagePadding,
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 20.sp,
                        height: 5.sp,
                        decoration: BoxDecoration(
                            color: getConnetionColor(status),
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    getConnetionColor(status).withOpacity(0.5),
                                blurRadius: 10.sp,
                                spreadRadius: 1.sp,
                              )
                            ]),
                      ),
                      Text(
                        !disconnected ? 'STOP'.tr : 'START'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: EdgeInsets.all(10.sp),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                          gradient: getConnectionButtonGradient(status),
                        ),
                        child: Icon(
                          Icons.power_settings_new_rounded,
                          size: 32.sp,
                          color: Colors.white,
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
    );
  }
}
