import 'package:darkfire_vpn/utils/images.dart';
import 'package:darkfire_vpn/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../common/primary_button.dart';

class RatingWidget extends StatefulWidget {
  final int rating;
  final Function(int) onRatingChanged;
  final Function() onSubmitted;
  const RatingWidget(
      {required this.rating,
      required this.onRatingChanged,
      required this.onSubmitted,
      super.key});

  @override
  State<RatingWidget> createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  final _review = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          children: [
            LottieBuilder.asset(
              "${Images.emojiPath}/${widget.rating}.json",
              width: 50.sp,
              height: 50.sp,
              fit: BoxFit.cover,
            ),
          ],
        ),
        SizedBox(height: 16.sp),
        Text(
          titles[widget.rating],
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
                onTap: () => widget.onRatingChanged(i),
                child: Icon(
                  Icons.star_rounded,
                  color: i <= widget.rating ? Colors.orange : Colors.grey,
                  size: 34.sp,
                ),
              ),
          ],
        ),
        if (widget.rating <= 3 && widget.rating > 0)
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
            onPressed: widget.onSubmitted,
          ),
        ),
      ],
    );
  }

  // titles for selected rating (0-5)
  List<String> get titles => [
        "Please rate our application",
        "Thank you , I will Continue to work hard",
        "Thank you , I will Continue to work hard",
        "Thank you , I will Continue to work hard",
        "Thank you , I will Continue to work hard",
        "Wow , Thank you so much",
      ];
}
