import 'package:darkfire_vpn/data/model/body/subscription_model.dart';
import 'package:darkfire_vpn/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/colors.dart';

class PurchaseItem extends StatelessWidget {
  final SubscriptionModel item;
  final bool selected;
  final Function()? onTap;
  const PurchaseItem(
      {required this.item, required this.selected, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(defaultRadius),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(defaultRadius),
          border: Border.all(
            color:
                selected ? Theme.of(context).primaryColor : Colors.transparent,
            width: 1.sp,
          ),
          boxShadow: boxShadow,
        ),
        child: Row(
          children: [
            // selected container,
            Container(
              width: 18.sp,
              height: 18.sp,
              padding: EdgeInsets.all(3.sp),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? primaryColor : Colors.grey,
                  width: 1.sp,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: selected ? primaryColor : Colors.transparent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            SizedBox(width: defaultSpacing),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    durationString + (item.featured ? ' (Popular)' : ''),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 3.sp),
                  Text(
                    item.name,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 11.sp,
                          color: Theme.of(context).hintColor,
                        ),
                  ),
                ],
              ),
            ),
            SizedBox(width: defaultSpacing),
            Text(
              item.price,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  String get durationString {
    // 7 -> 1 week
    // 30 or 31 -> 1 month
    // 365 -> 1 year
    if (item.duration.inDays == 7) {
      return '1 week';
    } else if (item.duration.inDays == 30 || item.duration.inDays == 31) {
      return '1 month';
    } else if (item.duration.inDays == 365) {
      return '1 year';
    } else {
      return '${item.duration.inDays} days';
    }
  }
}
