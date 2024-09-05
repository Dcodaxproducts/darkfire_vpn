import 'package:darkfire_vpn/view/base/divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../common/navigation.dart';
import '../../common/primary_button.dart';
import '../../utils/style.dart';

class Updatenotavailabledialog extends StatelessWidget {
  const Updatenotavailabledialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 30.sp),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: Container(
        width: 400.sp,
        padding: pagePadding,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'update_not_available'.tr,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            CustomDivider(padding: 15.sp),
            Text(
              'update_not_available_message'.tr,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 25.sp),
            SizedBox(
              width: 120.sp,
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
