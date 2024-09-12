import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../common/navigation.dart';
import '../../common/primary_button.dart';
import '../../utils/style.dart';

showConfirmationDialog({
  required String title,
  required String description,
  required String noText,
  required String yesText,
  required Function() onYes,
}) {
  Get.dialog(ConfirmationDialog(
    title: title,
    description: description,
    noText: noText,
    yesText: yesText,
    onYes: onYes,
  ));
}

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String description;
  final String noText;
  final String yesText;
  final Function() onYes;

  const ConfirmationDialog({
    required this.title,
    required this.description,
    required this.noText,
    required this.yesText,
    required this.onYes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 30.sp),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: Container(
        padding: pagePadding,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title.tr,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.sp),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.sp),
              child: Text(
                description.tr,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 32.sp),
            // buttons,
            Row(
              children: [
                Expanded(
                  child: PrimaryOutlineButton(
                    text: noText.tr,
                    onPressed: pop,
                  ),
                ),
                SizedBox(width: 10.sp),
                Expanded(
                  child: PrimaryButton(
                    text: yesText.tr,
                    onPressed: onYes,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
