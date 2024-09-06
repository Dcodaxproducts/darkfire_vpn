import 'package:darkfire_vpn/common/loading.dart';
import 'package:darkfire_vpn/common/navigation.dart';
import 'package:darkfire_vpn/controllers/ads_controller.dart';
import 'package:darkfire_vpn/controllers/time_controller.dart';
import 'package:darkfire_vpn/utils/app_constants.dart';
import 'package:darkfire_vpn/view/screens/subscription/subscription.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../common/primary_button.dart';
import '../../utils/style.dart';

class AdLoadingDialog extends StatefulWidget {
  final bool hour;
  const AdLoadingDialog({this.hour = false, super.key});

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
      } else {
        pop();
        Get.dialog(const NoAdAvailableDialog());
      }
    });
  }

  _addTime() async {
    await TimeController.find.addExtraTime(hour: widget.hour);
    pop();
    Get.dialog(TimeAddedSuccessDialog(hour: widget.hour));
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

class TimeAddedSuccessDialog extends StatelessWidget {
  final bool hour;
  const TimeAddedSuccessDialog({this.hour = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 40.sp),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: Container(
        width: 320.sp,
        padding: pagePadding,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Congrats!',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.sp),
            Text(
              'You now have an extra ${hour ? 60 : AppConstants.extraTimeInSeconds ~/ 60} minutes of free time.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 32.sp),
            SizedBox(
              width: 200.sp,
              child: PrimaryOutlineButton(
                text: 'close'.tr,
                onPressed: pop,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EnoughTimeDialog extends StatelessWidget {
  const EnoughTimeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 40.sp),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: Container(
        width: 320.sp,
        padding: pagePadding,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Enough Time!',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.sp),
            Text(
              'You already have enough time for VPN. Try again later.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 32.sp),
            SizedBox(
              width: 200.sp,
              child: PrimaryOutlineButton(
                text: 'close'.tr,
                onPressed: pop,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NoAdAvailableDialog extends StatelessWidget {
  const NoAdAvailableDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 40.sp),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: Container(
        width: 320.sp,
        padding: pagePadding,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'No Ad Available!',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.sp),
            Text(
              'Video ads are not available right now. Try again later.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 32.sp),
            Row(
              children: [
                Expanded(
                  child: PrimaryOutlineButton(
                    text: 'check_later'.tr,
                    onPressed: pop,
                  ),
                ),
                SizedBox(width: 16.sp),
                Expanded(
                  child: PrimaryButton(
                    text: 'go_pro'.tr,
                    onPressed: () {
                      pop();
                      launchScreen(const SubscriptionScreen());
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
