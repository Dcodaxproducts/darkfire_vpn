import 'package:darkfire_vpn/common/loading.dart';
import 'package:darkfire_vpn/common/navigation.dart';
import 'package:darkfire_vpn/controllers/ads_controller.dart';
import 'package:darkfire_vpn/controllers/time_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/style.dart';

class AdLoadingDialog extends StatefulWidget {
  const AdLoadingDialog({super.key});

  @override
  State<AdLoadingDialog> createState() => _AdLoadingDialogState();
}

class _AdLoadingDialogState extends State<AdLoadingDialog> {
  @override
  void initState() {
    _showAd();
    super.initState();
  }

  _showAd() {
    AdsController.find.loadInterstitial(interstitialAdUnitID).then((ad) async {
      if (ad != null) {
        await ad.show();
        _addTime();
      }
    });
  }

  _addTime() async {
    await TimeController.find.addExtraTime();
    pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 100.sp),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: Container(
        width: 150.sp,
        padding: pagePadding,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Please wait...',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 24, bottom: 8),
              child: Loading(
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
