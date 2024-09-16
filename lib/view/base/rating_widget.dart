import 'package:darkfire_vpn/common/snackbar.dart';
import 'package:darkfire_vpn/controllers/review_controller.dart';
import 'package:darkfire_vpn/utils/images.dart';
import 'package:darkfire_vpn/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../common/primary_button.dart';

class RatingWidget extends StatefulWidget {
  const RatingWidget({super.key});

  @override
  State<RatingWidget> createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  int rating = 0;
  final _review = TextEditingController();

  void onRatingChanged(int value) {
    setState(() {
      rating = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Wrap(
          children: [
            LottieBuilder.asset(
              "${Images.emojiPath}/$rating.json",
              width: 50.sp,
              height: 50.sp,
              fit: BoxFit.cover,
            ),
          ],
        ),
        SizedBox(height: 16.sp),
        Text(
          titles[rating].tr,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16.sp),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 10.sp,
          children: [
            for (int i = 1; i <= 5; i++)
              GestureDetector(
                onTap: () => onRatingChanged(i),
                child: Icon(
                  Icons.star_rounded,
                  color: i <= rating ? Colors.orange : Colors.grey,
                  size: 34.sp,
                ),
              ),
          ],
        ),
        if (rating <= 3 && rating > 0)
          Column(
            children: [
              SizedBox(height: 16.sp),
              Container(
                padding: pagePadding.copyWith(top: 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.sp),
                  border: Border.all(
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                child: TextField(
                  controller: _review,
                  decoration: InputDecoration(
                    hintText: 'write_your_review'.tr,
                    border: InputBorder.none,
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 3,
                ),
              ),
            ],
          ),
        SizedBox(height: 32.sp),
        SizedBox(
          width: 300.sp,
          child: PrimaryButton(
            text: 'submit'.tr,
            onPressed: _submitReview,
          ),
        ),
      ],
    );
  }

  _submitReview() {
    if (rating > 3) {
      ReviewController.find.launchStore();
      return;
    }
    if (_review.text.isNotEmpty) {
      ReviewController.find
          .saveReview(rating, _review.text.trim())
          .then((value) => Get.back());
    } else {
      showToast('please_write_your_review'.tr);
    }
  }

  // titles for selected rating (0-5)
  List<String> get titles => [
        "please_rate_our_application",
        "thank_you_i_will_continue_to_work_hard",
        "thank_you_i_will_continue_to_work_hard",
        "thank_you_i_will_continue_to_work_hard",
        "thank_you_i_will_continue_to_work_hard",
        "wow_thank_you_so_much",
      ];
}
